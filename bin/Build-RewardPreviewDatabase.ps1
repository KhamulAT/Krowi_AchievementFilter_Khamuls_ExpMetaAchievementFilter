param(
    [string]$OutputPath = "DataSources\\RewardPreviewDB.lua",
    [string]$RawCachePath = "tmp\AchievementRewardsRaw.json",
    [string]$OverridesPath = "tmp\AchievementRewardsOverrides.json",
    [string]$ItemSpellCachePath = "tmp\ItemSpellLookupCache.json",
    [string]$NpcDisplayCachePath = "tmp\NpcDisplayLookupCache.json",
    [string]$ItemRewardCachePath = "tmp\ItemRewardLookupCache.json",
    [string]$SpellRewardCachePath = "tmp\SpellRewardLookupCache.json",
    [int]$DelayMs = 350,
    [int]$TimeoutSec = 20,
    [int]$MaxRetries = 3,
    [bool]$DebugOutput = $true,
    [switch]$ForceRescan,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$ErrorActionPreference = "Stop"

if ($ExtraArgs -contains "--force-rescan") {
    $ForceRescan = $true
}

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )

    if (-not $DebugOutput) {
        return
    }

    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host ("[{0}][{1}] {2}" -f $timestamp, $Level, $Message)
}

function Ensure-ParentDirectory {
    param([string]$Path)

    $parent = Split-Path -Path $Path -Parent
    if ($parent -and -not (Test-Path -Path $parent)) {
        New-Item -Path $parent -ItemType Directory | Out-Null
    }
}

function ConvertTo-HashtableRecursive {
    param($InputObject)

    if ($null -eq $InputObject) {
        return $null
    }

    if ($InputObject -is [System.Collections.IDictionary]) {
        $map = @{}
        foreach ($key in $InputObject.Keys) {
            $map[[string]$key] = ConvertTo-HashtableRecursive $InputObject[$key]
        }
        return $map
    }

    if ($InputObject -is [PSCustomObject]) {
        $map = @{}
        foreach ($prop in $InputObject.PSObject.Properties) {
            $map[[string]$prop.Name] = ConvertTo-HashtableRecursive $prop.Value
        }
        return $map
    }

    if (($InputObject -is [System.Collections.IEnumerable]) -and -not ($InputObject -is [string])) {
        $arr = @()
        foreach ($item in $InputObject) {
            $arr += ,(ConvertTo-HashtableRecursive $item)
        }
        return $arr
    }

    return $InputObject
}

function Get-AchievementIdsFromDir {
    param([string]$Path)

    Write-Log "Scanning data source directory: $Path"
    $ids = New-Object System.Collections.Generic.HashSet[int]

    # When scanning per-category directories we must include all .lua files in that directory.
    # Excluding Decor/Pet/Meta filenames here can produce an empty source set and wipe incremental behavior.
    $files = Get-ChildItem -Path $Path -Filter *.lua -File

    foreach ($file in $files) {
        $before = $ids.Count
        Get-Content $file.FullName | ForEach-Object {
            $line = $_
            if ($line -match '^\s*(\d{3,6})\s*,\s*(--|$)') { [void]$ids.Add([int]$Matches[1]) }
            if ($line -match 'GetAchievementName\((\d{3,6})') { [void]$ids.Add([int]$Matches[1]) }
            if ($line -match '^\s*return\s+(\d{3,6})\s*$') { [void]$ids.Add([int]$Matches[1]) }
        }
        $added = $ids.Count - $before
        Write-Log ("{0}: +{1} IDs (total {2})" -f $file.Name, $added, $ids.Count)
    }

    Write-Log ("Finished scanning {0}: {1} unique IDs" -f $Path, $ids.Count)
    return @($ids)
}

function Pair-Key {
    param($Pair)

    $arr = @($Pair)
    if ($arr.Count -lt 2) {
        return $null
    }

    return ("{0}:{1}" -f [int]$arr[0], [int]$arr[1])
}

function Normalize-PairList {
    param($Pairs)

    $inputArr = @($Pairs)
    if ($inputArr.Count -eq 0) {
        return @()
    }

    # Handle flattened single pair shape: @(type, id)
    if ($inputArr.Count -eq 2 `
        -and -not ($inputArr[0] -is [System.Collections.IEnumerable] -and -not ($inputArr[0] -is [string])) `
        -and -not ($inputArr[1] -is [System.Collections.IEnumerable] -and -not ($inputArr[1] -is [string]))) {
        try {
            return @(@([int]$inputArr[0], [int]$inputArr[1]))
        }
        catch {
            return @()
        }
    }

    $normalized = @()
    foreach ($pair in $inputArr) {
        $arr = @($pair)
        if ($arr.Count -lt 2) {
            continue
        }
        try {
            $normalized += ,@([int]$arr[0], [int]$arr[1])
        }
        catch {
        }
    }
    return $normalized
}

function Expand-PairsForProcessing {
    param($Pairs)

    $items = @($Pairs)
    if ($items.Count -eq 0) {
        return @()
    }

    $allScalars = $true
    foreach ($item in $items) {
        if (($item -is [System.Collections.IEnumerable]) -and -not ($item -is [string])) {
            $allScalars = $false
            break
        }
    }

    $pairs = @()
    if ($allScalars) {
        for ($i = 0; $i -lt ($items.Count - 1); $i += 2) {
            try {
                $pairs += ,@([int]$items[$i], [int]$items[$i + 1])
            }
            catch {
            }
        }
        return $pairs
    }

    foreach ($pair in $items) {
        $arr = @($pair)
        if ($arr.Count -lt 2) {
            continue
        }
        try {
            $pairs += ,@([int]$arr[0], [int]$arr[1])
        }
        catch {
        }
    }
    return $pairs
}

