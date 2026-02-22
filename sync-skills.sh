#!/bin/bash

# sync-skills.sh - Sync persona skills to existing vaults
# Usage: ./sync-skills.sh [vaults-directory]
#
# Finds all vaults in the specified directory and syncs skills from this repo.
# Shows diffs and asks for confirmation before updating.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script lives (the repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE="$SCRIPT_DIR/vault-skills"

# Default vaults directory
VAULTS_DIR="${1:-$HOME/vibe/vaults}"

# Personas to sync (base names - laura variants handled specially)
PERSONAS=("laura" "alex" "riley" "casey")

echo -e "${BLUE}=== Skill Sync Tool ===${NC}"
echo "Source: $SKILLS_SOURCE"
echo "Vaults: $VAULTS_DIR"
echo ""

# Check source exists
if [ ! -d "$SKILLS_SOURCE" ]; then
    echo -e "${RED}Error: Skills source not found at $SKILLS_SOURCE${NC}"
    exit 1
fi

# Check vaults directory exists
if [ ! -d "$VAULTS_DIR" ]; then
    echo -e "${RED}Error: Vaults directory not found at $VAULTS_DIR${NC}"
    exit 1
fi

# Find all vaults (directories containing .claude/skills/)
VAULTS=()
while IFS= read -r -d '' vault; do
    VAULTS+=("$(dirname "$(dirname "$vault")")")
done < <(find "$VAULTS_DIR" -type d -name "skills" -path "*/.claude/*" -print0 2>/dev/null)

if [ ${#VAULTS[@]} -eq 0 ]; then
    echo -e "${YELLOW}No vaults found in $VAULTS_DIR${NC}"
    echo "Looking for directories containing .claude/skills/"
    exit 0
fi

echo -e "Found ${GREEN}${#VAULTS[@]}${NC} vault(s):"
for vault in "${VAULTS[@]}"; do
    echo "  - $(basename "$vault")"
done
echo ""

# Track statistics
UPDATED=0
SKIPPED=0
CREATED=0
UNCHANGED=0

# Process each vault
for vault in "${VAULTS[@]}"; do
    vault_name=$(basename "$vault")
    echo -e "${BLUE}--- $vault_name ---${NC}"

    for persona in "${PERSONAS[@]}"; do
        # Handle laura variants
        if [ "$persona" = "laura" ]; then
            target_dir="$vault/.claude/skills/laura"
            target_file="$target_dir/SKILL.md"

            # Detect which variant is installed by checking content
            if [ -f "$target_file" ]; then
                if grep -q "Emergency Check Before Submission" "$target_file" 2>/dev/null; then
                    source_file="$SKILLS_SOURCE/laura-academic/SKILL.md"
                    variant="academic"
                elif grep -q "Academic" "$target_file" 2>/dev/null; then
                    source_file="$SKILLS_SOURCE/laura-academic/SKILL.md"
                    variant="academic"
                else
                    source_file="$SKILLS_SOURCE/laura-professional/SKILL.md"
                    variant="professional"
                fi
            else
                # Default to professional for new installs
                source_file="$SKILLS_SOURCE/laura-professional/SKILL.md"
                variant="professional"
            fi

            # Fallback to original if variants don't exist
            if [ ! -f "$source_file" ]; then
                source_file="$SKILLS_SOURCE/laura/SKILL.md"
                variant="original"
            fi
        else
            source_file="$SKILLS_SOURCE/$persona/SKILL.md"
            target_dir="$vault/.claude/skills/$persona"
            target_file="$target_dir/SKILL.md"
            variant=""
        fi

        # Check if source exists
        if [ ! -f "$source_file" ]; then
            continue
        fi

        # Display name with variant if applicable
        if [ -n "$variant" ]; then
            display_name="$persona ($variant)"
        else
            display_name="$persona"
        fi

        # If target doesn't exist, offer to create
        if [ ! -f "$target_file" ]; then
            echo -e "  ${YELLOW}$display_name:${NC} Not installed"
            read -p "    Install $display_name? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                mkdir -p "$target_dir"
                cp "$source_file" "$target_file"
                echo -e "    ${GREEN}Installed${NC}"
                ((CREATED++))
            else
                ((SKIPPED++))
            fi
            continue
        fi

        # Compare files
        if diff -q "$source_file" "$target_file" > /dev/null 2>&1; then
            echo -e "  ${GREEN}$display_name:${NC} Up to date"
            ((UNCHANGED++))
            continue
        fi

        # Files differ - show diff and ask
        echo -e "  ${YELLOW}$display_name:${NC} Changes available"
        echo ""
        echo -e "    ${BLUE}Diff (repo → vault):${NC}"
        # Show abbreviated diff
        diff_output=$(diff -u "$target_file" "$source_file" 2>/dev/null | head -50)
        echo "$diff_output" | sed 's/^/    /'

        lines_changed=$(diff "$target_file" "$source_file" 2>/dev/null | wc -l)
        if [ "$lines_changed" -gt 50 ]; then
            echo -e "    ${YELLOW}... (diff truncated, $lines_changed total lines changed)${NC}"
        fi
        echo ""

        # Ask what to do
        echo "    Options:"
        echo "      [u] Update (overwrite vault version with repo version)"
        echo "      [b] Backup & update (save old version as SKILL.md.bak)"
        echo "      [v] View full diff"
        echo "      [s] Skip"
        read -p "    Choice [u/b/v/s]: " -n 1 -r
        echo

        case $REPLY in
            [Uu])
                cp "$source_file" "$target_file"
                echo -e "    ${GREEN}Updated${NC}"
                ((UPDATED++))
                ;;
            [Bb])
                cp "$target_file" "$target_file.bak"
                cp "$source_file" "$target_file"
                echo -e "    ${GREEN}Backed up and updated${NC}"
                ((UPDATED++))
                ;;
            [Vv])
                echo ""
                diff -u "$target_file" "$source_file" | less
                # Re-ask after viewing
                read -p "    Update? [y/N] " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    cp "$source_file" "$target_file"
                    echo -e "    ${GREEN}Updated${NC}"
                    ((UPDATED++))
                else
                    echo -e "    ${YELLOW}Skipped${NC}"
                    ((SKIPPED++))
                fi
                ;;
            *)
                echo -e "    ${YELLOW}Skipped${NC}"
                ((SKIPPED++))
                ;;
        esac
    done
    echo ""
done

# Summary
echo -e "${BLUE}=== Summary ===${NC}"
echo -e "  Updated:   ${GREEN}$UPDATED${NC}"
echo -e "  Created:   ${GREEN}$CREATED${NC}"
echo -e "  Unchanged: $UNCHANGED"
echo -e "  Skipped:   ${YELLOW}$SKIPPED${NC}"
