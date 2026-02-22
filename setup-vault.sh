#!/bin/bash

# Obsidian Research Assistant - Vault Setup Script
# Usage: ./setup-vault.sh <vault-path> [vault-name]

set -e  # Exit on error

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Parse arguments
if [ -z "$1" ]; then
    echo -e "${RED}Error: Vault path required${NC}"
    echo "Usage: ./setup-vault.sh <vault-path> [vault-name] [type]"
    echo "Example: ./setup-vault.sh ~/vaults/my-research"
    echo "Example: ./setup-vault.sh ~/vaults/my-research 'My Research' research"
    echo "Example: ./setup-vault.sh ~/vaults/odie-platform 'ODIE Platform' programme"
    echo ""
    echo "Types:"
    echo "  research  - Research vault (default) - sources, concepts, themes"
    echo "  programme - Programme vault - architecture, product, technical"
    exit 1
fi

VAULT_PATH="$1"
VAULT_NAME="${2:-$(basename "$VAULT_PATH")}"
VAULT_TYPE="${3:-research}"
CURRENT_DATE=$(date +%Y-%m-%d)

echo -e "${GREEN}Creating research vault: ${VAULT_NAME}${NC}"
echo "Location: $VAULT_PATH"
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    echo "Please install git first"
    exit 1
fi

# Create vault directory structure
echo "Creating vault structure..."
if [ "$VAULT_TYPE" = "programme" ]; then
    echo "Creating programme vault structure..."
    mkdir -p "$VAULT_PATH"/{architecture/{decisions,comparisons,designs,diagrams,risks},product/{user-stories,value-hypotheses,roadmap},requirements/{functional,non-functional,stakeholders},technical/{spikes,implementation,risks},process/{sprint-plans,retrospectives,blockers},research/{sources/raw,concepts,themes},discussions,_meta,_templates}
else
    echo "Creating research vault structure..."
    mkdir -p "$VAULT_PATH"/{sources/raw,concepts,themes,questions,_meta,_templates}
fi

# Copy templates
echo "Installing templates..."
cp -r "$SCRIPT_DIR/templates/"* "$VAULT_PATH/_templates/"

# Install Claude Code skills (personas)
echo "Installing personas (Laura, Alex, Riley)..."
mkdir -p "$VAULT_PATH/.claude/skills"
cp -r "$SCRIPT_DIR/vault-skills/"* "$VAULT_PATH/.claude/skills/"

# Create .gitignore
echo "Creating .gitignore..."
cp "$SCRIPT_DIR/config/gitignore.template" "$VAULT_PATH/.gitignore"

# Create README
echo "Creating README..."
sed "s/{{vault_name}}/$VAULT_NAME/g" "$SCRIPT_DIR/config/vault-readme.template" > "$VAULT_PATH/README.md"

# Create vault-specific CLAUDE.md
echo "Creating CLAUDE.md..."
sed -e "s/{{vault_name}}/$VAULT_NAME/g" -e "s/{{date}}/$CURRENT_DATE/g" \
    "$SCRIPT_DIR/config/vault-claude.template" > "$VAULT_PATH/CLAUDE.md"

# Create research log
echo "Creating research log..."
cat > "$VAULT_PATH/_meta/research-log.md" << EOF
# Research Log - $VAULT_NAME

## Overview
This log tracks the evolution of research in this vault.

## Timeline

### $CURRENT_DATE - Vault Created
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
EOF

# Create research backlog
echo "Creating research backlog..."
cat > "$VAULT_PATH/_meta/research-backlog.md" << EOF
# Research Backlog - $VAULT_NAME

## High Priority
- [ ] Define initial research questions
- [ ] Identify key sources to find

## Medium Priority
[Add items as research progresses]

## Low Priority / Later
[Add items as research progresses]

## Completed
- [x] Set up vault structure
EOF

# Create domain context
echo "Creating domain context..."
cat > "$VAULT_PATH/_meta/domain-context.md" << EOF
# Domain Context - $VAULT_NAME

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
EOF

# Initialize git
echo "Initializing git repository..."
cd "$VAULT_PATH"
git init

# Configure git if needed
if [ -z "$(git config user.name)" ]; then
    echo -e "${YELLOW}Git user name not configured${NC}"
    read -p "Enter your name for git commits: " GIT_NAME
    git config user.name "$GIT_NAME"
fi

if [ -z "$(git config user.email)" ]; then
    echo -e "${YELLOW}Git user email not configured${NC}"
    read -p "Enter your email for git commits: " GIT_EMAIL
    git config user.email "$GIT_EMAIL"
fi

# Initial git commit
echo "Creating initial commit..."
git add .
git commit -m "Initial vault setup for $VAULT_NAME

- Created directory structure
- Installed note templates
- Installed personas (Laura, Alex)
- Initialized research log and domain context
- Ready for research with /laura or /alex"

echo ""
echo -e "${GREEN}✓ Vault created successfully!${NC}"
echo ""
echo "Location: $VAULT_PATH"
echo ""
echo "Next steps:"
echo "1. Open vault in Obsidian: File → Open folder as vault → $VAULT_PATH"
echo "2. Edit CLAUDE.md to describe your research focus"
echo "3. Run 'claude' in the vault directory"
echo "4. Type '/laura' for research, '/alex' for architecture, '/riley' for product"
echo ""
echo "Optional:"
echo "- Connect to GitHub for backup:"
echo "  cd $VAULT_PATH"
echo "  git remote add origin <your-github-repo-url>"
echo "  git push -u origin main"
echo ""
