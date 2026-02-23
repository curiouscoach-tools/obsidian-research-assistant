#!/bin/bash

# Obsidian Vault Setup Script
# Usage: ./setup-vault.sh <vault-path> <type> [vault-name]

set -e  # Exit on error

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Show usage
show_usage() {
    echo "Usage: ./setup-vault.sh <vault-path> <type> [vault-name]"
    echo ""
    echo "Examples:"
    echo "  ./setup-vault.sh ~/vaults/dissertation academic 'PhD Research'"
    echo "  ./setup-vault.sh ~/vaults/work-notes knowledge 'Work Notes'"
    echo "  ./setup-vault.sh ~/vaults/daily journal 'Work Journal'"
    echo ""
    echo "Types (required):"
    echo "  academic  - Formal research with strict verification (dissertations, papers)"
    echo "  knowledge - Professional research with lighter overhead (work, learning, PKM)"
    echo "  journal   - Time-based reflection and journaling"
    echo ""
    echo "Included skill by type:"
    echo "  academic:  laura-academic + skills-manager"
    echo "  knowledge: laura-professional + skills-manager"
    echo "  journal:   casey + skills-manager"
    echo ""
    echo "Use /skills add <name> in your vault to add more skills later."
}

# Check vault path
if [ -z "$1" ]; then
    echo -e "${RED}Error: Vault path required${NC}"
    echo ""
    show_usage
    exit 1
fi

# Check type
if [ -z "$2" ]; then
    echo -e "${RED}Error: Vault type required${NC}"
    echo ""
    echo "You must specify a type: academic, knowledge, or journal"
    echo ""
    show_usage
    exit 1
fi

VAULT_PATH="$1"
VAULT_TYPE="$2"
VAULT_NAME="${3:-$(basename "$VAULT_PATH")}"
CURRENT_DATE=$(date +%Y-%m-%d)

# Validate type and set default skill
case "$VAULT_TYPE" in
    academic)
        DEFAULT_SKILL="laura"
        SKILL_VARIANT="laura-academic"
        ;;
    knowledge)
        DEFAULT_SKILL="laura"
        SKILL_VARIANT="laura-professional"
        ;;
    journal)
        DEFAULT_SKILL="casey"
        SKILL_VARIANT="casey"
        ;;
    *)
        echo -e "${RED}Error: Invalid type '$VAULT_TYPE'${NC}"
        echo ""
        echo "Valid types: academic, knowledge, journal"
        echo ""
        show_usage
        exit 1
        ;;
esac

echo -e "${GREEN}Creating $VAULT_TYPE vault: ${VAULT_NAME}${NC}"
echo "Location: $VAULT_PATH"
echo "Skills: $SKILL_VARIANT + skills-manager"
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    echo "Please install git first"
    exit 1
fi

# Create vault directory structure based on type
echo "Creating vault structure..."
case "$VAULT_TYPE" in
    academic|knowledge)
        mkdir -p "$VAULT_PATH"/{sources/raw,concepts,context,themes,questions,_meta,_templates}
        ;;
    journal)
        mkdir -p "$VAULT_PATH"/{journal/{daily,weekly,monthly,quarterly},themes,_meta,_templates}
        ;;
esac

# Copy templates based on vault type
echo "Installing templates..."
if [ "$VAULT_TYPE" = "journal" ]; then
    cp "$SCRIPT_DIR/templates/daily-reflection.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/weekly-review.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/monthly-review.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/quarterly-review.md" "$VAULT_PATH/_templates/"
else
    cp "$SCRIPT_DIR/templates/source-note.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/concept-note.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/context-note.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/question-note.md" "$VAULT_PATH/_templates/"
    cp "$SCRIPT_DIR/templates/map-of-content.md" "$VAULT_PATH/_templates/"
fi

# Install skills
echo "Installing skills..."
mkdir -p "$VAULT_PATH/.claude/skills"

# Always install the skills manager
echo "  - skills (manager)"
mkdir -p "$VAULT_PATH/.claude/skills/skills"
cp "$SCRIPT_DIR/skills/skills-manager.md" "$VAULT_PATH/.claude/skills/skills/SKILL.md"

# Install default skill for this vault type
echo "  - $SKILL_VARIANT"
mkdir -p "$VAULT_PATH/.claude/skills/$DEFAULT_SKILL"
cp "$SCRIPT_DIR/skills/$SKILL_VARIANT.md" "$VAULT_PATH/.claude/skills/$DEFAULT_SKILL/SKILL.md"

# Create .gitignore
echo "Creating .gitignore..."
cp "$SCRIPT_DIR/config/gitignore.template" "$VAULT_PATH/.gitignore"