function Convert-ToRewardPairs {
    param($Rewards)

    $result = @()
    if ($null -eq $Rewards) {
        return @()
    }

    # Accept wrapper objects like { rewards = [...] } or { Rewards = [...] }.
    if (($Rewards -is [PSCustomObject]) -or ($Rewards -is [System.Collections.IDictionary])) {
        $obj = ConvertTo-HashtableRecursive $Rewards
        if ($obj -is [hashtable]) {
            if ($obj.ContainsKey("rewards")) { return @(Convert-ToRewardPairs $obj["rewards"]) }
            if ($obj.ContainsKey("Rewards")) { return @(Convert-ToRewardPairs $obj["Rewards"]) }
        }
    }

    # Accept single reward object forms like { type = 3, id = 123 }.
    $singleObj = ConvertTo-HashtableRecursive $Rewards
    if ($singleObj -is [hashtable]) {
        $hasTypeId = ($singleObj.ContainsKey("type") -or $singleObj.ContainsKey("rewardType") -or $singleObj.ContainsKey("0")) `
            -and ($singleObj.ContainsKey("id") -or $singleObj.ContainsKey("rewardID") -or $singleObj.ContainsKey("itemID") -or $singleObj.ContainsKey("1"))
        if ($hasTypeId) {
            try {
                $rtypeRaw = if ($singleObj.ContainsKey("type")) { $singleObj["type"] } elseif ($singleObj.ContainsKey("rewardType")) { $singleObj["rewardType"] } else { $singleObj["0"] }
                $ridRaw = if ($singleObj.ContainsKey("id")) { $singleObj["id"] } elseif ($singleObj.ContainsKey("rewardID")) { $singleObj["rewardID"] } elseif ($singleObj.ContainsKey("itemID")) { $singleObj["itemID"] } else { $singleObj["1"] }
                $rtype = [int]$rtypeRaw
                $rid = [int]$ridRaw
                return @(@($rtype, $rid))
            }
            catch {
                return @()
            }
        }
    }

    # Accept a direct pair like @(3, 12345).
    $asArray = @($Rewards)
    if ($asArray.Count -eq 2 -and ($asArray[0] -isnot [System.Collections.IEnumerable] -or $asArray[0] -is [string])) {
        try {
            return @(@([int]$asArray[0], [int]$asArray[1]))
        }
        catch {
        }
    }

    foreach ($reward in @($Rewards)) {
        $normalized = ConvertTo-HashtableRecursive $reward
        if ($normalized -is [hashtable]) {
            $rtypeRaw = $null
            $ridRaw = $null
            if ($normalized.ContainsKey("type")) { $rtypeRaw = $normalized["type"] }
            elseif ($normalized.ContainsKey("rewardType")) { $rtypeRaw = $normalized["rewardType"] }
            elseif ($normalized.ContainsKey("0")) { $rtypeRaw = $normalized["0"] }

            if ($normalized.ContainsKey("id")) { $ridRaw = $normalized["id"] }
            elseif ($normalized.ContainsKey("rewardID")) { $ridRaw = $normalized["rewardID"] }
            elseif ($normalized.ContainsKey("itemID")) { $ridRaw = $normalized["itemID"] }
            elseif ($normalized.ContainsKey("1")) { $ridRaw = $normalized["1"] }

            if ($null -ne $rtypeRaw -and $null -ne $ridRaw) {
                try {
                    $result += ,@([int]$rtypeRaw, [int]$ridRaw)
                }
                catch {}
            }
            continue
        }

        $arr = @($reward)
        if ($arr.Count -ge 2) {
            try {
                $rewardType = [int]$arr[0]
                $rewardId = [int]$arr[1]
                $result += ,@($rewardType, $rewardId)
            }
            catch {}
        }
    }

    return $result
}

function Add-UniquePairs {
    param(
        [object[]]$BasePairs,
        [object[]]$PairsToAdd
    )

    $output = @()
    $seen = @{}

    foreach ($pair in @(Expand-PairsForProcessing $BasePairs)) {
        $key = Pair-Key $pair
        if (-not $key) { continue }
        if (-not $seen.ContainsKey($key)) {
            $seen[$key] = $true
            $output += ,@([int]$pair[0], [int]$pair[1])
        }
    }

    foreach ($pair in @(Expand-PairsForProcessing $PairsToAdd)) {
        $key = Pair-Key $pair
        if (-not $key) { continue }
        if (-not $seen.ContainsKey($key)) {
            $seen[$key] = $true
            $output += ,@([int]$pair[0], [int]$pair[1])
        }
    }

    return $output
}

function Remove-Pairs {
    param(
        [object[]]$BasePairs,
        [object[]]$PairsToRemove
    )

    $removeSet = @{}
    foreach ($pair in @(Expand-PairsForProcessing $PairsToRemove)) {
        $key = Pair-Key $pair
        if ($key) {
            $removeSet[$key] = $true
        }
    }

    $output = @()
    foreach ($pair in @(Expand-PairsForProcessing $BasePairs)) {
        $key = Pair-Key $pair
        if (-not $key) { continue }
        if (-not $removeSet.ContainsKey($key)) {
            $output += ,@([int]$pair[0], [int]$pair[1])
        }
    }

    return $output
}

function Resolve-RewardPairsWithOverride {
    param(
        [int]$AchievementId,
        [object[]]$BasePairs,
        [hashtable]$OverridesMap
    )

    $key = [string]$AchievementId
    if (-not $OverridesMap.ContainsKey($key)) {
        return @(Expand-PairsForProcessing $BasePairs)
    }

    $overrideEntry = $OverridesMap[$key]
    if ($null -eq $overrideEntry) {
        return @(Expand-PairsForProcessing $BasePairs)
    }

    # Direct list form (e.g. [[3,123],[201,456]]) should replace base pairs.
    # Do NOT treat dictionaries/hashtables as list form; those are structured override maps
    # with replace/rewards/add/remove semantics handled below.
    $isListLike = ($overrideEntry -is [System.Array]) -or (
        ($overrideEntry -is [System.Collections.IEnumerable]) `
        -and -not ($overrideEntry -is [string]) `
        -and -not ($overrideEntry -is [System.Collections.IDictionary]) `
        -and -not ($overrideEntry -is [PSCustomObject])
    )
    if ($isListLike) {
        return @(Expand-PairsForProcessing (Convert-ToRewardPairs $overrideEntry))
    }

    $overrideMap = ConvertTo-HashtableRecursive $overrideEntry
    if (-not ($overrideMap -is [hashtable])) {
        return @(Expand-PairsForProcessing $BasePairs)
    }

    $knownKeys = @("remove_all", "replace", "rewards", "add", "remove")
    $hasKnownTopLevelKey = $false
    foreach ($k in $knownKeys) {
        if ($overrideMap.ContainsKey($k)) {
            $hasKnownTopLevelKey = $true
            break
        }
    }

    function Apply-OverrideObject {
        param(
            [object[]]$CurrentPairs,
            [hashtable]$Obj
        )

        $resultLocal = @(Expand-PairsForProcessing $CurrentPairs)
        if (-not ($Obj -is [hashtable])) {
            return @($resultLocal)
        }

        if ($Obj.ContainsKey("remove_all") -and [bool]$Obj["remove_all"]) {
            $resultLocal = @()
        }

        if ($Obj.ContainsKey("replace") -and [bool]$Obj["replace"]) {
            if ($Obj.ContainsKey("rewards")) {
                $resultLocal = @(Expand-PairsForProcessing (Convert-ToRewardPairs $Obj["rewards"]))
            }
            else {
                $resultLocal = @()
            }
        }
        elseif ($Obj.ContainsKey("rewards") -and -not $Obj.ContainsKey("add") -and -not $Obj.ContainsKey("remove")) {
            $resultLocal = @(Expand-PairsForProcessing (Convert-ToRewardPairs $Obj["rewards"]))
        }

        if ($Obj.ContainsKey("add")) {
            $resultLocal = @(Add-UniquePairs -BasePairs $resultLocal -PairsToAdd @(Expand-PairsForProcessing (Convert-ToRewardPairs $Obj["add"])))
        }

        if ($Obj.ContainsKey("remove")) {
            $resultLocal = @(Remove-Pairs -BasePairs $resultLocal -PairsToRemove @(Expand-PairsForProcessing (Convert-ToRewardPairs $Obj["remove"])))
        }

        return @($resultLocal)
    }

    $result = @(Expand-PairsForProcessing $BasePairs)

    if ($hasKnownTopLevelKey) {
        return @(Apply-OverrideObject -CurrentPairs $result -Obj $overrideMap)
    }

    # Support wrapped override shapes, e.g.
    # "12345": { "replace_existing": { replace=true, rewards=[...] } }
    $childKeys = @($overrideMap.Keys | Sort-Object)
    foreach ($childKey in $childKeys) {
        $child = ConvertTo-HashtableRecursive $overrideMap[$childKey]
        if (-not ($child -is [hashtable])) {
            continue
        }

        $childHasKnown = $false
        foreach ($k in $knownKeys) {
            if ($child.ContainsKey($k)) {
                $childHasKnown = $true
                break
            }
        }
        if (-not $childHasKnown) {
            continue
        }

        $result = @(Apply-OverrideObject -CurrentPairs $result -Obj $child)
    }

    return @($result)
}

