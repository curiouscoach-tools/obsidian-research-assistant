# Obsidian Vault Setup Script (Windows)
# Usage: .\setup-vault.ps1 -VaultPath <path> [-VaultName <name>] [-VaultType <type>] [-Personas <list>]

param(
    [Parameter(Mandatory=$true)]
    [string]$VaultPath,

    [Parameter(Mandatory=$false)]
    [string]$VaultName,

    [Parameter(Mandatory=$false)]
    [ValidateSet("research", "reflection", "programme")]
    [string]$VaultType = "research",

    [Parameter(Mandatory=$false)]
    [string]$Personas,

    [Parameter(Mandatory=$false)]
    [ValidateSet("academic", "professional")]
    [string]$Context = "professional"
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

# Set default personas based on vault type
if (-not $Personas) {
    switch ($VaultType) {
        "reflection" { $PersonaList = @("casey") }
        default { $PersonaList = @("laura", "alex", "riley") }
    }
} else {
    $PersonaList = $Personas -split ","
}

$CurrentDate = Get-Date -Format "yyyy-MM-dd"

Write-Host "Creating $VaultType vault: $VaultName" -ForegroundColor Green
Write-Host "Location: $VaultPath"
$displayPersonas = $PersonaList | ForEach-Object {
    if ($_ -eq "laura") { "laura ($Context)" } else { $_ }
}
Write-Host "Personas: $($displayPersonas -join ', ')"
Write-Host ""

# Check prerequisites
Write-Host "Checking prerequisites..."

# Check Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: git is not installed" -ForegroundColor Red
    Write-Host "Please install Git for Windows from: https://git-scm.com/download/win"
    exit 1
}

# Create vault directory structure based on type
Write-Host "Creating vault structure..."
switch ($VaultType) {
    "reflection" {
        $dirs = @(
            "$VaultPath\journal\daily",
            "$VaultPath\journal\weekly",
            "$VaultPath\journal\monthly",
            "$VaultPath\journal\quarterly",
            "$VaultPath\themes",
            "$VaultPath\_meta",
            "$VaultPath\_templates"
        )
    }
    "programme" {
        $dirs = @(
            "$VaultPath\architecture\decisions",
            "$VaultPath\architecture\comparisons",
            "$VaultPath\architecture\designs",
            "$VaultPath\architecture\diagrams",
            "$VaultPath\architecture\risks",
            "$VaultPath\product\user-stories",
            "$VaultPath\product\value-hypotheses",
            "$VaultPath\product\roadmap",
            "$VaultPath\requirements\functional",
            "$VaultPath\requirements\non-functional",
            "$VaultPath\requirements\stakeholders",
            "$VaultPath\technical\spikes",
            "$VaultPath\technical\implementation",
            "$VaultPath\technical\risks",
            "$VaultPath\process\sprint-plans",
            "$VaultPath\process\retrospectives",
            "$VaultPath\process\blockers",
            "$VaultPath\research\sources\raw",
            "$VaultPath\research\concepts",
            "$VaultPath\research\themes",
            "$VaultPath\discussions",
            "$VaultPath\_meta",
            "$VaultPath\_templates"
        )
    }
    default {
        $dirs = @(
            "$VaultPath\sources\raw",
            "$VaultPath\concepts",
            "$VaultPath\themes",
            "$VaultPath\questions",
            "$VaultPath\_meta",
            "$VaultPath\_templates"
        )
    }
}

foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

# Copy templates based on vault type
Write-Host "Installing templates..."
if ($VaultType -eq "reflection") {
    # Only copy reflection templates
    Copy-Item -Path "$ScriptDir\templates\daily-reflection.md" -Destination "$VaultPath\_templates\" -Force
    Copy-Item -Path "$ScriptDir\templates\weekly-review.md" -Destination "$VaultPath\_templates\" -Force
    Copy-Item -Path "$ScriptDir\templates\monthly-review.md" -Destination "$VaultPath\_templates\" -Force
    Copy-Item -Path "$ScriptDir\templates\quarterly-review.md" -Destination "$VaultPath\_templates\" -Force
} else {
    Copy-Item -Path "$ScriptDir\templates\*" -Destination "$VaultPath\_templates\" -Recurse -Force
}

