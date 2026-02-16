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

#### 2. Install Node.js (for BlogLog)
1. Download from: https://nodejs.org/ (LTS version recommended)
2. Run the installer with default settings
3. Verify: Open Command Prompt and type `node --version`

#### 3. Install Obsidian
1. Download from: https://obsidian.md/
2. Run the installer
3. Launch Obsidian (you'll configure vaults later)

#### 4. Install Claude Code
1. Download from: https://claude.ai/code
2. Follow installation instructions
3. Verify: Open Command Prompt and type `claude-code --version`

#### 5. Install BlogLog
Open Git Bash or Command Prompt:
```bash
git clone https://github.com/IanSimon23/bloglog.git
cd bloglog
npm install
cd packages/cli && npm link
```

Verify: `bl --version`

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

#### 3. Install Node.js
```bash
brew install node
```

Verify: `node --version`

#### 4. Install Obsidian
1. Download from: https://obsidian.md/
2. Drag to Applications folder
3. Launch Obsidian

#### 5. Install Claude Code
1. Download from: https://claude.ai/code
2. Follow installation instructions
3. Verify: `claude-code --version`

#### 6. Install BlogLog
```bash
git clone https://github.com/IanSimon23/bloglog.git
cd bloglog
npm install
cd packages/cli && npm link
```

Verify: `bl --version`

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

#### 2. Install Node.js
```bash
sudo apt install nodejs npm  # Debian/Ubuntu

# OR use Node Version Manager (recommended):
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
```

Verify: `node --version`

#### 3. Install Obsidian
Download AppImage from: https://obsidian.md/
```bash
chmod +x Obsidian-*.AppImage
./Obsidian-*.AppImage
```

#### 4. Install Claude Code
1. Download from: https://claude.ai/code
2. Follow installation instructions
3. Verify: `claude-code --version`

#### 5. Install BlogLog
```bash
git clone https://github.com/IanSimon23/bloglog.git
cd bloglog
npm install
cd packages/cli && npm link
```

Verify: `bl --version`

## Setup Obsidian Research Assistant

Once all prerequisites are installed:

### 1. Clone the Research Assistant Repository

```bash
# Choose where to put the tool (e.g., your projects folder)
cd ~/projects  # or wherever you keep code

git clone https://github.com/yourusername/obsidian-research-assistant.git
cd obsidian-research-assistant
```

### 2. Install the Research Skill for Claude Code

This makes the research methodology available to Claude Code globally:

**Linux/macOS:**
```bash
# Create Claude Code skills directory if it doesn't exist
mkdir -p ~/.claude/skills/obsidian-research

# Copy the skill file
cp skills/obsidian-research/SKILL.md ~/.claude/skills/obsidian-research/
```

**Windows (PowerShell):**
```powershell
# Create Claude Code skills directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\obsidian-research"

# Copy the skill file
Copy-Item -Path "skills\obsidian-research\SKILL.md" -Destination "$env:USERPROFILE\.claude\skills\obsidian-research\" -Force
```

### 3. Create Your First Research Vault

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
# - Initialize git
# - Initialize BlogLog
# - Create initial files
```

### 4. Open Vault in Obsidian

1. Launch Obsidian
2. Click "Open folder as vault"
3. Navigate to your vault:
   - Linux/macOS: `~/vaults/my-first-research`
   - Windows: `C:\Users\YourName\vaults\my-first-research`
4. Click "Open"

### 5. Configure Obsidian (First Time Only)

#### Enable Templates Plugin
1. Settings → Core Plugins → Enable "Templates"
2. Settings → Templates → Template folder location: `_templates`

#### Recommended Settings
- Settings → Files and Links → "Automatically update internal links": ON
- Settings → Editor → "Default editing mode": Source mode (or Live Preview)

### 6. Start Using Claude Code

**Linux/macOS:**
```bash
cd ~/vaults/my-first-research
claude-code
```

**Windows (PowerShell or Command Prompt):**
```powershell
cd $env:USERPROFILE\vaults\my-first-research
claude-code
```

Then prompt Claude Code:
```
"Research the fundamentals of [your topic]"
```

Claude Code will:
- Read CLAUDE.md for project context
- Use the research methodology skill
- Create structured notes in your vault
- Log progress to BlogLog
- Commit changes to git

## Troubleshooting

### "bl: command not found"
BlogLog didn't install correctly. Try:
```bash
cd ~/bloglog
cd packages/cli && npm link
```

### Git asks for username/email
Configure git:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Claude Code doesn't see the skill
Make sure the skill file is in the right place:
```bash
ls ~/.claude/skills/obsidian-research.md
```

If not found, re-copy:
```bash
cp skills/obsidian-research.md ~/.claude/skills/
```

### Obsidian can't find templates
Check Settings → Templates → Template folder location is set to `_templates`

## Next Steps

1. Edit `CLAUDE.md` in your vault to describe your research focus
2. Start a research session with Claude Code
3. Review the notes created in Obsidian
4. Check the graph view to see connections emerging
5. Use `bl timeline` to track your progress

## Getting Help

- [Obsidian Documentation](https://help.obsidian.md/)
- [Claude Code Documentation](https://claude.ai/code/docs)
- [BlogLog Repository](https://github.com/IanSimon23/bloglog)

## Optional: Connect Vault to GitHub

To backup your research vault to GitHub:

```bash
cd ~/vaults/my-first-research

# Create a new repository on GitHub first, then:
git remote add origin https://github.com/yourusername/my-research.git
git push -u origin main
```

Each research vault can have its own GitHub repository for backup and version history.
