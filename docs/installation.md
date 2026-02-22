# Installation Guide - Obsidian Research Assistant

This guide walks you through setting up the Obsidian Research Assistant on your computer.

## Prerequisites

You'll need to install several tools. Follow the sections below based on your operating system.

### For Windows Users

#### 1. Install Git for Windows
1. Download from: https://git-scm.com/download/win
2. Run the installer
3. Use default settings (Git Bash is included)
4. Verify installation: Open "Git Bash" and type `git --version`

#### 2. Install Obsidian
1. Download from: https://obsidian.md/
2. Run the installer
3. Launch Obsidian (you'll configure vaults later)

#### 3. Install Claude Code
1. Download from: https://claude.ai/code
2. Follow installation instructions
3. Verify: Open Command Prompt and type `claude-code --version`

### For macOS Users

#### 1. Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. Install Git
```bash
brew install git
```

Verify: `git --version`

#### 3. Install Obsidian
1. Download from: https://obsidian.md/
2. Drag to Applications folder
3. Launch Obsidian

#### 4. Install Claude Code
1. Download from: https://claude.ai/code
2. Follow installation instructions
3. Verify: `claude-code --version`

### For Linux Users

#### 1. Install Git
```bash
sudo apt update  # Debian/Ubuntu
sudo apt install git

# OR for other distros:
sudo dnf install git  # Fedora
sudo pacman -S git    # Arch
```

Verify: `git --version`

#### 2. Install Obsidian
Download AppImage from: https://obsidian.md/
```bash
chmod +x Obsidian-*.AppImage
./Obsidian-*.AppImage
```

#### 3. Install Claude Code
1. Download from: https://claude.ai/code
2. Follow installation instructions
3. Verify: `claude-code --version`

## Setup Obsidian Research Assistant

Once all prerequisites are installed:

### 1. Clone the Research Assistant Repository

```bash
# Choose where to put the tool (e.g., your projects folder)
cd ~/projects  # or wherever you keep code

git clone https://github.com/curiouscoach-tools/obsidian-research-assistant.git
cd obsidian-research-assistant
```

### 2. Create Your First Research Vault

**Linux/macOS:**
```bash
# From within the obsidian-research-assistant directory
./setup-vault.sh ~/vaults/my-first-research "My Research Project"
```

**Windows (PowerShell):**
```powershell
# From within the obsidian-research-assistant directory
.\setup-vault.ps1 -VaultPath "$env:USERPROFILE\vaults\my-first-research" -VaultName "My Research Project"
```

The script will:
- Create the vault structure
- Install templates
- Install personas (Laura, Alex, Riley) as Claude Code skills
- Initialize git
- Create initial files including research log and backlog

### 3. Open Vault in Obsidian

1. Launch Obsidian
2. Click "Open folder as vault"
3. Navigate to your vault:
   - Linux/macOS: `~/vaults/my-first-research`
   - Windows: `C:\Users\YourName\vaults\my-first-research`
4. Click "Open"

### 4. Configure Obsidian (First Time Only)

#### Enable Templates Plugin
1. Settings → Core Plugins → Enable "Templates"
2. Settings → Templates → Template folder location: `_templates`

#### Recommended Settings
- Settings → Files and Links → "Automatically update internal links": ON
- Settings → Editor → "Default editing mode": Source mode (or Live Preview)

### 5. Start Using Claude Code

**Linux/macOS:**
```bash
cd ~/vaults/my-first-research
claude
```

Then type `/laura` to activate Laura.

**Windows (PowerShell or Command Prompt):**
```powershell
cd $env:USERPROFILE\vaults\my-first-research
claude
```

Then prompt Claude Code:
```
"Research the fundamentals of [your topic]"
```

Claude Code will:
- Read CLAUDE.md for project context
- Use the research methodology skill
- Create structured notes in your vault
- Update research log and backlog
- Commit changes to git

## Troubleshooting

### Git asks for username/email
Configure git:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Claude Code doesn't see the personas
Make sure the skills are in your vault:
```bash
ls your-vault/.claude/skills/laura/SKILL.md
ls your-vault/.claude/skills/alex/SKILL.md
```

If not found, re-run setup or manually copy:
```bash
cp -r path/to/obsidian-research-assistant/vault-skills/* your-vault/.claude/skills/
```

### Obsidian can't find templates
Check Settings → Templates → Template folder location is set to `_templates`

## Next Steps

1. Edit `CLAUDE.md` in your vault to describe your research focus
2. Start a research session with Claude Code
3. Review the notes created in Obsidian
4. Check the graph view to see connections emerging
5. Check `_meta/research-log.md` to track your progress

## Getting Help

- [Obsidian Documentation](https://help.obsidian.md/)
- [Claude Code Documentation](https://claude.ai/code/docs)

## Optional: Connect Vault to GitHub

To backup your research vault to GitHub:

```bash
cd ~/vaults/my-first-research

# Create a new repository on GitHub first, then:
git remote add origin https://github.com/yourusername/my-research.git
git push -u origin main
```

Each research vault can have its own GitHub repository for backup and version history.
