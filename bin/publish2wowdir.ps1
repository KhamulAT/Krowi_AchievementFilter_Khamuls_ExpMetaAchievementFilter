# -------------------------
# Config
# -------------------------

$TargetRoot = "D:\World of Warcraft\_retail_\Interface\AddOns\Krowi_AchievementFilter_Khamuls_ExpMetaAchievementFilter"

# Debounce window (ms): wait this long without new triggers before deploying
$DebounceMs = 750

# Lock behavior
$LockWaitMs      = 15000  # max time to wait for an existing deploy to finish
$LockPollInterval = 200   # poll interval while waiting for lock

# -------------------------
# Resolve paths (repo root)
# -------------------------

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceRoot = Resolve-Path (Join-Path $ScriptDir "..") | Select-Object -ExpandProperty Path

Write-Host "Source: $SourceRoot"
Write-Host "Target: $TargetRoot"

# -------------------------
# Safety guard (recommended)
# -------------------------

if ($TargetRoot -notmatch '\\Interface\\AddOns\\') {
    throw "Safety guard triggered: TargetRoot does not look like a WoW AddOns path: $TargetRoot"
}

# -------------------------
# Exclusions
# -------------------------

$ExcludeDirs = @(
    ".git",
    ".vscode",
    "bin",
    "Release_Archive",
    "Resources"
)

$ExcludeFiles = @(
    ".gitignore"
)

# -------------------------
# Lock + Debounce helpers
# -------------------------

$LockPath     = Join-Path $TargetRoot ".deploy.lock"
$DebouncePath = Join-Path $TargetRoot ".deploy.debounce"

function Acquire-Lock {
    param(
        [string]$Path,
        [int]$WaitMs,
        [int]$PollMs
    )

    $deadline = [DateTime]::UtcNow.AddMilliseconds($WaitMs)

    while ($true) {
        try {
            # Use exclusive create so only one process can create the lock
            $fs = [System.IO.File]::Open($Path, [System.IO.FileMode]::CreateNew, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
            $writer = New-Object System.IO.StreamWriter($fs)
            $writer.WriteLine("pid=$PID")
            $writer.WriteLine("time_utc=$([DateTime]::UtcNow.ToString('o'))")
            $writer.Flush()
            $writer.Dispose()
            $fs.Dispose()
            return
        }
        catch {
            if ([DateTime]::UtcNow -ge $deadline) {
                throw "Timeout waiting for deploy lock: $Path"
            }
            Start-Sleep -Milliseconds $PollMs
        }
    }
}

function Release-Lock {
    param([string]$Path)
    if (Test-Path $Path) {
        Remove-Item -Path $Path -Force -ErrorAction SilentlyContinue
    }
}

function Touch-File {
    param([string]$Path)
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
    Set-Content -Path $Path -Value "$([DateTime]::UtcNow.ToString('o'))" -Encoding ASCII
}

# -------------------------
# Ensure target exists (needed for lock/debounce files)
# -------------------------

if (-not (Test-Path $TargetRoot)) {
    New-Item -ItemType Directory -Path $TargetRoot | Out-Null
}

# -------------------------
# Debounce: coalesce rapid triggers
# -------------------------

# Mark "a deploy was requested now"
Touch-File -Path $DebouncePath

# Wait until the file hasn't changed for DebounceMs
while ($true) {
    $t1 = (Get-Item $DebouncePath).LastWriteTimeUtc
    Start-Sleep -Milliseconds $DebounceMs
    $t2 = (Get-Item $DebouncePath).LastWriteTimeUtc

    if ($t1 -eq $t2) {
        break
    }
    # Another trigger happened during the wait -> loop again
}

# -------------------------
# Acquire lock and re-check debounce (avoid redundant deploy)
# -------------------------

Acquire-Lock -Path $LockPath -WaitMs $LockWaitMs -PollMs $LockPollInterval

try {
    # If a new trigger happened while we waited for the lock, restart debounce
    $tBefore = (Get-Item $DebouncePath).LastWriteTimeUtc
    Start-Sleep -Milliseconds $DebounceMs
    $tAfter = (Get-Item $DebouncePath).LastWriteTimeUtc
    if ($tBefore -ne $tAfter) {
        Write-Host "New save detected while waiting for lock; restarting debounce..."
        Release-Lock -Path $LockPath
        & $MyInvocation.MyCommand.Path
        exit 0
    }

    # -------------------------
    # Deploy
    # -------------------------

    Write-Host "Cleaning target directory..."
    Get-ChildItem -Path $TargetRoot -Force | Where-Object {
        $_.Name -notin @(".deploy.lock", ".deploy.debounce")
    } | ForEach-Object {
        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
    }

    Write-Host "Excluded directories: $($ExcludeDirs -join ', ')"
    Write-Host "Excluded files: $($ExcludeFiles -join ', ')"

    $null = robocopy `
        $SourceRoot `
        $TargetRoot `
        /E `
        /COPY:DAT /DCOPY:DAT `
        /XD @($ExcludeDirs) `
        /XF @($ExcludeFiles) `
        /R:2 /W:1 `
        /NFL /NDL /NJH /NJS /NP

    if ($LASTEXITCODE -ge 8) {
        throw "Robocopy failed with exit code $LASTEXITCODE"
    }

    Write-Host "Addon files successfully deployed. (Robocopy exit code: $LASTEXITCODE)"
}
finally {
    Release-Lock -Path $LockPath
}
