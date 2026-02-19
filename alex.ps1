# Alex - Solution Architect Persona
# Architectural decisions, system design, technology evaluation

# Check if we're in a research/project vault
if (-not (Test-Path "CLAUDE.md") -or -not (Test-Path ".bloglog")) {
    Write-Host "👋 Hi! I'm Alex, your solution architect." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "It looks like you're not in a research/project vault."
    Write-Host ""
    Write-Host "To start:"
    Write-Host "  1. Create a vault: .\setup-vault.ps1 -VaultPath `"$env:USERPROFILE\vaults\my-project`""
    Write-Host "  2. Navigate to it: cd `"$env:USERPROFILE\vaults\my-project`""
    Write-Host "  3. Launch me: .\alex.ps1"
    Write-Host ""
    exit 1
}

# Welcome message
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  🏗️  Hi! I'm Alex - your solution architect           ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Architecture • Technology • Design Decisions         ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
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

# Show recent architecture decisions if any exist
if (Test-Path "architecture\decisions") {
    $adrFiles = Get-ChildItem -Path "architecture\decisions" -Filter "*.md" -ErrorAction SilentlyContinue
    if ($adrFiles.Count -gt 0) {
        Write-Host "Architecture decisions: " -NoNewline -ForegroundColor Blue
        Write-Host "$($adrFiles.Count) ADRs documented"
        Write-Host "Recent:"
        $adrFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 3 | ForEach-Object {
            $title = Get-Content $_.FullName | Where-Object { $_ -match "^# " } | Select-Object -First 1
            if ($title) {
                $title = $title -replace "^# ", ""
                Write-Host "  • $title"
            }
        }
        Write-Host ""
    }
}

Write-Host "I can help with:" -ForegroundColor Yellow
Write-Host "  • Architectural decisions (ADRs)"
Write-Host "  • Technology evaluation and comparison"
Write-Host "  • System design and architecture"
Write-Host "  • Non-functional requirements"
Write-Host "  • Technical risk assessment"
Write-Host ""
Write-Host "Quick start:" -ForegroundColor Yellow
Write-Host '  "Evaluate options for [technology area]"'
Write-Host '  "Create an ADR for [architectural decision]"'
Write-Host '  "Design the architecture for [system]"'
Write-Host '  "What are the risks of [approach]?"'
Write-Host ""
Write-Host "Collaboration:" -ForegroundColor Yellow
Write-Host "  • I build on Laura's research"
Write-Host "  • I work with Riley on business context"
Write-Host "  • I flag implementation concerns for Morgan"
Write-Host ""
Write-Host "Let's build solid architecture! 🏗️" -ForegroundColor Cyan
Write-Host ""

# Launch Claude Code
claude
