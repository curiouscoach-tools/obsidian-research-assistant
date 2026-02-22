# Obsidian Research Assistant - Vault Setup Script (Windows)
# Usage: .\setup-vault.ps1 -VaultPath <path> [-VaultName <name>]

param(
    [Parameter(Mandatory=$true)]
    [string]$VaultPath,
    
    [Parameter(Mandatory=$false)]
    [string]$VaultName
)

# Set strict mode
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Set vault name
if (-not $VaultName) {
    $VaultName = Split-Path -Leaf $VaultPath
}

$CurrentDate = Get-Date -Format "yyyy-MM-dd"

Write-Host "Creating research vault: $VaultName" -ForegroundColor Green
Write-Host "Location: $VaultPath"
Write-Host ""

# Check prerequisites
Write-Host "Checking prerequisites..."

# Check Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: git is not installed" -ForegroundColor Red
    Write-Host "Please install Git for Windows from: https://git-scm.com/download/win"
    exit 1
}

# Create vault directory structure
Write-Host "Creating vault structure..."
$dirs = @(
    "$VaultPath\sources\raw",
    "$VaultPath\concepts",
    "$VaultPath\themes",
    "$VaultPath\questions",
    "$VaultPath\_meta",
    "$VaultPath\_templates"
)

foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

# Copy templates
Write-Host "Installing templates..."
Copy-Item -Path "$ScriptDir\templates\*" -Destination "$VaultPath\_templates\" -Recurse -Force

# Create .gitignore
Write-Host "Creating .gitignore..."
Copy-Item -Path "$ScriptDir\config\gitignore.template" -Destination "$VaultPath\.gitignore" -Force

# Create README
Write-Host "Creating README..."
$readmeContent = Get-Content -Path "$ScriptDir\config\vault-readme.template" -Raw
$readmeContent = $readmeContent -replace '{{vault_name}}', $VaultName
Set-Content -Path "$VaultPath\README.md" -Value $readmeContent -Encoding UTF8

# Create vault-specific CLAUDE.md
Write-Host "Creating CLAUDE.md..."
$claudeContent = Get-Content -Path "$ScriptDir\config\vault-claude.template" -Raw
$claudeContent = $claudeContent -replace '{{vault_name}}', $VaultName
$claudeContent = $claudeContent -replace '{{date}}', $CurrentDate
Set-Content -Path "$VaultPath\CLAUDE.md" -Value $claudeContent -Encoding UTF8

# Create research log
Write-Host "Creating research log..."
$researchLog = @"
# Research Log - $VaultName

## Overview
This log tracks the evolution of research in this vault.

## Timeline

### $CurrentDate - Vault Created
- Initial vault structure created
- Templates installed
- Ready for research to begin

---

## How to Use This Log

After significant research sessions, add an entry:
- Date
- What you explored
- Key findings or insights
- Questions that emerged
- Next steps

Use this to track session-by-session progress and key insights.
"@
Set-Content -Path "$VaultPath\_meta\research-log.md" -Value $researchLog -Encoding UTF8

# Create research backlog
Write-Host "Creating research backlog..."
$researchBacklog = @"
# Research Backlog - $VaultName

## High Priority
- [ ] Define initial research questions
- [ ] Identify key sources to find

## Medium Priority
[Add items as research progresses]

## Low Priority / Later
[Add items as research progresses]

## Completed
- [x] Set up vault structure
"@
Set-Content -Path "$VaultPath\_meta\research-backlog.md" -Value $researchBacklog -Encoding UTF8

# Create domain context
Write-Host "Creating domain context..."
$domainContext = @"
# Domain Context - $VaultName

## Current Understanding

### Core Concepts
[To be developed as research progresses]

### Key Themes
[To be developed as research progresses]

### Important Sources
[To be developed as research progresses]

## Knowledge Gaps

### What We Need to Understand
[To be developed as research progresses]

### Open Questions
[See /questions/ folder for detailed question notes]

## Research Strategy

### Current Focus
[What are you researching right now?]

### Next Steps
[What should you research next?]

---

*This document should be updated periodically to reflect current understanding and guide future research*
"@
Set-Content -Path "$VaultPath\_meta\domain-context.md" -Value $domainContext -Encoding UTF8

# Initialize git
Write-Host "Initializing git repository..."
Push-Location $VaultPath
git init

# Configure git if needed
$gitUserName = git config user.name
$gitUserEmail = git config user.email

if (-not $gitUserName) {
    Write-Host "Git user name not configured" -ForegroundColor Yellow
    $userName = Read-Host "Enter your name for git commits"
    git config user.name $userName
}

if (-not $gitUserEmail) {
    Write-Host "Git user email not configured" -ForegroundColor Yellow
    $userEmail = Read-Host "Enter your email for git commits"
    git config user.email $userEmail
}

# Initial git commit
Write-Host "Creating initial commit..."
git add .
$commitMessage = @"
Initial vault setup for $VaultName

- Created directory structure
- Installed note templates
- Initialized research log and domain context
- Ready for research
"@
git commit -m $commitMessage

Pop-Location

Write-Host ""
Write-Host "✓ Vault created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Location: $VaultPath"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Open vault in Obsidian: File → Open folder as vault → $VaultPath"
Write-Host "2. Edit CLAUDE.md to describe your research focus"
Write-Host "3. Start researching with Claude Code"
Write-Host ""
Write-Host "Optional:"
Write-Host "- Connect to GitHub for backup:"
Write-Host "  cd '$VaultPath'"
Write-Host "  git remote add origin <your-github-repo-url>"
Write-Host "  git push -u origin main"
Write-Host ""