function Get-WowheadAchievementObject {
    param(
        [int]$AchievementId,
        [int]$TimeoutSec,
        [int]$MaxRetries
    )

    $url = "https://www.wowhead.com/achievement=$AchievementId"
    $attempt = 1

    while ($attempt -le $MaxRetries) {
        try {
            Write-Log ("Fetching achievement {0} (attempt {1}/{2})" -f $AchievementId, $attempt, $MaxRetries)
            $response = Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec $TimeoutSec
            $content = $response.Content
            $match = [regex]::Match(
                $content,
                "\$\.extend\(g_achievements\[$AchievementId\],\s*(\{.*?\})\);",
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )

            if ($match.Success) {
                Write-Log ("Achievement {0}: payload parsed" -f $AchievementId)
                return ($match.Groups[1].Value | ConvertFrom-Json)
            }

            Write-Log ("Achievement {0}: payload marker not found" -f $AchievementId) "WARN"
            $attempt++
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            }

            Write-Log ("Achievement {0}: request failed on attempt {1}: {2}" -f $AchievementId, $attempt, $_.Exception.Message) "WARN"

            if ($statusCode -eq 403 -or $_.Exception.Message -match "\(403\)") {
                Write-Log ("Achievement {0}: received HTTP 403. Waiting 1 minute before retrying (attempt not consumed)..." -f $AchievementId) "WARN"
                Start-Sleep -Seconds 60
                continue
            }

            if ($attempt -ge $MaxRetries) {
                return $null
            }

            Start-Sleep -Milliseconds (300 * $attempt)
            $attempt++
        }
    }

    return $null
}

function Get-WowheadItemSpellId {
    param(
        [int]$ItemId,
        [int]$TimeoutSec,
        [int]$MaxRetries
    )

    $url = "https://www.wowhead.com/item=$ItemId"
    $attempt = 1

    while ($attempt -le $MaxRetries) {
        try {
            Write-Log ("Fetching item {0} for spell mapping (attempt {1}/{2})" -f $ItemId, $attempt, $MaxRetries)
            $response = Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec $TimeoutSec
            $content = $response.Content

            $startMatches = [regex]::Matches(
                $content,
                'WH\.Gatherer\.addData\(\s*6\s*,\s*1\s*,\s*\{',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )

            foreach ($startMatch in $startMatches) {
                $openBraceIndex = $startMatch.Index + $startMatch.Length - 1
                $jsonObjText = Get-BalancedJsonObjectFromText -Text $content -OpenBraceIndex $openBraceIndex
                if (-not $jsonObjText) {
                    continue
                }

                $spellMap = $null
                try {
                    $spellMap = ConvertTo-HashtableRecursive ($jsonObjText | ConvertFrom-Json)
                }
                catch {
                    $spellMap = $null
                }
                if (-not ($spellMap -is [hashtable])) {
                    continue
                }

                $bestSpellId = Select-BestSpellIdFromGathererMap -SpellMap $spellMap
                if ($bestSpellId -gt 0) {
                    Write-Log ("Item {0}: resolved spell {1} via WH.Gatherer.addData" -f $ItemId, $bestSpellId)
                    return $bestSpellId
                }
            }

            Write-Log ("Item {0}: no WH.Gatherer spell mapping found" -f $ItemId)
            return 0
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            }

            Write-Log ("Item {0}: request failed on attempt {1}: {2}" -f $ItemId, $attempt, $_.Exception.Message) "WARN"

            if ($statusCode -eq 403 -or $_.Exception.Message -match "\(403\)") {
                Write-Log ("Item {0}: received HTTP 403. Waiting 1 minute before retrying (attempt not consumed)..." -f $ItemId) "WARN"
                Start-Sleep -Seconds 60
                continue
            }

            if ($attempt -ge $MaxRetries) {
                return 0
            }

            Start-Sleep -Milliseconds (300 * $attempt)
            $attempt++
        }
    }

    return 0
}

function Get-BalancedJsonObjectFromText {
    param(
        [string]$Text,
        [int]$OpenBraceIndex
    )

    if ([string]::IsNullOrEmpty($Text)) { return $null }
    if ($OpenBraceIndex -lt 0 -or $OpenBraceIndex -ge $Text.Length) { return $null }
    if ($Text[$OpenBraceIndex] -ne '{') { return $null }

    $depth = 0
    $inString = $false
    $isEscaped = $false

    for ($i = $OpenBraceIndex; $i -lt $Text.Length; $i++) {
        $ch = $Text[$i]

        if ($inString) {
            if ($isEscaped) {
                $isEscaped = $false
                continue
            }
            if ($ch -eq '\') {
                $isEscaped = $true
                continue
            }
            if ($ch -eq '"') {
                $inString = $false
            }
            continue
        }

        if ($ch -eq '"') {
            $inString = $true
            continue
        }

        if ($ch -eq '{') {
            $depth++
            continue
        }
        if ($ch -eq '}') {
            $depth--
            if ($depth -eq 0) {
                return $Text.Substring($OpenBraceIndex, ($i - $OpenBraceIndex + 1))
            }
        }
    }

    return $null
}

function Select-BestSpellIdFromGathererMap {
    param(
        [hashtable]$SpellMap
    )

    if (-not ($SpellMap -is [hashtable])) {
        return 0
    }

    $bestId = 0
    $bestScore = [int]::MinValue

    foreach ($key in $SpellMap.Keys) {
        $spellId = 0
        try { $spellId = [int]$key } catch { continue }
        if ($spellId -le 0) { continue }

        $entry = ConvertTo-HashtableRecursive $SpellMap[$key]
        $name = ""
        $description = ""
        if ($entry -is [hashtable]) {
            if ($entry.ContainsKey("name_enus") -and $entry["name_enus"]) { $name = [string]$entry["name_enus"] }
            if ($entry.ContainsKey("description_enus") -and $entry["description_enus"]) { $description = [string]$entry["description_enus"] }
        }

        $score = 0

        # Prefer summon/dismiss companion-like spells.
        if ($description -match '(?i)\bsummon(s|ed|ing)?\b') { $score += 50 }
        if ($description -match '(?i)\bdismiss(es|ed|ing)?\b') { $score += 30 }
        if ($description -match '(?i)\bmount\b|\bcompanion\b|\bpet\b') { $score += 25 }

        # Penalize generic riding-skill spells.
        if ($description -match '(?i)\byou can now ride\b|\bmounted speed\b|\briding skill\b') { $score -= 80 }
        if ($name -match '(?i)\briding\b|\bapprentice riding\b|\bjourneyman riding\b|\bexpert riding\b|\bartisan riding\b|\bmaster riding\b') { $score -= 50 }

        # Slight preference for entries that actually contain text context.
        if ($description) { $score += 5 }
        if ($name) { $score += 3 }

        if (($score -gt $bestScore) -or (($score -eq $bestScore) -and ($spellId -gt $bestId))) {
            $bestScore = $score
            $bestId = $spellId
        }
    }

    if ($bestId -gt 0) {
        Write-Log ("Gatherer candidate selection: chose spell {0} (score {1})" -f $bestId, $bestScore)
    }

    return $bestId
}

