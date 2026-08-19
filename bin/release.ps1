# Packages the addon for release.
#
# Builds Release_Archive\<VERSION>.zip (version read from the TOC),
# containing a single top-level folder named after the addon with only the
# files required at runtime (allowlist below). Development-only files and
# folders (Release_Archive, Resources, tmp, bin, .git, .vscode, etc.) are
# excluded.
#
# Usage:
#   .\release.ps1

$ErrorActionPreference = "Stop"

# -------------------------
# Config
# -------------------------

$AddonName = "Krowi_AchievementFilter_Khamuls_ExpMetaAchievementFilter"

# Only these items end up in the package.
$IncludeFiles = @(
    "$AddonName.toc",
    "Core.lua",
    "Utilities.lua",
    "Options.lua",
    "LICENSE",
    "README.md"
)
$IncludeDirs = @(
    "Libs",
    "Localization",
    "DataSources"
)

# -------------------------
# Resolve paths
# -------------------------

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceRoot = Resolve-Path (Join-Path $ScriptDir "..") | Select-Object -ExpandProperty Path
$ReleaseDir = Join-Path $SourceRoot "Release_Archive"

# -------------------------
# Read version from the TOC
# -------------------------

$TocPath = Join-Path $SourceRoot "$AddonName.toc"
if (-not (Test-Path $TocPath)) {
    throw "TOC not found: $TocPath"
}

$versionMatch = Select-String -LiteralPath $TocPath -Pattern '^## Version:\s*(.+?)\s*$' | Select-Object -First 1
if (-not $versionMatch) {
    throw "No '## Version:' line found in $TocPath"
}
$Version = $versionMatch.Matches[0].Groups[1].Value

Write-Host "Addon:   $AddonName"
Write-Host "Version: $Version"

# -------------------------
# Stage files
# -------------------------

$StagingRoot = Join-Path $env:TEMP "kemaf_release_$PID"
$StagingDir  = Join-Path $StagingRoot $AddonName

if (Test-Path $StagingRoot) {
    Remove-Item -LiteralPath $StagingRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $StagingDir | Out-Null

foreach ($file in $IncludeFiles) {
    $src = Join-Path $SourceRoot $file
    if (Test-Path $src) {
        Copy-Item -LiteralPath $src -Destination $StagingDir
    } else {
        Write-Warning "Skipping missing file: $file"
    }
}

foreach ($dir in $IncludeDirs) {
    $src = Join-Path $SourceRoot $dir
    if (-not (Test-Path $src)) {
        throw "Required directory missing: $dir"
    }
    Copy-Item -LiteralPath $src -Destination $StagingDir -Recurse
}

# Strip development leftovers that may live inside included directories.
Get-ChildItem -Path $StagingDir -Recurse -Force -Directory |
    Where-Object { $_.Name -in @(".git", ".vscode") } |
    ForEach-Object { Remove-Item -LiteralPath $_.FullName -Recurse -Force }
Get-ChildItem -Path $StagingDir -Recurse -Force -File |
    Where-Object { $_.Name -in @(".gitignore", ".gitattributes", ".gitmodules") } |
    ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force }

# -------------------------
# Create the zip
# -------------------------

if (-not (Test-Path $ReleaseDir)) {
    New-Item -ItemType Directory -Path $ReleaseDir | Out-Null
}

$ZipPath = Join-Path $ReleaseDir "$Version.zip"
if (Test-Path $ZipPath) {
    Write-Warning "Overwriting existing $ZipPath"
    Remove-Item -LiteralPath $ZipPath -Force
}

Compress-Archive -Path $StagingDir -DestinationPath $ZipPath

Remove-Item -LiteralPath $StagingRoot -Recurse -Force

Write-Host "Created: $ZipPath"