# Install selected personas
Write-Host "Installing personas ($($PersonaList -join ', '))..."
New-Item -ItemType Directory -Force -Path "$VaultPath\.claude\skills" | Out-Null
foreach ($persona in $PersonaList) {
    if ($persona -eq "laura") {
        # Handle laura variants based on context
        $lauraVariant = "laura-$Context"
        $variantPath = "$ScriptDir\vault-skills\$lauraVariant"
        if (Test-Path $variantPath) {
            Write-Host "  - laura ($Context)"
            Copy-Item -Path $variantPath -Destination "$VaultPath\.claude\skills\laura" -Recurse -Force
        } else {
            Write-Host "  - laura (variant '$Context' not found, using default)" -ForegroundColor Yellow
            $defaultPath = "$ScriptDir\vault-skills\laura"
            Copy-Item -Path $defaultPath -Destination "$VaultPath\.claude\skills\" -Recurse -Force
        }
    } else {
        $personaPath = "$ScriptDir\vault-skills\$persona"
        if (Test-Path $personaPath) {
            Write-Host "  - $persona"
            Copy-Item -Path $personaPath -Destination "$VaultPath\.claude\skills\" -Recurse -Force
        } else {
            Write-Host "  - $persona (not found, skipping)" -ForegroundColor Yellow
        }
    }
}

# Create .gitignore
Write-Host "Creating .gitignore..."
Copy-Item -Path "$ScriptDir\config\gitignore.template" -Destination "$VaultPath\.gitignore" -Force