function Resolve-ItemRewardsToSpellRewards {
    param(
        [object[]]$Pairs,
        [hashtable]$ItemSpellCache,
        [int]$TimeoutSec,
        [int]$MaxRetries,
        [int]$DelayMs
    )

    $result = @()
    $usedItemLookup = $false

    foreach ($pair in @(Expand-PairsForProcessing $Pairs)) {
        $rtype = [int]$pair[0]
        $rid = [int]$pair[1]

        if ($rtype -ne 3 -or $rid -le 0) {
            $result += ,@($rtype, $rid)
            continue
        }

        $cacheKey = [string]$rid
        $spellId = $null
        if ($ItemSpellCache.ContainsKey($cacheKey)) {
            try { $spellId = [int]$ItemSpellCache[$cacheKey] } catch { $spellId = 0 }
        }
        else {
            $usedItemLookup = $true
            $spellId = Get-WowheadItemSpellId -ItemId $rid -TimeoutSec $TimeoutSec -MaxRetries $MaxRetries
            $ItemSpellCache[$cacheKey] = [int]$spellId
            if ($DelayMs -gt 0) {
                Start-Sleep -Milliseconds $DelayMs
            }
        }

        if ([int]$spellId -gt 0) {
            $result += ,@(6, [int]$spellId)
        }
        else {
            $result += ,@(3, $rid)
        }
    }

    # De-duplicate while preserving order.
    $deduped = @()
    $seen = @{}
    foreach ($pair in @(Expand-PairsForProcessing $result)) {
        $pkey = Pair-Key $pair
        if (-not $pkey) { continue }
        if (-not $seen.ContainsKey($pkey)) {
            $seen[$pkey] = $true
            $deduped += ,@([int]$pair[0], [int]$pair[1])
        }
    }

    return @{
        pairs = @($deduped)
        usedItemLookup = [bool]$usedItemLookup
    }
}

