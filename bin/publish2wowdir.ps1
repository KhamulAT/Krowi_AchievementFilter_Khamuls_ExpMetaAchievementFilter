# Source and target paths
$SourceRoot = Resolve-Path "..\bin"
$TargetRoot = "D:\World of Warcraft\_retail_\Interface\AddOns\Krowi_AchievementFilter_Khamuls_ExpMetaAchievementFilter"

# Ensure target directory exists
if (-not (Test-Path $TargetRoot)) {
    New-Item -ItemType Directory -Path $TargetRoot | Out-Null
}

Write-Host "Source: $SourceRoot"
Write-Host "Target: $TargetRoot"

# -------------------------
# Copy directories
# -------------------------
$Directories = @(
    "Data",
    "Libs",
    "Localization"
)

foreach ($dir in $Directories) {
    $src = Join-Path $SourceRoot $dir
    $dst = Join-Path $TargetRoot $dir

    if (Test-Path $src) {
        Write-Host "Copying directory: $dir"
        robocopy $src $dst /E /NFL /NDL /NJH /NJS /NP /R:2 /W:1 | Out-Null
    }
    else {
        Write-Warning "Directory not found: $src"
    }
}

# -------------------------
# Copy Lua and TOC files
# -------------------------
Write-Host "Copying .lua and .toc files"

Get-ChildItem -Path $SourceRoot -File -Include *.lua, *.toc | ForEach-Object {
    $destination = Join-Path $TargetRoot $_.Name
    Copy-Item $_.FullName -Destination $destination -Force
}

# -------------------------
# Copy LICENSE and README.md
# -------------------------
$SpecialFiles = @(
    "LICENSE",
    "README.md"
)

foreach ($file in $SpecialFiles) {
    $src = Join-Path $SourceRoot $file
    if (Test-Path $src) {
        Write-Host "Copying file: $file"
        Copy-Item $src -Destination $TargetRoot -Force
    }
    else {
        Write-Warning "File not found: $src"
    }
}

Write-Host "Addon files successfully updated."
