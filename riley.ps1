# Riley - Product Owner Persona
# User stories, value propositions, prioritisation

# Check if we're in a research/project vault
if (-not (Test-Path "CLAUDE.md") -or -not (Test-Path ".bloglog")) {
    Write-Host "Hi! I'm Riley, your product owner." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "It looks like you're not in a research/project vault."
    Write-Host ""
    Write-Host "To start:"
    Write-Host "  1. Create a vault: .\setup-vault.ps1 -VaultPath `"$env:USERPROFILE\vaults\my-project`""
    Write-Host "  2. Navigate to it: cd `"$env:USERPROFILE\vaults\my-project`""
    Write-Host "  3. Launch me: .\riley.ps1"
    Write-Host ""
    exit 1
}

# Welcome message
Write-Host "+========================================================+" -ForegroundColor Magenta
Write-Host "|                                                        |" -ForegroundColor Magenta
Write-Host "|  Hi! I'm Riley - your product owner                   |" -ForegroundColor Magenta
Write-Host "|                                                        |" -ForegroundColor Magenta
Write-Host "|  User Value * Prioritisation * Product Thinking       |" -ForegroundColor Magenta
Write-Host "|                                                        |" -ForegroundColor Magenta
Write-Host "+========================================================+" -ForegroundColor Magenta
Write-Host ""

# Read vault name from CLAUDE.md if possible
$vaultName = Get-Content "CLAUDE.md" -First 1 -ErrorAction SilentlyContinue
if ($vaultName -match "^# (.+)") {
    $vaultName = $matches[1] -replace ' - Research Context$', ''
    Write-Host "Project: " -NoNewline -ForegroundColor Blue
    Write-Host $vaultName
} else {
    Write-Host "Project: " -NoNewline -ForegroundColor Blue
    Write-Host (Split-Path -Leaf (Get-Location))
}

# Show recent user stories if any exist
if (Test-Path "product\user-stories") {
    $storyFiles = Get-ChildItem -Path "product\user-stories" -Filter "*.md" -ErrorAction SilentlyContinue
    if ($storyFiles.Count -gt 0) {
        Write-Host "User stories: " -NoNewline -ForegroundColor Blue
        Write-Host "$($storyFiles.Count) documented"
        Write-Host "Recent:"
        $storyFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 3 | ForEach-Object {
            $title = Get-Content $_.FullName | Where-Object { $_ -match "^# " } | Select-Object -First 1
            if ($title) {
                $title = $title -replace "^# ", ""
                Write-Host "  - $title"
            }
        }
        Write-Host ""
    }
}

Write-Host "I can help with:" -ForegroundColor Yellow
Write-Host "  - Writing user stories"
Write-Host "  - Defining value propositions"
Write-Host "  - Prioritising features (MoSCoW, RICE)"
Write-Host "  - Understanding user needs"
Write-Host "  - Product roadmaps"
Write-Host ""
Write-Host "Quick start:" -ForegroundColor Yellow
Write-Host '  "Write user stories for [feature area]"'
Write-Host '  "Prioritise these features: [list]"'
Write-Host '  "What user problem does [idea] solve?"'
Write-Host '  "Create a value hypothesis for [assumption]"'
Write-Host ""
Write-Host "Collaboration:" -ForegroundColor Yellow
Write-Host "  - I build on Laura's research"
Write-Host "  - I work with Alex on feasibility"
Write-Host "  - I focus on user value, always"
Write-Host ""
Write-Host "Let's build the right thing!" -ForegroundColor Magenta
Write-Host ""

# Launch Claude Code
claude