function Get-WowheadNpcDisplayId {
    param(
        [int]$NpcId,
        [int]$TimeoutSec,
        [int]$MaxRetries
    )

    $url = "https://www.wowhead.com/npc=$NpcId"
    $attempt = 1

    while ($attempt -le $MaxRetries) {
        try {
            Write-Log ("Fetching NPC {0} for display mapping (attempt {1}/{2})" -f $NpcId, $attempt, $MaxRetries)
            $response = Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec $TimeoutSec
            $content = $response.Content

            # Common markup:
            # data-mv-type-id="143730" ... data-mv-display-id="81972"
            $pairsA = [regex]::Matches(
                $content,
                'data-mv-type-id\s*=\s*"(\d+)"[^>]*data-mv-display-id\s*=\s*"(\d+)"',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            foreach ($m in $pairsA) {
                $typeId = 0; $displayId = 0
                try { $typeId = [int]$m.Groups[1].Value } catch {}
                try { $displayId = [int]$m.Groups[2].Value } catch {}
                if ($typeId -eq $NpcId -and $displayId -gt 0) {
                    Write-Log ("NPC {0}: resolved display {1} via data-mv attributes" -f $NpcId, $displayId)
                    return $displayId
                }
            }

            # Reversed order fallback:
            $pairsB = [regex]::Matches(
                $content,
                'data-mv-display-id\s*=\s*"(\d+)"[^>]*data-mv-type-id\s*=\s*"(\d+)"',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            foreach ($m in $pairsB) {
                $displayId = 0; $typeId = 0
                try { $displayId = [int]$m.Groups[1].Value } catch {}
                try { $typeId = [int]$m.Groups[2].Value } catch {}
                if ($typeId -eq $NpcId -and $displayId -gt 0) {
                    Write-Log ("NPC {0}: resolved display {1} via reversed data-mv attributes" -f $NpcId, $displayId)
                    return $displayId
                }
            }

            # Last resort single-page marker used by model viewer scripts.
            $displayMatch = [regex]::Match($content, 'displayId\s*=\s*(\d+)\s*;')
            if ($displayMatch.Success) {
                $displayId = 0
                try { $displayId = [int]$displayMatch.Groups[1].Value } catch {}
                if ($displayId -gt 0) {
                    Write-Log ("NPC {0}: resolved display {1} via displayId marker" -f $NpcId, $displayId)
                    return $displayId
                }
            }

            Write-Log ("NPC {0}: no display mapping found" -f $NpcId)
            return 0
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            }

            Write-Log ("NPC {0}: request failed on attempt {1}: {2}" -f $NpcId, $attempt, $_.Exception.Message) "WARN"

            if ($statusCode -eq 403 -or $_.Exception.Message -match "\(403\)") {
                Write-Log ("NPC {0}: received HTTP 403. Waiting 1 minute before retrying (attempt not consumed)..." -f $NpcId) "WARN"
                Start-Sleep -Seconds 60
                continue
            }

            if ($attempt -ge $MaxRetries) {
                return 0
            }

            Start-Sleep -Milliseconds (300 * $attempt)
            $attempt++
        }
    }

    return 0
}

function Resolve-NpcRewardsToDisplayRewards {
    param(
        [object[]]$Pairs,
        [hashtable]$NpcDisplayCache,
        [int]$TimeoutSec,
        [int]$MaxRetries,
        [int]$DelayMs
    )

    $result = @()
    $usedNpcLookup = $false

    foreach ($pair in @(Expand-PairsForProcessing $Pairs)) {
        $rtype = [int]$pair[0]
        $rid = [int]$pair[1]

        if ($rtype -ne 1 -or $rid -le 0) {
            $result += ,@($rtype, $rid)
            continue
        }

        $cacheKey = [string]$rid
        $displayId = $null
        if ($NpcDisplayCache.ContainsKey($cacheKey)) {
            try { $displayId = [int]$NpcDisplayCache[$cacheKey] } catch { $displayId = 0 }
        }
        else {
            $usedNpcLookup = $true
            $displayId = Get-WowheadNpcDisplayId -NpcId $rid -TimeoutSec $TimeoutSec -MaxRetries $MaxRetries
            $NpcDisplayCache[$cacheKey] = [int]$displayId
            if ($DelayMs -gt 0) {
                Start-Sleep -Milliseconds $DelayMs
            }
        }

        if ([int]$displayId -gt 0) {
            $result += ,@(1, [int]$displayId)
        }
        else {
            $result += ,@(1, $rid)
        }
    }

    $deduped = @()
    $seen = @{}
    foreach ($pair in @(Expand-PairsForProcessing $result)) {
        $pkey = Pair-Key $pair
        if (-not $pkey) { continue }
        if (-not $seen.ContainsKey($pkey)) {
            $seen[$pkey] = $true
            $deduped += ,@([int]$pair[0], [int]$pair[1])
        }
    }

    return @{
        pairs = @($deduped)
        usedNpcLookup = [bool]$usedNpcLookup
    }
}

function Get-WowheadItemRewardMetadata {
    param(
        [int]$ItemId,
        [int]$TimeoutSec,
        [int]$MaxRetries
    )

    $result = [ordered]@{
        typeName = "unknown"
        itemID = [int]$ItemId
        spellID = 0
        speciesID = 0
        npcID = 0
        modelID = 0
        displayID = 0
        mvTypeID = 0
    }

    $url = "https://www.wowhead.com/item=$ItemId"
    $attempt = 1

    while ($attempt -le $MaxRetries) {
        try {
            Write-Log ("Fetching item {0} metadata (attempt {1}/{2})" -f $ItemId, $attempt, $MaxRetries)
            $response = Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec $TimeoutSec
            $content = $response.Content

            $view3dMatches = [regex]::Matches(
                $content,
                'data-mv-type-id\s*=\s*"(\d+)"[^>]*data-mv-display-id\s*=\s*"(\d+)"',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            if ($view3dMatches.Count -eq 0) {
                $view3dMatches = [regex]::Matches(
                    $content,
                    'data-mv-display-id\s*=\s*"(\d+)"[^>]*data-mv-type-id\s*=\s*"(\d+)"',
                    [System.Text.RegularExpressions.RegexOptions]::Singleline
                )
                foreach ($m in $view3dMatches) {
                    $display = 0; $typeId = 0
                    try { $display = [int]$m.Groups[1].Value } catch {}
                    try { $typeId = [int]$m.Groups[2].Value } catch {}
                    if ($display -gt 0) { $result.displayID = $display }
                    if ($typeId -ge 0) { $result.mvTypeID = $typeId }
                    break
                }
            }
            else {
                foreach ($m in $view3dMatches) {
                    $typeId = 0; $display = 0
                    try { $typeId = [int]$m.Groups[1].Value } catch {}
                    try { $display = [int]$m.Groups[2].Value } catch {}
                    if ($display -gt 0) { $result.displayID = $display }
                    if ($typeId -ge 0) { $result.mvTypeID = $typeId }
                    break
                }
            }

            $teachesSpellBlock = [regex]::Match(
                $content,
                "new\s+Listview\(\{\s*template:\s*'spell'[\s\S]*?id:\s*'teaches-ability'[\s\S]*?\}\);",
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )

            $spellCategory = 0
            if ($teachesSpellBlock.Success) {
                $entryMatches = [regex]::Matches($teachesSpellBlock.Value, '"cat"\s*:\s*(-?\d+)[\s\S]*?"id"\s*:\s*(\d+)')
                foreach ($em in $entryMatches) {
                    $cat = 0; $spellId = 0
                    try { $cat = [int]$em.Groups[1].Value } catch {}
                    try { $spellId = [int]$em.Groups[2].Value } catch {}
                    if ($spellId -gt 0) {
                        $result.spellID = $spellId
                        $spellCategory = $cat
                        break
                    }
                }
            }

            $petSpeciesBlock = [regex]::Match(
                $content,
                "new\s+Listview\(\{\s*template:\s*'pet-species'[\s\S]*?\}\);",
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            if ($petSpeciesBlock.Success) {
                $speciesMatch = [regex]::Match($petSpeciesBlock.Value, '"species"\s*:\s*(\d+)')
                if ($speciesMatch.Success) {
                    try { $result.speciesID = [int]$speciesMatch.Groups[1].Value } catch {}
                }

                $modelMatch = [regex]::Match($petSpeciesBlock.Value, '"model"\s*:\s*(\d+)')
                if ($modelMatch.Success) {
                    try { $result.modelID = [int]$modelMatch.Groups[1].Value } catch {}
                }

                $npcMatch = [regex]::Match($petSpeciesBlock.Value, '"npc"\s*:\s*\{[\s\S]*?"id"\s*:\s*(\d+)')
                if ($npcMatch.Success) {
                    try { $result.npcID = [int]$npcMatch.Groups[1].Value } catch {}
                }
            }

            if ($result.speciesID -gt 0 -or $result.npcID -gt 0 -or $spellCategory -eq -6) {
                $result.typeName = "pet"
            }
            elseif ($spellCategory -eq -5) {
                $result.typeName = "mount"
            }
            elseif ($result.spellID -gt 0 -and $result.displayID -gt 0 -and $result.mvTypeID -eq 0) {
                $result.typeName = "mount"
            }
            elseif ($result.spellID -gt 0) {
                $result.typeName = "misc"
            }
            elseif ($result.displayID -gt 0) {
                $result.typeName = "misc"
            }
            else {
                $result.typeName = "unknown"
            }

            Write-Log ("Item {0}: classified as {1} (spell={2}, species={3}, npc={4}, model={5}, display={6})" -f $ItemId, $result.typeName, $result.spellID, $result.speciesID, $result.npcID, $result.modelID, $result.displayID)
            return $result
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            }

            Write-Log ("Item {0}: metadata request failed on attempt {1}: {2}" -f $ItemId, $attempt, $_.Exception.Message) "WARN"

            if ($statusCode -eq 403 -or $_.Exception.Message -match "\(403\)") {
                Write-Log ("Item {0}: received HTTP 403. Waiting 1 minute before retrying (attempt not consumed)..." -f $ItemId) "WARN"
                Start-Sleep -Seconds 60
                continue
            }

            if ($attempt -ge $MaxRetries) {
                return $result
            }

            Start-Sleep -Milliseconds (300 * $attempt)
            $attempt++
        }
    }

    return $result
}

function Get-WowheadSpellRewardMetadata {
    param(
        [int]$SpellId,
        [int]$TimeoutSec,
        [int]$MaxRetries
    )

    $result = [ordered]@{
        typeName = "spell"
        spellID = [int]$SpellId
        displayID = 0
        mvTypeID = 0
    }

    $url = "https://www.wowhead.com/spell=$SpellId"
    $attempt = 1

    while ($attempt -le $MaxRetries) {
        try {
            Write-Log ("Fetching spell {0} metadata (attempt {1}/{2})" -f $SpellId, $attempt, $MaxRetries)
            $response = Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec $TimeoutSec
            $content = $response.Content

            # Primary parse path:
            # data-mv-type-id="0" data-mv-display-id="92492"
            $pairsA = [regex]::Matches(
                $content,
                'data-mv-type-id\s*=\s*"(\d+)"[^>]*data-mv-display-id\s*=\s*"(\d+)"',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            foreach ($m in $pairsA) {
                $typeId = 0; $displayId = 0
                try { $typeId = [int]$m.Groups[1].Value } catch {}
                try { $displayId = [int]$m.Groups[2].Value } catch {}
                if ($displayId -gt 0) {
                    $result.displayID = $displayId
                    $result.mvTypeID = $typeId
                    break
                }
            }

            # Reversed attribute order fallback.
            if ($result.displayID -le 0) {
                $pairsB = [regex]::Matches(
                    $content,
                    'data-mv-display-id\s*=\s*"(\d+)"[^>]*data-mv-type-id\s*=\s*"(\d+)"',
                    [System.Text.RegularExpressions.RegexOptions]::Singleline
                )
                foreach ($m in $pairsB) {
                    $displayId = 0; $typeId = 0
                    try { $displayId = [int]$m.Groups[1].Value } catch {}
                    try { $typeId = [int]$m.Groups[2].Value } catch {}
                    if ($displayId -gt 0) {
                        $result.displayID = $displayId
                        $result.mvTypeID = $typeId
                        break
                    }
                }
            }

            # Fallback: encoded onclick payload in lightbox button.
            if ($result.displayID -le 0) {
                $displayMatch = [regex]::Match($content, 'displayId&quot;\s*:\s*(\d+)')
                if ($displayMatch.Success) {
                    try { $result.displayID = [int]$displayMatch.Groups[1].Value } catch {}
                }

                $typeMatch = [regex]::Match($content, 'typeId&quot;\s*:\s*(\d+)')
                if ($typeMatch.Success) {
                    try { $result.mvTypeID = [int]$typeMatch.Groups[1].Value } catch {}
                }
            }

            if ($result.displayID -gt 0) {
                $result.typeName = "spell"
            }
            else {
                $result.typeName = "misc"
            }

            Write-Log ("Spell {0}: classified as {1} (display={2}, mvTypeID={3})" -f $SpellId, $result.typeName, $result.displayID, $result.mvTypeID)
            return $result
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            }

            Write-Log ("Spell {0}: metadata request failed on attempt {1}: {2}" -f $SpellId, $attempt, $_.Exception.Message) "WARN"

            if ($statusCode -eq 403 -or $_.Exception.Message -match "\(403\)") {
                Write-Log ("Spell {0}: received HTTP 403. Waiting 1 minute before retrying (attempt not consumed)..." -f $SpellId) "WARN"
                Start-Sleep -Seconds 60
                continue
            }

            if ($attempt -ge $MaxRetries) {
                return $result
            }

            Start-Sleep -Milliseconds (300 * $attempt)
            $attempt++
        }
    }

    return $result
}

function Convert-RewardEntryToLua {
    param(
        [hashtable]$Entry
    )

    $parts = @()
    $parts += ("type = {0}" -f [int]$Entry.type)
    $parts += ("id = {0}" -f [int]$Entry.id)
    $parts += ('typeName = "{0}"' -f [string]$Entry.typeName)

    $orderedExtraKeys = @("itemID", "spellID", "speciesID", "npcID", "modelID", "displayID", "mvTypeID", "decorID", "titleID")
    foreach ($k in $orderedExtraKeys) {
        if ($Entry.ContainsKey($k)) {
            $v = $Entry[$k]
            if ($v -is [int] -or $v -is [long]) {
                if ([int64]$v -gt 0) {
                    $parts += ("{0} = {1}" -f $k, [int64]$v)
                }
            }
            elseif ($v) {
                $parts += ("{0} = {1}" -f $k, $v)
            }
        }
    }

    return ("{ " + ($parts -join ", ") + " }")
}

function Normalize-Map {
    param($Value)
    return ConvertTo-HashtableRecursive $Value
}

function Get-MapStringValue {
    param(
        [hashtable]$Map,
        [string[]]$Keys
    )
    if (-not ($Map -is [hashtable])) { return $null }
    foreach ($k in $Keys) {
        if ($Map.ContainsKey($k) -and $null -ne $Map[$k]) {
            $s = [string]$Map[$k]
            if ($s -ne "") { return $s }
        }
    }
    return $null
}

function Get-MapIntValue {
    param(
        [hashtable]$Map,
        [string[]]$Keys
    )
    if (-not ($Map -is [hashtable])) { return $null }
    foreach ($k in $Keys) {
        if ($Map.ContainsKey($k) -and $null -ne $Map[$k]) {
            try {
                $v = [int]$Map[$k]
                if ($v -gt 0) { return $v }
            }
            catch {}
        }
    }
    return $null
}

Write-Log "Starting reward DB build"
Write-Log ("Parameters: OutputPath='{0}', RawCachePath='{1}', OverridesPath='{2}', ItemSpellCachePath='{3}', NpcDisplayCachePath='{4}', ItemRewardCachePath='{5}', SpellRewardCachePath='{6}', DelayMs={7}, TimeoutSec={8}, MaxRetries={9}, ForceRescan={10}" -f $OutputPath, $RawCachePath, $OverridesPath, $ItemSpellCachePath, $NpcDisplayCachePath, $ItemRewardCachePath, $SpellRewardCachePath, $DelayMs, $TimeoutSec, $MaxRetries, [bool]$ForceRescan)

Ensure-ParentDirectory $RawCachePath
Ensure-ParentDirectory $OverridesPath
Ensure-ParentDirectory $ItemSpellCachePath
Ensure-ParentDirectory $NpcDisplayCachePath
Ensure-ParentDirectory $ItemRewardCachePath
Ensure-ParentDirectory $SpellRewardCachePath
Ensure-ParentDirectory $OutputPath

$decorIds = @(Get-AchievementIdsFromDir "DataSources\\DecorAchievements")
$petIds = @(Get-AchievementIdsFromDir "DataSources\\PetAchievements")
$mountIds = @(Get-AchievementIdsFromDir "DataSources\\MetaAchievements")

$allSet = New-Object System.Collections.Generic.HashSet[int]
$decorIds + $petIds + $mountIds | ForEach-Object { [void]$allSet.Add([int]$_) }
$allIds = @($allSet) | Sort-Object

Write-Log ("Decor IDs: {0}, Pet IDs: {1}, Mount IDs: {2}, Combined unique: {3}" -f $decorIds.Count, $petIds.Count, $mountIds.Count, $allIds.Count)
if ($allIds.Count -eq 0) {
    Write-Log "No achievement IDs discovered from DataSources. Check source directories and parsing patterns." "WARN"
}

$rawCache = @{}
if (Test-Path $RawCachePath) {
    try {
        $parsed = Get-Content -Path $RawCachePath -Raw | ConvertFrom-Json
        $rawCache = ConvertTo-HashtableRecursive $parsed
        Write-Log ("Loaded raw cache from {0} with {1} entries" -f $RawCachePath, $rawCache.Count)
    }
    catch {
        Write-Log ("Failed to parse existing raw cache. Starting fresh. Error: {0}" -f $_.Exception.Message) "WARN"
        $rawCache = @{}
    }
}
else {
    Write-Log ("Raw cache not found at {0}. Starting fresh." -f $RawCachePath)
}

if (-not (Test-Path $OverridesPath)) {
    $overrideTemplate = [ordered]@{
        "_examples" = [ordered]@{
            "replace_existing" = [ordered]@{ replace = $true; rewards = @(@(3, 12345), @(201, 9999)) }
            "extend_existing"  = [ordered]@{ add = @(@(3, 22222)); remove = @(@(201, 9999)) }
            "remove_all"       = [ordered]@{ remove_all = $true }
            "remove_all_then_add" = [ordered]@{ remove_all = $true; add = @(@(3, 33333)) }
        }
    }
    ($overrideTemplate | ConvertTo-Json -Depth 8) | Set-Content -Path $OverridesPath
    Write-Log ("Created override template at {0}" -f $OverridesPath)
}

$overrides = @{}
try {
    $overrideParsed = Get-Content -Path $OverridesPath -Raw | ConvertFrom-Json
    $overrides = ConvertTo-HashtableRecursive $overrideParsed
    Write-Log ("Loaded overrides from {0} with {1} top-level entries" -f $OverridesPath, $overrides.Count)
}
catch {
    Write-Log ("Failed to parse overrides file. Ignoring overrides. Error: {0}" -f $_.Exception.Message) "WARN"
    $overrides = @{}
}

$itemSpellCache = @{}
if (Test-Path $ItemSpellCachePath) {
    try {
        $parsedItemSpellCache = Get-Content -Path $ItemSpellCachePath -Raw | ConvertFrom-Json
        $itemSpellCache = ConvertTo-HashtableRecursive $parsedItemSpellCache
        Write-Log ("Loaded item-spell cache from {0} with {1} entries" -f $ItemSpellCachePath, $itemSpellCache.Count)
    }
    catch {
        Write-Log ("Failed to parse item-spell cache. Starting fresh. Error: {0}" -f $_.Exception.Message) "WARN"
        $itemSpellCache = @{}
    }
}
else {
    Write-Log ("Item-spell cache not found at {0}. Starting fresh." -f $ItemSpellCachePath)
}

$itemSpellCacheDirty = $false

$npcDisplayCache = @{}
if (Test-Path $NpcDisplayCachePath) {
    try {
        $parsedNpcDisplayCache = Get-Content -Path $NpcDisplayCachePath -Raw | ConvertFrom-Json
        $npcDisplayCache = ConvertTo-HashtableRecursive $parsedNpcDisplayCache
        Write-Log ("Loaded NPC-display cache from {0} with {1} entries" -f $NpcDisplayCachePath, $npcDisplayCache.Count)
    }
    catch {
        Write-Log ("Failed to parse NPC-display cache. Starting fresh. Error: {0}" -f $_.Exception.Message) "WARN"
        $npcDisplayCache = @{}
    }
}
else {
    Write-Log ("NPC-display cache not found at {0}. Starting fresh." -f $NpcDisplayCachePath)
}

$npcDisplayCacheDirty = $false

$itemRewardCache = @{}
if (Test-Path $ItemRewardCachePath) {
    try {
        $parsedItemRewardCache = Get-Content -Path $ItemRewardCachePath -Raw | ConvertFrom-Json
        $itemRewardCache = ConvertTo-HashtableRecursive $parsedItemRewardCache
        Write-Log ("Loaded item-reward cache from {0} with {1} entries" -f $ItemRewardCachePath, $itemRewardCache.Count)
    }
    catch {
        Write-Log ("Failed to parse item-reward cache. Starting fresh. Error: {0}" -f $_.Exception.Message) "WARN"
        $itemRewardCache = @{}
    }
}
else {
    Write-Log ("Item-reward cache not found at {0}. Starting fresh." -f $ItemRewardCachePath)
}

$itemRewardCacheDirty = $false

$spellRewardCache = @{}
if (Test-Path $SpellRewardCachePath) {
    try {
        $parsedSpellRewardCache = Get-Content -Path $SpellRewardCachePath -Raw | ConvertFrom-Json
        $spellRewardCache = ConvertTo-HashtableRecursive $parsedSpellRewardCache
        Write-Log ("Loaded spell-reward cache from {0} with {1} entries" -f $SpellRewardCachePath, $spellRewardCache.Count)
    }
    catch {
        Write-Log ("Failed to parse spell-reward cache. Starting fresh. Error: {0}" -f $_.Exception.Message) "WARN"
        $spellRewardCache = @{}
    }
}
else {
    Write-Log ("Spell-reward cache not found at {0}. Starting fresh." -f $SpellRewardCachePath)
}

$spellRewardCacheDirty = $false

$idsToScan = New-Object System.Collections.Generic.List[int]
if ($ForceRescan) {
    foreach ($id in $allIds) { [void]$idsToScan.Add([int]$id) }
    Write-Log ("Force rescan enabled: scanning all {0} achievements" -f $idsToScan.Count)
}
else {
    foreach ($id in $allIds) {
        if (-not $rawCache.ContainsKey([string]$id)) {
            [void]$idsToScan.Add([int]$id)
        }
    }
    Write-Log ("Incremental mode: scanning {0} missing achievements, skipping {1} cached" -f $idsToScan.Count, ($allIds.Count - $idsToScan.Count))
}

$scanFailures = 0
$failedAchievementIds = New-Object System.Collections.Generic.List[int]
for ($idx = 0; $idx -lt $idsToScan.Count; $idx++) {
    $id = [int]$idsToScan[$idx]
    Write-Log ("[scan {0}/{1}] Achievement {2}" -f ($idx + 1), $idsToScan.Count, $id)

    $achievement = Get-WowheadAchievementObject -AchievementId $id -TimeoutSec $TimeoutSec -MaxRetries $MaxRetries
    if (-not $achievement) {
        $scanFailures++
        [void]$failedAchievementIds.Add($id)
        Write-Log ("Achievement {0}: failed to fetch, leaving uncached for next run" -f $id) "WARN"
        continue
    }

    $pairs = @()
    if ($achievement.PSObject.Properties.Name -contains "rewards") {
        $pairs = @(Convert-ToRewardPairs $achievement.rewards)
    }

    $rawCache[[string]$id] = @($pairs)
    Write-Log ("Achievement {0}: cached {1} raw reward entries" -f $id, $pairs.Count)

    if ($DelayMs -gt 0) {
        Start-Sleep -Milliseconds $DelayMs
    }
}

$rawKeys = New-Object System.Collections.Generic.HashSet[int]
foreach ($key in $rawCache.Keys) {
    try { [void]$rawKeys.Add([int]$key) } catch {}
}
foreach ($key in $overrides.Keys) {
    if ([string]$key -match '^\d+$') {
        [void]$rawKeys.Add([int]$key)
    }
}
foreach ($id in $allIds) {
    [void]$rawKeys.Add([int]$id)
}

$sortedRawKeys = @($rawKeys) | Sort-Object
$rawOut = [ordered]@{}
foreach ($id in $sortedRawKeys) {
    $key = [string]$id
    # Persist every discovered key; use empty arrays for no-reward/unknown entries so they are not rescanned.
    if ($rawCache.ContainsKey($key)) {
        $rawOut[$key] = @(Convert-ToRewardPairs $rawCache[$key])
    }
    else {
        $rawOut[$key] = @()
    }
}

$shouldWriteRawCache = $ForceRescan -or ($idsToScan.Count -gt 0) -or -not (Test-Path $RawCachePath)
if ($shouldWriteRawCache) {
    ($rawOut | ConvertTo-Json -Depth 10) | Set-Content -Path $RawCachePath
    Write-Log ("Wrote raw cache to {0} with {1} entries" -f $RawCachePath, $rawOut.Count)
}
else {
    Write-Log ("No scans performed; kept existing raw cache file unchanged ({0})" -f $RawCachePath)
}

$typeNameMap = @{
    1 = "misc"
    3 = "unknown"
    201 = "decor"
    11 = "misc"
    6 = "spell"
}
$allowedTypes = New-Object System.Collections.Generic.HashSet[int]
[void]$allowedTypes.Add(1)
[void]$allowedTypes.Add(3)
[void]$allowedTypes.Add(201)
[void]$allowedTypes.Add(11)
[void]$allowedTypes.Add(6)

$rows = New-Object System.Collections.Generic.List[string]
$keptAchievements = 0
$skippedNoViewable = 0

foreach ($id in $sortedRawKeys) {
    $key = [string]$id
    $basePairs = @()
    if ($rawCache.ContainsKey($key)) {
        $basePairs = @(Expand-PairsForProcessing (Convert-ToRewardPairs $rawCache[$key]))
    }

    $resolvedPairs = @(Expand-PairsForProcessing (Resolve-RewardPairsWithOverride -AchievementId $id -BasePairs $basePairs -OverridesMap $overrides))

    $filtered = @()
    foreach ($pair in $resolvedPairs) {
        $arr = @($pair)
        if ($arr.Count -lt 2) { continue }
        $rtype = [int]$arr[0]
        $rid = [int]$arr[1]
        if ($allowedTypes.Contains($rtype)) {
            $entry = [ordered]@{
                type = $rtype
                id = $rid
                typeName = [string]$typeNameMap[$rtype]
            }

            if ($rtype -eq 201) {
                $entry.typeName = "decor"
                $entry.decorID = $rid
            }
            elseif ($rtype -eq 3) {
                $entry.itemID = $rid
                $cacheKey = [string]$rid
                $meta = $null

                if ($itemRewardCache.ContainsKey($cacheKey)) {
                    $meta = Normalize-Map $itemRewardCache[$cacheKey]
                }
                else {
                    $meta = Get-WowheadItemRewardMetadata -ItemId $rid -TimeoutSec $TimeoutSec -MaxRetries $MaxRetries
                    $itemRewardCache[$cacheKey] = Normalize-Map $meta
                    $itemRewardCacheDirty = $true
                    if ($DelayMs -gt 0) {
                        Start-Sleep -Milliseconds $DelayMs
                    }
                }

                if (-not ($meta -is [hashtable])) {
                    $meta = Normalize-Map $meta
                }

                if ($meta -is [hashtable]) {
                    $typeName = Get-MapStringValue -Map $meta -Keys @("typeName","typename","TypeName")
                    if ($typeName) {
                        $entry.typeName = $typeName
                    }

                    $mapKeys = @(
                        @{ out = "spellID"; in = @("spellID","spellId","SpellID") },
                        @{ out = "speciesID"; in = @("speciesID","speciesId","SpeciesID") },
                        @{ out = "npcID"; in = @("npcID","npcId","NpcID") },
                        @{ out = "modelID"; in = @("modelID","modelId","ModelID") },
                        @{ out = "displayID"; in = @("displayID","displayId","DisplayID") },
                        @{ out = "mvTypeID"; in = @("mvTypeID","mvtypeid","mvTypeId","MvTypeID") }
                    )
                    foreach ($mk in $mapKeys) {
                        $val = Get-MapIntValue -Map $meta -Keys $mk.in
                        if ($val) {
                            $entry[$mk.out] = [int]$val
                        }
                    }
                }
            }
            elseif ($rtype -eq 1) {
                $entry.typeName = "misc"
                $entry.npcID = $rid
            }
            elseif ($rtype -eq 6) {
                $entry.spellID = $rid
                $cacheKey = [string]$rid
                $smeta = $null

                if ($spellRewardCache.ContainsKey($cacheKey)) {
                    $smeta = Normalize-Map $spellRewardCache[$cacheKey]
                }
                else {
                    $smeta = Get-WowheadSpellRewardMetadata -SpellId $rid -TimeoutSec $TimeoutSec -MaxRetries $MaxRetries
                    $spellRewardCache[$cacheKey] = Normalize-Map $smeta
                    $spellRewardCacheDirty = $true
                    if ($DelayMs -gt 0) {
                        Start-Sleep -Milliseconds $DelayMs
                    }
                }

                if (-not ($smeta -is [hashtable])) {
                    $smeta = Normalize-Map $smeta
                }
                if ($smeta -is [hashtable]) {
                    $stypeName = Get-MapStringValue -Map $smeta -Keys @("typeName","typename","TypeName")
                    if ($stypeName) {
                        $entry.typeName = $stypeName
                    }
                    $spellMapKeys = @(
                        @{ out = "displayID"; in = @("displayID","displayId","DisplayID") },
                        @{ out = "mvTypeID"; in = @("mvTypeID","mvtypeid","mvTypeId","MvTypeID") }
                    )
                    foreach ($mk in $spellMapKeys) {
                        $val = Get-MapIntValue -Map $smeta -Keys $mk.in
                        if ($val) {
                            $entry[$mk.out] = [int]$val
                        }
                    }
                }
            }
            elseif ($rtype -eq 11) {
                $entry.typeName = "misc"
                $entry.titleID = $rid
            }

            $filtered += ,$entry
        }
    }

    if ($filtered.Count -eq 0) {
        $skippedNoViewable++
        continue
    }

    $rewardParts = @()
    foreach ($entry in $filtered) {
        $rewardParts += (Convert-RewardEntryToLua -Entry $entry)
    }
    $rewardExpr = "{ " + ($rewardParts -join ", ") + " }"

    [void]$rows.Add(("    [{0}] = {{ rewards = {1} }}," -f $id, $rewardExpr))
    $keptAchievements++
}

$shouldWriteItemSpellCache = $itemSpellCacheDirty -or -not (Test-Path $ItemSpellCachePath)
if ($shouldWriteItemSpellCache) {
    $cacheOut = [ordered]@{}
    foreach ($k in @($itemSpellCache.Keys | Sort-Object)) {
        $cacheOut[[string]$k] = [int]$itemSpellCache[$k]
    }
    ($cacheOut | ConvertTo-Json -Depth 5) | Set-Content -Path $ItemSpellCachePath
    Write-Log ("Wrote item-spell cache to {0} with {1} entries" -f $ItemSpellCachePath, $cacheOut.Count)
}
else {
    Write-Log ("No item-spell lookups performed; kept existing item-spell cache unchanged ({0})" -f $ItemSpellCachePath)
}

$shouldWriteNpcDisplayCache = $npcDisplayCacheDirty -or -not (Test-Path $NpcDisplayCachePath)
if ($shouldWriteNpcDisplayCache) {
    $npcCacheOut = [ordered]@{}
    foreach ($k in @($npcDisplayCache.Keys | Sort-Object)) {
        $npcCacheOut[[string]$k] = [int]$npcDisplayCache[$k]
    }
    ($npcCacheOut | ConvertTo-Json -Depth 5) | Set-Content -Path $NpcDisplayCachePath
    Write-Log ("Wrote NPC-display cache to {0} with {1} entries" -f $NpcDisplayCachePath, $npcCacheOut.Count)
}
else {
    Write-Log ("No NPC-display lookups performed; kept existing NPC-display cache unchanged ({0})" -f $NpcDisplayCachePath)
}

$shouldWriteItemRewardCache = $itemRewardCacheDirty -or -not (Test-Path $ItemRewardCachePath)
if ($shouldWriteItemRewardCache) {
    $itemRewardOut = [ordered]@{}
    foreach ($k in @($itemRewardCache.Keys | Sort-Object)) {
        $itemRewardOut[[string]$k] = ConvertTo-HashtableRecursive $itemRewardCache[$k]
    }
    ($itemRewardOut | ConvertTo-Json -Depth 10) | Set-Content -Path $ItemRewardCachePath
    Write-Log ("Wrote item-reward cache to {0} with {1} entries" -f $ItemRewardCachePath, $itemRewardOut.Count)
}
else {
    Write-Log ("No item-reward lookups performed; kept existing item-reward cache unchanged ({0})" -f $ItemRewardCachePath)
}

$shouldWriteSpellRewardCache = $spellRewardCacheDirty -or -not (Test-Path $SpellRewardCachePath)
if ($shouldWriteSpellRewardCache) {
    $spellRewardOut = [ordered]@{}
    foreach ($k in @($spellRewardCache.Keys | Sort-Object)) {
        $spellRewardOut[[string]$k] = ConvertTo-HashtableRecursive $spellRewardCache[$k]
    }
    ($spellRewardOut | ConvertTo-Json -Depth 10) | Set-Content -Path $SpellRewardCachePath
    Write-Log ("Wrote spell-reward cache to {0} with {1} entries" -f $SpellRewardCachePath, $spellRewardOut.Count)
}
else {
    Write-Log ("No spell-reward lookups performed; kept existing spell-reward cache unchanged ({0})" -f $SpellRewardCachePath)
}

$lines = @()
$lines += 'local ADDON_NAME = ...'
$lines += 'local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)'
$lines += ''
$lines += 'Addon.RewardPreviewDb = Addon.RewardPreviewDb or {}'
$lines += ('Addon.RewardPreviewDb.GeneratedAt = "{0}"' -f (Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))
$lines += ('Addon.RewardPreviewDb.RawCachePath = "{0}"' -f ($RawCachePath -replace '\\','\\\\'))
$lines += ('Addon.RewardPreviewDb.OverridesPath = "{0}"' -f ($OverridesPath -replace '\\','\\\\'))
$lines += ('Addon.RewardPreviewDb.ItemRewardCachePath = "{0}"' -f ($ItemRewardCachePath -replace '\\','\\\\'))
$lines += ('Addon.RewardPreviewDb.SpellRewardCachePath = "{0}"' -f ($SpellRewardCachePath -replace '\\','\\\\'))
$lines += 'Addon.RewardPreviewDb.Achievements = {'
$lines += $rows
$lines += '}'
$lines += ''

Set-Content -Path $OutputPath -Value $lines

Write-Log ("Done. SourceAchievements={0}, ScannedNow={1}, ScanFailures={2}, DBEntries={3}, SkippedNoSupportedType={4}" -f $allIds.Count, $idsToScan.Count, $scanFailures, $keptAchievements, $skippedNoViewable)
if ($failedAchievementIds.Count -gt 0) {
    $failedIdsText = (($failedAchievementIds | Sort-Object -Unique) -join ", ")
    Write-Log ("FailedAchievementIds: {0}" -f $failedIdsText) "WARN"
    Write-Host ("Failed Achievement IDs: {0}" -f $failedIdsText)
}
else {
    Write-Log "FailedAchievementIds: none"
    Write-Host "Failed Achievement IDs: none"
}
Write-Host "Wrote $OutputPath with $keptAchievements achievement entries."
