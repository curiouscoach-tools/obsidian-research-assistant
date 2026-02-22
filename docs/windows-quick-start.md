# Quick Start - Windows Users

This guide is specifically for Windows users setting up the Obsidian Research Assistant.

## Prerequisites

Before starting, install:
1. **Git for Windows** - https://git-scm.com/download/win
2. **Obsidian** - https://obsidian.md/
3. **Claude Code** - https://claude.ai/code

## Setup Research Assistant

### 1. Extract the Package

1. Download `obsidian-research-assistant.tar.gz`
2. Extract using:
   - Windows 11: Right-click → Extract All
   - 7-Zip: Right-click → 7-Zip → Extract Here
   - WinRAR: Right-click → Extract Here

3. Open PowerShell in the extracted folder:
   - Shift + Right-click in folder → "Open PowerShell window here"
   - Or: File → Open Windows PowerShell

### 2. Install the Research Skill

In PowerShell:

```powershell
# Create skills directory
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\obsidian-research"

# Copy skill file
Copy-Item -Path "skills\obsidian-research\SKILL.md" -Destination "$env:USERPROFILE\.claude\skills\obsidian-research\" -Force
```

Verify:
```powershell
Test-Path "$env:USERPROFILE\.claude\skills\obsidian-research\SKILL.md"
# Should return: True
```

### 3. Create Your First Vault

Still in PowerShell, in the obsidian-research-assistant directory:

```powershell
# Create vault in your Documents folder
.\setup-vault.ps1 -VaultPath "$env:USERPROFILE\Documents\vaults\my-research" -VaultName "My Research Project"
```

**What this does:**
- Creates folder structure in Documents\vaults\my-research
- Installs templates
- Initializes git repository
- Creates progress tracking files
- Creates initial files

**Common issues:**

If you see "cannot be loaded because running scripts is disabled":
```powershell
# Run this ONCE to allow scripts:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then try the setup command again.

### 4. Open in Obsidian

1. Launch Obsidian
2. Click "Open folder as vault"
3. Navigate to: `C:\Users\YourName\Documents\vaults\my-research`
4. Click "Select Folder"

**First time setup:**
- Settings → Core Plugins → Enable "Templates"
- Settings → Templates → Template folder location: `_templates`

### 5. Test Templates

1. In Obsidian, create a new note
2. Press `Ctrl+P` (Command Palette)
3. Type "Insert template"
4. Select a template (e.g., concept-note)
5. Template should insert successfully

### 6. Start Claude Code

Open PowerShell (or Command Prompt) in your vault:

```powershell
cd $env:USERPROFILE\Documents\vaults\my-research
claude-code
```

**First prompt:**
```
I'm researching [your topic] for my [dissertation/project].

My main questions are:
- [Question 1]
- [Question 2]

Please read CLAUDE.md and help me start building systematic knowledge.
```

## Common Windows Issues

### PowerShell Scripts Won't Run

**Error:** "cannot be loaded because running scripts is disabled"

**Fix:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Git Not Found

**Error:** "git is not recognized"

**Fix:** 
1. Install Git for Windows from https://git-scm.com/download/win
2. Restart PowerShell after installation

### Path with Spaces

If your vault path has spaces, use quotes:

```powershell
.\setup-vault.ps1 -VaultPath "$env:USERPROFILE\My Documents\vaults\my research" -VaultName "My Research"
```

### File Paths in Claude Code

Windows uses backslashes (`\`) but Claude Code often shows forward slashes (`/`). Both work - don't worry about it.

### Can't Find Vault Directory

Your vault is at: `C:\Users\YourName\Documents\vaults\my-research`

To open in File Explorer:
```powershell
explorer $env:USERPROFILE\Documents\vaults\my-research
```

## Daily Workflow (Windows)

### Starting a Research Session

```powershell
# Navigate to vault
cd $env:USERPROFILE\Documents\vaults\my-research

# Start Claude Code
claude-code
```

Then use prompts from docs/quick-start-prompts.md

### Checking Progress

```powershell
# View research log
Get-Content _meta\research-log.md

# View research backlog
Get-Content _meta\research-backlog.md

# View git history
git log --oneline
```

### Syncing to GitHub (Optional)

First time setup:
```powershell
cd $env:USERPROFILE\Documents\vaults\my-research

# Add remote (create repo on GitHub first)
git remote add origin https://github.com/yourusername/my-research.git

# Push
git push -u origin main
```

Later:
```powershell
git push
```

## Paths Quick Reference

| What | Windows Path |
|------|--------------|
| Research Assistant | `C:\Users\YourName\projects\obsidian-research-assistant` |
| Skill File | `C:\Users\YourName\.claude\skills\obsidian-research\SKILL.md` |
| Your Vaults | `C:\Users\YourName\Documents\vaults\` |

## PowerShell vs Command Prompt

Both work, but PowerShell is recommended because:
- Better tab completion
- Easier path handling
- Works with `$env:USERPROFILE` variable

To open PowerShell:
- Press `Win+X` → "Windows PowerShell"
- Or search "PowerShell" in Start menu

## Next Steps

1. ✅ Vault created and opened in Obsidian
2. ✅ Templates working
3. ✅ Claude Code connects successfully
4. ✅ First research session complete

Now check out:
- [Quick Start Prompts](quick-start-prompts.md) - Copy-paste prompts to use
- [Installation Guide](installation.md) - Full installation details
- [Testing Checklist](testing-checklist.md) - Verify everything works

## Getting Help

If you're stuck:
1. Check this guide's "Common Windows Issues" section
2. Check the main [Installation Guide](installation.md)
3. Verify prerequisites are installed correctly
4. Make sure you're in the right directory (`pwd` shows current directory)

Good luck with your research!
