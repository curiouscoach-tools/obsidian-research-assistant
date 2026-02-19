# Laura - Lovable Artificially-intelligent Unflappable Research Assistant
# A friendly wrapper for launching Claude Code in research vaults

# Check if we're in a research vault
if (-not (Test-Path "CLAUDE.md") -or -not (Test-Path ".bloglog")) {
    Write-Host "👋 Hi! I'm Laura, your research assistant." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "It looks like you're not in a research vault."
    Write-Host ""
    Write-Host "To start:"
    Write-Host "  1. Create a vault: .\setup-vault.ps1 -VaultPath `"$env:USERPROFILE\vaults\my-research`""
    Write-Host "  2. Navigate to it: cd `"$env:USERPROFILE\vaults\my-research`""
    Write-Host "  3. Launch me: .\laura.ps1"
    Write-Host ""
    exit 1
}

# Welcome message
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                                                        ║" -ForegroundColor Green
Write-Host "║  👋 Hi! I'm Laura - your research assistant           ║" -ForegroundColor Green
Write-Host "║                                                        ║" -ForegroundColor Green
Write-Host "║  " -NoNewline -ForegroundColor Green
Write-Host "L" -NoNewline -ForegroundColor Blue
Write-Host "ovable " -NoNewline -ForegroundColor Green
Write-Host "A" -NoNewline -ForegroundColor Blue
Write-Host "rtificially-intelligent " -NoNewline -ForegroundColor Green
Write-Host "U" -NoNewline -ForegroundColor Blue
Write-Host "nflappable       ║" -ForegroundColor Green
Write-Host "║  " -NoNewline -ForegroundColor Green
Write-Host "R" -NoNewline -ForegroundColor Blue
Write-Host "esearch " -NoNewline -ForegroundColor Green
Write-Host "A" -NoNewline -ForegroundColor Blue
Write-Host "ssistant                                ║" -ForegroundColor Green
Write-Host "║                                                        ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

# Read vault name from CLAUDE.md if possible
$vaultName = Get-Content "CLAUDE.md" -First 1 -ErrorAction SilentlyContinue
if ($vaultName -match "^# (.+)") {
    $vaultName = $matches[1] -replace ' - Research Context$', ''
    Write-Host "Research vault: " -NoNewline -ForegroundColor Cyan
    Write-Host $vaultName
} else {
    Write-Host "Research vault: " -NoNewline -ForegroundColor Cyan
    Write-Host (Split-Path -Leaf (Get-Location))
}

# Show recent activity if BlogLog is available
if (Get-Command bl -ErrorAction SilentlyContinue) {
    Write-Host "Recent activity:" -ForegroundColor Cyan
    bl timeline --since "3 days ago" 2>$null | Select-Object -First 5
    Write-Host ""
}

Write-Host "Ready to help with:" -ForegroundColor Yellow
Write-Host "  • Research fundamentals of any topic"
Write-Host "  • Process papers and sources"
Write-Host "  • Build connected knowledge"
Write-Host "  • Track your progress"
Write-Host ""
Write-Host "Quick start:" -ForegroundColor Yellow
Write-Host '  "Research the fundamentals of [topic]"'
Write-Host '  "Process the paper I just added to sources/raw/"'
Write-Host '  "Summarize my progress this week"'
Write-Host ""
Write-Host "First time in this vault?" -ForegroundColor Yellow
Write-Host '  "Read CLAUDE.md to understand this research project,"'
Write-Host '  "then help me research [topic]"'
Write-Host ""
Write-Host "Let's build some knowledge! 🚀" -ForegroundColor Green
Write-Host ""

# Launch Claude Code
claude
