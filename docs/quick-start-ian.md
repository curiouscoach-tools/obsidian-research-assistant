# Quick Start - Tomorrow's Testing

## Your Goal
By end of day: Working prototype validated on your laptop, ready to show your brother.

## Morning Setup (15 minutes)

### 1. Get the Files
The obsidian-research-assistant directory is ready with everything you need.

### 2. Install the Skill
```bash
mkdir -p ~/.claude/skills
cp skills/obsidian-research.md ~/.claude/skills/
```

### 3. Test Prerequisites
```bash
git --version          # Should work
node --version         # Should work
bl --version          # Should work
obsidian --version    # Launch Obsidian to verify
claude-code --version # Should work
```

If BlogLog isn't installed:
```bash
git clone https://github.com/IanSimon23/bloglog.git ~/bloglog
cd ~/bloglog
npm install
cd packages/cli && npm link
```

## First Test Vault (30 minutes)

### Create Vault
```bash
cd ~/obsidian-research-assistant
./setup-vault.sh ~/vaults/test-agile "Agile Transformation Research"
```

**Expected output:**
- Green success messages
- Vault created at ~/vaults/test-agile
- Next steps displayed

**If it fails:**
- Check error message
- Verify git is configured (name/email)
- Check script permissions (`chmod +x setup-vault.sh`)

### Verify Structure
```bash
cd ~/vaults/test-agile
ls -la
```

Should see:
- sources/, concepts/, themes/, questions/, _meta/, _templates/
- .bloglog/, .git/
- CLAUDE.md, README.md, .gitignore

### Check Git
```bash
git log --oneline
```

Should show initial commit.

### Check BlogLog
```bash
bl timeline
```

Should show initial win entry.

## Open in Obsidian (10 minutes)

1. Launch Obsidian
2. File → Open folder as vault
3. Navigate to ~/vaults/test-agile
4. Open

**Configure (first time only):**
- Settings → Core Plugins → Enable "Templates"
- Settings → Templates → Template folder: `_templates`

**Test:**
- Can you see the folder structure?
- Do templates show in _templates/?
- Can you create a note from template?

## First Research Session (1 hour)

This is the critical test.

### Start Claude Code
```bash
cd ~/vaults/test-agile
claude-code
```

### Test CLAUDE.md Recognition
```
You: "What is this vault for?"
```

Claude Code should reference the CLAUDE.md content.

### Test Research Skill
```
You: "What research methodology should you follow?"
```

Claude Code should reference obsidian-research.md principles.

### Actual Research Test
```
You: "Research the fundamentals of agile transformation. Focus on why organizations adopt agile and common challenges."
```

**Watch for:**
- Does Claude Code clarify scope first?
- Does it create multiple notes?
- Are notes in the right directories?
- Do notes have wikilinks?
- Does it log to BlogLog?
- Does it commit to git?

**When complete, check:**
```bash
# See what was created
ls sources/
ls concepts/

# Check BlogLog
bl timeline

# Check git
git log --oneline

# See commits
git show --stat HEAD
```

### Back to Obsidian
Refresh the file explorer (or restart Obsidian)

**Verify:**
- New notes appear
- Can click wikilinks to navigate
- Graph view shows connections (View → Graph view)
- Notes are readable and substantive

## Troubleshooting

### Claude Code doesn't see CLAUDE.md
**Check:** Are you in the vault directory? `pwd` should show .../test-agile

### Claude Code doesn't follow research methodology
**Check:** Is skill installed?
```bash
ls ~/.claude/skills/obsidian-research.md
```

If not, re-copy:
```bash
cp ~/obsidian-research-assistant/skills/obsidian-research.md ~/.claude/skills/
```

### Notes aren't linking
**Check:** Are wikilinks present in the markdown? `cat concepts/agile-transformation.md`

### BlogLog not working
**Check:** Is .bloglog directory present? `ls -la .bloglog/`

### Git not committing
**Check:** Is git configured?
```bash
git config user.name
git config user.email
```

## If Everything Works

### Test More Workflows

**Question creation:**
```
You: "I'm seeing contradictory claims about whether agile scales to large organizations. Document this as a research question."
```

**Verify:** Question note created in /questions/

**Progress summary:**
```
You: "Summarize my research progress"
```

**Verify:** Reads BlogLog, provides summary

**Vault health:**
```
You: "Check vault health"
```

**Verify:** Identifies any structural issues

## Prepare for Brother Demo

### Clean Demo Vault
Create a fresh vault for demo purposes:
```bash
./setup-vault.sh ~/vaults/demo-research "Demo Research Vault"
```

### Run One Clean Research Cycle
Pick a topic he'd find relevant (not agile, something work-related to his domain).

### Document Feedback
Create a simple feedback doc to capture:
- What was confusing?
- What worked well?
- Would he use it?
- What's missing?

## Evening: Document Issues

In docs/testing-checklist.md, fill in the "Issues Encountered" section with any problems you found and how you solved them.

## Success Metrics

✅ **Minimum viable (ready for brother):**
- Setup script works
- One research workflow completes
- Notes appear in Obsidian with links
- You can explain the value

✅ **Good to go for Caitlyn:**
- Multiple workflows tested
- Documentation is accurate
- You're confident in the setup process
- Ready to adapt for Windows

## Time Budget

- Setup: 30 min
- First research test: 1 hour
- Additional testing: 1 hour
- Brother demo prep: 30 min
- Buffer for issues: 1 hour

**Total: ~4 hours**

## Next Steps After Testing

If everything works:
1. Show your brother (get feedback)
2. Refine based on feedback
3. Test on Windows (or WSL) for Caitlyn
4. Create her vault Tuesday
5. Push to GitHub as portfolio piece

If things break:
1. Document issues
2. Fix critical blockers
3. Defer nice-to-haves
4. Get to minimum viable for brother