# Create README based on vault type
echo "Creating README..."
if [ "$VAULT_TYPE" = "journal" ]; then
    cat > "$VAULT_PATH/README.md" << EOF
# $VAULT_NAME

## Purpose
[Describe what this reflection vault is for - work journal, personal growth, learning log, etc.]

## Structure

\`\`\`
├── journal/
│   ├── daily/      Daily reflections
│   ├── weekly/     Weekly reviews
│   ├── monthly/    Monthly reviews
│   └── quarterly/  Quarterly reviews
├── themes/         Recurring patterns and growth areas
├── _meta/          Tracking files
└── _templates/     Note templates
\`\`\`

## How to Use

### Daily Reflection
- End of day: Capture what happened, what you learned, what's tomorrow
- Use template from \`_templates/daily-reflection.md\`

### Reviews
- Weekly: Synthesise the week, spot patterns, set intentions
- Monthly: Check against goals, track growth trajectory
- Quarterly: Big picture review, set new goals

### Tracking Progress
- Session summaries go in \`_meta/reflection-log.md\`
- Things to explore go in \`_meta/reflection-backlog.md\`
- Growth objectives in \`_meta/growth-goals.md\`

## Working with Casey

Signal when you're done reflecting:
- "That's my reflection for today"
- "Let's wrap up"
- "Save and commit"

Casey will summarise, update tracking files, and commit changes.
EOF
else
    sed "s/{{vault_name}}/$VAULT_NAME/g" "$SCRIPT_DIR/config/vault-readme.template" > "$VAULT_PATH/README.md"
fi

# Create vault-specific CLAUDE.md based on type
echo "Creating CLAUDE.md..."
if [ "$VAULT_TYPE" = "journal" ]; then
    cat > "$VAULT_PATH/CLAUDE.md" << EOF
# $VAULT_NAME - Reflection Context

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

## Skill Management
skill-source: $SCRIPT_DIR
EOF
else
    sed -e "s/{{vault_name}}/$VAULT_NAME/g" -e "s/{{date}}/$CURRENT_DATE/g" \
        "$SCRIPT_DIR/config/vault-claude.template" > "$VAULT_PATH/CLAUDE.md"

    # Add skill source path
    echo "" >> "$VAULT_PATH/CLAUDE.md"
    echo "## Skill Management" >> "$VAULT_PATH/CLAUDE.md"
    echo "skill-source: $SCRIPT_DIR" >> "$VAULT_PATH/CLAUDE.md"
fi

# Create meta files based on vault type
if [ "$VAULT_TYPE" = "journal" ]; then
    # Create reflection log
    echo "Creating reflection log..."
    cat > "$VAULT_PATH/_meta/reflection-log.md" << EOF
# Reflection Log - $VAULT_NAME

## Overview
Casey's observations and session summaries.

## Timeline

### $CURRENT_DATE - Vault Created
- Initial reflection vault created
- Templates installed
- Ready to begin journaling

---

## Patterns Noticed
[Casey will add observations here over time]

## Growth Markers
[Significant progress points]
EOF

    # Create reflection backlog
    echo "Creating reflection backlog..."
    cat > "$VAULT_PATH/_meta/reflection-backlog.md" << EOF
# Reflection Backlog - $VAULT_NAME

## To Explore
- [ ] Set up daily reflection habit
- [ ] Define growth goals

## To Develop
[Skills or areas to work on]

## To Revisit
[Past reflections or decisions to check on]

## Completed
- [x] Set up vault structure
EOF

    # Create growth goals
    echo "Creating growth goals..."
    cat > "$VAULT_PATH/_meta/growth-goals.md" << EOF
# Growth Goals - $VAULT_NAME

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
EOF

else
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
fi

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

- Created $VAULT_TYPE vault structure
- Installed templates
- Installed skills: $SKILL_VARIANT, skills-manager
- Ready to use"

echo ""
echo -e "${GREEN}✓ Vault created successfully!${NC}"
echo ""
echo "Location: $VAULT_PATH"
echo "Type: $VAULT_TYPE"
echo "Skills: $SKILL_VARIANT + skills-manager"
echo ""
echo "Next steps:"
echo "1. Open vault in Obsidian: File → Open folder as vault → $VAULT_PATH"
echo "2. Edit CLAUDE.md to customize your setup"
echo "3. Run 'claude' in the vault directory"
echo "4. Type '/$DEFAULT_SKILL' to get started"
echo "5. Use '/skills' to list or add more skills"
echo ""
echo "Optional:"
echo "- Connect to GitHub for backup:"
echo "  cd $VAULT_PATH"
echo "  git remote add origin <your-github-repo-url>"
echo "  git push -u origin main"
echo ""
