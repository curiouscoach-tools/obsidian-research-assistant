# Testing Checklist - Obsidian Research Assistant

## Pre-Testing Setup

### Environment Check
- [ ] Git installed and configured (name, email)
- [ ] Node.js installed
- [ ] BlogLog installed and working (`bl --version`)
- [ ] Obsidian installed
- [ ] Claude Code installed and working

### Repository Setup
- [ ] Clone obsidian-research-assistant repo
- [ ] Make setup-vault.sh executable (`chmod +x setup-vault.sh`)
- [ ] Copy skill to Claude Code: `cp skills/obsidian-research.md ~/.claude/skills/`

## Phase 1: Setup Script Testing

### Create Test Vault
```bash
cd ~/obsidian-research-assistant
./setup-vault.sh ~/vaults/test-agile "Agile Transformation Research"
```

**Verify:**
- [ ] Vault directory created with correct structure
- [ ] All subdirectories present (sources, concepts, themes, questions, _meta, _templates)
- [ ] Templates copied to _templates/
- [ ] .gitignore created
- [ ] README.md created with correct vault name
- [ ] CLAUDE.md created with correct vault name and date
- [ ] research-log.md created
- [ ] domain-context.md created
- [ ] Git repository initialized
- [ ] BlogLog initialized (.bloglog directory exists)
- [ ] Initial commit made (`git log` shows commit)
- [ ] Script outputs helpful next steps

### Git Check
```bash
cd ~/vaults/test-agile
git status  # Should be clean
git log --oneline  # Should show initial commit
```

**Verify:**
- [ ] Git repository is clean
- [ ] Initial commit message is descriptive
- [ ] .gitignore is working (no .obsidian files staged)

### BlogLog Check
```bash
cd ~/vaults/test-agile
bl timeline
```

**Verify:**
- [ ] BlogLog shows initial win entry
- [ ] Timeline displays correctly

## Phase 2: Obsidian Integration

### Open Vault
1. Launch Obsidian
2. File → Open folder as vault
3. Navigate to ~/vaults/test-agile
4. Open

**Verify:**
- [ ] Vault opens successfully
- [ ] Folder structure visible in file explorer
- [ ] Templates visible in _templates folder
- [ ] No errors or warnings

### Configure Obsidian
Settings → Core Plugins → Enable Templates
Settings → Templates → Template folder location: `_templates`

**Verify:**
- [ ] Templates plugin enabled
- [ ] Template folder set correctly
- [ ] Can insert template using command palette

### Test Templates
- [ ] Create new note from source-note template - frontmatter renders correctly
- [ ] Create new note from concept-note template - structure is clear
- [ ] Create new note from question-note template - all sections present
- [ ] Create new note from map-of-content template - MOC structure works

## Phase 3: Claude Code Integration

### Start Claude Code Session
```bash
cd ~/vaults/test-agile
claude-code
```

**Verify:**
- [ ] Claude Code starts successfully
- [ ] Can see current directory is the vault

### Test CLAUDE.md Recognition
Prompt: "What is this vault for?"

**Verify:**
- [ ] Claude Code references CLAUDE.md content
- [ ] Understands this is an Agile Transformation research vault

### Test Research Skill Recognition
Prompt: "What research methodology should you use?"

**Verify:**
- [ ] Claude Code references obsidian-research.md skill
- [ ] Describes scope-first, quality assessment, progressive building approach

## Phase 4: Research Workflow Testing

### Test 1: Initial Topic Research
Prompt: "Research the fundamentals of agile transformation"

**Verify:**
- [ ] Claude Code clarifies scope (asks questions or proceeds with clear assumptions)
- [ ] Creates multiple concept notes (3-5 expected)
- [ ] Creates source notes if appropriate
- [ ] Notes include wikilinks [[like-this]]
- [ ] Notes follow template structure
- [ ] Files created in correct directories
- [ ] BlogLog entries created (`bl timeline` to check)
- [ ] Git commit made (`git log` to check)

**Check Note Quality:**
- [ ] Concept notes have clear definitions
- [ ] Source notes have proper citations (if created)
- [ ] Links are appropriate and not excessive
- [ ] Content is substantive, not just templates
- [ ] Frontmatter is filled in correctly

### Test 2: Question Creation
Prompt: "I'm seeing contradictory claims about whether agile works at scale. Document this as a research question."

**Verify:**
- [ ] Question note created in /questions/
- [ ] Filename is descriptive (kebab-case)
- [ ] Frontmatter filled in (date, status, related concepts)
- [ ] Question clearly stated
- [ ] Context provided
- [ ] Links to related concepts
- [ ] BlogLog entry made

### Test 3: Vault Health Check
Prompt: "Check vault health and identify any issues"

**Verify:**
- [ ] Claude Code checks for orphaned notes
- [ ] Identifies any structural issues
- [ ] Suggests improvements
- [ ] Can fix issues if found

### Test 4: Progress Summary
Prompt: "Summarize my research progress so far"

**Verify:**
- [ ] Reads BlogLog timeline
- [ ] Counts wins, notes, blockers
- [ ] Summarizes activity
- [ ] Identifies focus areas
- [ ] Suggests next steps

## Phase 5: Obsidian Verification

### Back to Obsidian
Refresh file explorer

**Verify:**
- [ ] New notes appear in Obsidian
- [ ] Can click wikilinks to navigate
- [ ] Graph view shows connections (View → Graph view)
- [ ] Notes render correctly with frontmatter

### Test Graph View
- [ ] Concept notes are connected
- [ ] Source notes link to concepts
- [ ] Question notes link to concepts
- [ ] Unconnected notes are visible (if any)

### Test Search
Search for a concept mentioned in notes

**Verify:**
- [ ] Search finds notes mentioning the concept
- [ ] Can navigate to notes from search results

## Phase 6: Git & BlogLog Workflow

### Check Git History
```bash
cd ~/vaults/test-agile
git log --oneline
```

**Verify:**
- [ ] Multiple commits from research session
- [ ] Commit messages are descriptive
- [ ] Changes are properly staged

### Check BlogLog Timeline
```bash
bl timeline
```

**Verify:**
- [ ] Timeline shows research session activity
- [ ] Wins, notes, blockers are categorized correctly
- [ ] Timestamps are accurate

## Phase 7: Brother Validation

Before showing to your brother:

- [ ] Clean up any test artifacts
- [ ] Create a fresh demo vault
- [ ] Run through one complete research cycle
- [ ] Prepare to explain the value proposition

**Demo Script:**
1. "This helps you build systematic knowledge instead of scattered notes"
2. Show vault structure in Obsidian
3. Demonstrate one research request with Claude Code
4. Show the notes created and how they link
5. Show graph view of connections
6. Show BlogLog timeline
7. Ask: "Would this be useful for your work research?"

### Feedback Questions
- What's unclear about the workflow?
- Would you actually use this?
- What's missing?
- What domain would you use it for first?

## Issues Encountered

(Document any problems found during testing)

### Issue 1:
**Problem:**
**Solution:**
**Status:** Fixed / Workaround / Known issue

### Issue 2:
**Problem:**
**Solution:**
**Status:** Fixed / Workaround / Known issue

## Success Criteria

✅ **Minimum viable:**
- Setup script creates working vault
- Claude Code can read CLAUDE.md and skill
- One research workflow completes successfully
- Notes appear in Obsidian with links

✅ **Good enough for brother:**
- All workflows tested and working
- No major bugs
- Value proposition is clear
- Documentation is sufficient

✅ **Ready for Caitlyn:**
- Windows-specific testing complete
- Installation guide is accurate
- Non-technical user can follow steps
- One example vault created as demo
