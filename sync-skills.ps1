# sync-skills.ps1 - Sync persona skills to existing vaults
# Usage: .\sync-skills.ps1 [-VaultsDir <path>]
#
# Finds all vaults in the specified directory and syncs skills from this repo.
# Shows diffs and asks for confirmation before updating.

param(
    [string]$VaultsDir = "$env:USERPROFILE\vibe\vaults"
)

$ErrorActionPreference = "Stop"

# Get the directory where this script lives (the repo)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSource = Join-Path $ScriptDir "vault-skills"

# Personas to sync
$Personas = @("laura", "alex", "riley")

Write-Host "=== Skill Sync Tool ===" -ForegroundColor Blue
Write-Host "Source: $SkillsSource"
Write-Host "Vaults: $VaultsDir"
Write-Host ""

# Check source exists
if (-not (Test-Path $SkillsSource)) {
    Write-Host "Error: Skills source not found at $SkillsSource" -ForegroundColor Red
    exit 1
}

# Check vaults directory exists
if (-not (Test-Path $VaultsDir)) {
    Write-Host "Error: Vaults directory not found at $VaultsDir" -ForegroundColor Red
    exit 1
}

# Find all vaults (directories containing .claude\skills\)
$Vaults = @()
Get-ChildItem -Path $VaultsDir -Recurse -Directory -Filter "skills" -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -like "*\.claude\skills" } |
    ForEach-Object {
        $Vaults += (Split-Path -Parent (Split-Path -Parent $_.FullName))
    }

$Vaults = $Vaults | Select-Object -Unique

if ($Vaults.Count -eq 0) {
    Write-Host "No vaults found in $VaultsDir" -ForegroundColor Yellow
    Write-Host "Looking for directories containing .claude\skills\"
    exit 0
}

Write-Host "Found $($Vaults.Count) vault(s):" -ForegroundColor Green
foreach ($vault in $Vaults) {
    Write-Host "  - $(Split-Path -Leaf $vault)"
}
Write-Host ""

# Track statistics
$Updated = 0
$Skipped = 0
$Created = 0
$Unchanged = 0

# Process each vault
foreach ($vault in $Vaults) {
    $vaultName = Split-Path -Leaf $vault
    Write-Host "--- $vaultName ---" -ForegroundColor Blue

    foreach ($persona in $Personas) {
        $sourceFile = Join-Path $SkillsSource "$persona\SKILL.md"
        $targetDir = Join-Path $vault ".claude\skills\$persona"
        $targetFile = Join-Path $targetDir "SKILL.md"

        # Check if source exists
        if (-not (Test-Path $sourceFile)) {
            continue
        }

        # If target doesn't exist, offer to create
        if (-not (Test-Path $targetFile)) {
            Write-Host "  ${persona}: " -NoNewline
            Write-Host "Not installed" -ForegroundColor Yellow
            $response = Read-Host "    Install $persona? [y/N]"
            if ($response -eq 'y' -or $response -eq 'Y') {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
                Copy-Item $sourceFile $targetFile
                Write-Host "    Installed" -ForegroundColor Green
                $Created++
            } else {
                $Skipped++
            }
            continue
        }

        # Compare files
        $sourceContent = Get-Content $sourceFile -Raw
        $targetContent = Get-Content $targetFile -Raw

        if ($sourceContent -eq $targetContent) {
            Write-Host "  ${persona}: " -NoNewline
            Write-Host "Up to date" -ForegroundColor Green
            $Unchanged++
            continue
        }

        # Files differ - show info and ask
        Write-Host "  ${persona}: " -NoNewline
        Write-Host "Changes available" -ForegroundColor Yellow
        Write-Host ""

        # Show basic diff info
        $sourceLines = (Get-Content $sourceFile).Count
        $targetLines = (Get-Content $targetFile).Count
        Write-Host "    Repo version: $sourceLines lines"
        Write-Host "    Vault version: $targetLines lines"
        Write-Host "    Difference: $($sourceLines - $targetLines) lines"
        Write-Host ""

        # Ask what to do
        Write-Host "    Options:"
        Write-Host "      [u] Update (overwrite vault version with repo version)"
        Write-Host "      [b] Backup & update (save old version as SKILL.md.bak)"
        Write-Host "      [d] Show diff (requires diff tool)"
        Write-Host "      [s] Skip"
        $choice = Read-Host "    Choice [u/b/d/s]"

        switch ($choice.ToLower()) {
            'u' {
                Copy-Item $sourceFile $targetFile -Force
                Write-Host "    Updated" -ForegroundColor Green
                $Updated++
            }
            'b' {
                Copy-Item $targetFile "$targetFile.bak" -Force
                Copy-Item $sourceFile $targetFile -Force
                Write-Host "    Backed up and updated" -ForegroundColor Green
                $Updated++
            }
            'd' {
                # Try to show diff
                if (Get-Command "code" -ErrorAction SilentlyContinue) {
                    & code --diff $targetFile $sourceFile
                    Write-Host "    Opened in VS Code diff viewer"
                } else {
                    Write-Host "    No diff tool available. Install VS Code for diff viewing."
                }
                $response = Read-Host "    Update? [y/N]"
                if ($response -eq 'y' -or $response -eq 'Y') {
                    Copy-Item $sourceFile $targetFile -Force
                    Write-Host "    Updated" -ForegroundColor Green
                    $Updated++
                } else {
                    Write-Host "    Skipped" -ForegroundColor Yellow
                    $Skipped++
                }
            }
            default {
                Write-Host "    Skipped" -ForegroundColor Yellow
                $Skipped++
            }
        }
    }
    Write-Host ""
}

# Summary
Write-Host "=== Summary ===" -ForegroundColor Blue
Write-Host "  Updated:   $Updated" -ForegroundColor Green
Write-Host "  Created:   $Created" -ForegroundColor Green
Write-Host "  Unchanged: $Unchanged"
Write-Host "  Skipped:   $Skipped" -ForegroundColor Yellow
