# Installing Laura - Your Research Assistant Launcher

Laura is a friendly command that launches Claude Code in your research vaults with context and helpful reminders.

## What Laura Does

When you type `laura` in a research vault, you get:
- 👋 Friendly welcome message
- 📊 Recent activity summary (if BlogLog available)
- 💡 Quick start suggestions
- 🚀 Launches Claude Code ready to help

## Installation

### Linux/macOS/WSL

**1. Copy laura to your PATH:**

```bash
# From the obsidian-research-assistant directory
sudo cp laura /usr/local/bin/
sudo chmod +x /usr/local/bin/laura
```

**Or add to your personal bin:**

```bash
mkdir -p ~/bin
cp laura ~/bin/
chmod +x ~/bin/laura

# Add to PATH if not already (add to ~/.bashrc or ~/.zshrc)
export PATH="$HOME/bin:$PATH"
```

**2. Test it:**

```bash
cd ~/vaults/your-research-vault
laura
```

### Windows

**Option A: Add to PATH (Recommended)**

1. Copy `laura.ps1` to a permanent location:
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\Scripts"
   Copy-Item laura.ps1 "$env:USERPROFILE\Scripts\laura.ps1"
   ```

2. Add to PATH:
   - Search "Environment Variables" in Windows
   - Edit "Path" under User variables
   - Add: `C:\Users\YourName\Scripts`
   - Click OK

3. Create a launcher batch file (optional, for easier typing):
   ```powershell
   @"
   @echo off
   powershell -ExecutionPolicy Bypass -File "%USERPROFILE%\Scripts\laura.ps1" %*
   "@ | Out-File -FilePath "$env:USERPROFILE\Scripts\laura.bat" -Encoding ASCII
   ```

4. Test it:
   ```powershell
   cd $env:USERPROFILE\vaults\your-research-vault
   laura
   ```

**Option B: Run from vault (Simpler)**

Just copy laura.ps1 into each vault:

```powershell
Copy-Item laura.ps1 "$env:USERPROFILE\vaults\my-research\"
cd "$env:USERPROFILE\vaults\my-research"
.\laura.ps1
```

## Usage

### Starting a Research Session

Instead of:
```bash
cd ~/vaults/my-research
claude-code
```

Just:
```bash
cd ~/vaults/my-research
laura
```

You'll get a friendly welcome with context about your vault!

### What Laura Shows

```
╔════════════════════════════════════════════════════════╗
║                                                        ║
║  👋 Hi! I'm Laura - your research assistant           ║
║                                                        ║
║  Lovable Artificially-intelligent Unflappable         ║
║  Research Assistant                                    ║
║                                                        ║
╚════════════════════════════════════════════════════════╝

Research vault: My Dissertation Research
Recent activity:
  [WIN] Connected TOD to affordability framework
  [NOTE] Processed 3 sources on density policy

Ready to help with:
  • Research fundamentals of any topic
  • Process papers and sources
  • Build connected knowledge
  • Track your progress

Quick start:
  "Research the fundamentals of [topic]"
  "Process the paper I just added to sources/raw/"
  "Summarize my progress this week"

Let's build some knowledge! 🚀
```

Then Claude Code launches, ready to work!

## Customization

You can edit the laura script to:
- Change the welcome message
- Add vault-specific reminders
- Show different recent activity windows
- Add your own quick-start prompts

The scripts are in the obsidian-research-assistant directory:
- `laura` (bash)
- `laura.ps1` (PowerShell)

## Troubleshooting

**"laura: command not found" (Linux/macOS)**
→ Laura isn't in your PATH. Use full path or add bin directory to PATH.

**"Cannot run scripts" (Windows)**
→ Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

**Shows "not in a research vault"**
→ Make sure you're in a directory with CLAUDE.md and .bloglog/
→ Run `pwd` (Linux/macOS) or `Get-Location` (Windows) to check current directory

**Recent activity doesn't show**
→ BlogLog might not be installed (that's fine, everything else works)
→ Or you haven't logged any activity yet

## Why Laura?

**L**ovable **A**rtificially-intelligent **U**nflappable **R**esearch **A**ssistant

Because research assistants should be:
- 💚 Lovable - Friendly and encouraging
- 🤖 AI-powered - Using Claude Code
- 😌 Unflappable - Always calm and helpful
- 📚 Research-focused - Built for knowledge building

Enjoy working with Laura! 🎉