# Create README and CLAUDE.md based on vault type
if ($VaultType -eq "reflection") {
    # Reflection README
    Write-Host "Creating README..."
    $readmeContent = @"
# $VaultName

## Purpose
[Describe what this reflection vault is for - work journal, personal growth, learning log, etc.]

## Structure

```
├── journal/
│   ├── daily/      Daily reflections
│   ├── weekly/     Weekly reviews
│   ├── monthly/    Monthly reviews
│   └── quarterly/  Quarterly reviews
├── themes/         Recurring patterns and growth areas
├── _meta/          Tracking files
└── _templates/     Note templates
```

## How to Use

### Daily Reflection
- End of day: Capture what happened, what you learned, what's tomorrow
- Use template from ``_templates/daily-reflection.md``

### Reviews
- Weekly: Synthesise the week, spot patterns, set intentions
- Monthly: Check against goals, track growth trajectory
- Quarterly: Big picture review, set new goals

### Tracking Progress
- Session summaries go in ``_meta/reflection-log.md``
- Things to explore go in ``_meta/reflection-backlog.md``
- Growth objectives in ``_meta/growth-goals.md``

## Working with Casey

Signal when you're done reflecting:
- "That's my reflection for today"
- "Let's wrap up"
- "Save and commit"

Casey will summarise, update tracking files, and commit changes.
"@
    Set-Content -Path "$VaultPath\README.md" -Value $readmeContent -Encoding UTF8

    # Reflection CLAUDE.md
    Write-Host "Creating CLAUDE.md..."
    $claudeContent = @"
# $VaultName - Reflection Context

**You are Casey, a reflection buddy.** Follow your casey skill to help with journaling and growth tracking.

## Casey Configuration

**Journal type:** [Work/Professional | Personal | Learning | Custom]

**Daily prompts:**
- What went well today?
- What was challenging?
- What did I learn?
- What does tomorrow look like?

**Weekly focus areas:**
- Growth themes
- Energy patterns
- [Custom focus]

**Goals:**
- [Link to growth-goals.md or list here]

**Prompting:** [Active (remind me if I miss days) | Passive (only when I ask)]

## Current Focus

**Phase:** [Starting out | Building habit | Established practice]

**Growth Areas:**
- [Area 1]
- [Area 2]

## Working with Casey

**Starting a session:** Casey will check your reflection backlog and recent entries.

**Ending a session:** Signal when you're done:
- "That's my reflection for today"
- "Let's wrap up"
- "Save and commit"

Casey will then summarise, update tracking files, and commit changes.

## Notes
[Any personal preferences, things Casey should know about your context]
"@
    Set-Content -Path "$VaultPath\CLAUDE.md" -Value $claudeContent -Encoding UTF8

    # Reflection meta files
    Write-Host "Creating reflection log..."
    $reflectionLog = @"
# Reflection Log - $VaultName

## Overview
Casey's observations and session summaries.

## Timeline

### $CurrentDate - Vault Created
- Initial reflection vault created
- Templates installed
- Ready to begin journaling

---

## Patterns Noticed
[Casey will add observations here over time]

## Growth Markers
[Significant progress points]
"@
    Set-Content -Path "$VaultPath\_meta\reflection-log.md" -Value $reflectionLog -Encoding UTF8

    Write-Host "Creating reflection backlog..."
    $reflectionBacklog = @"
# Reflection Backlog - $VaultName

## To Explore
- [ ] Set up daily reflection habit
- [ ] Define growth goals

## To Develop
[Skills or areas to work on]

## To Revisit
[Past reflections or decisions to check on]

## Completed
- [x] Set up vault structure
"@
    Set-Content -Path "$VaultPath\_meta\reflection-backlog.md" -Value $reflectionBacklog -Encoding UTF8

    Write-Host "Creating growth goals..."
    $growthGoals = @"
# Growth Goals - $VaultName

## Current Goals

### Goal 1: [Title]
**Why:** [Why this matters]
**Success looks like:** [How you'll know you've achieved it]
**Progress:** [Notes on progress]

### Goal 2: [Title]
**Why:** [Why this matters]
**Success looks like:** [How you'll know you've achieved it]
**Progress:** [Notes on progress]

## Completed Goals
[Move goals here when achieved, with reflection on the journey]

## Parked Goals
[Goals you've deprioritised for now]
"@
    Set-Content -Path "$VaultPath\_meta\growth-goals.md" -Value $growthGoals -Encoding UTF8

} else {
    # Research/Programme README
    Write-Host "Creating README..."
    $readmeContent = Get-Content -Path "$ScriptDir\config\vault-readme.template" -Raw
    $readmeContent = $readmeContent -replace '{{vault_name}}', $VaultName
    Set-Content -Path "$VaultPath\README.md" -Value $readmeContent -Encoding UTF8

    # Research/Programme CLAUDE.md
    Write-Host "Creating CLAUDE.md..."
    $claudeContent = Get-Content -Path "$ScriptDir\config\vault-claude.template" -Raw
    $claudeContent = $claudeContent -replace '{{vault_name}}', $VaultName
    $claudeContent = $claudeContent -replace '{{date}}', $CurrentDate
    Set-Content -Path "$VaultPath\CLAUDE.md" -Value $claudeContent -Encoding UTF8

    # Research meta files
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
}

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
$personaString = $PersonaList -join ", "
$commitMessage = @"
Initial vault setup for $VaultName

- Created $VaultType vault structure
- Installed templates
- Installed personas: $personaString
- Ready to use
"@
git commit -m $commitMessage

Pop-Location

Write-Host ""
Write-Host "Vault created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Location: $VaultPath"
Write-Host "Type: $VaultType"
Write-Host "Personas: $personaString"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Open vault in Obsidian: File -> Open folder as vault -> $VaultPath"
Write-Host "2. Edit CLAUDE.md to customize your setup"
Write-Host "3. Run 'claude' in the vault directory"
$personaCommands = ($PersonaList | ForEach-Object { "/$_" }) -join " or "
Write-Host "4. Type $personaCommands to get started"
Write-Host ""
Write-Host "Optional:"
Write-Host "- Connect to GitHub for backup:"
Write-Host "  cd '$VaultPath'"
Write-Host "  git remote add origin <your-github-repo-url>"
Write-Host "  git push -u origin main"
Write-Host ""
