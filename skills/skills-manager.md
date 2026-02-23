# Skills Manager

Manage skill installation, removal, and updates for this vault.

## Commands

This skill responds to `/skills` with optional subcommands:

```
/skills                           List installed and available skills
/skills add <name>                Install a skill
/skills remove <name>             Remove a skill
/skills switch <name> <variant>   Switch to a different variant
/skills update [name]             Update skill(s) from source
```

## Configuration

The skill source repository path is stored in this vault's CLAUDE.md. Look for:

```
skill-source: /path/to/obsidian-research-assistant
```

If this line is missing, tell the user:
> "Skill source not configured. Add `skill-source: /path/to/repo` to CLAUDE.md, or re-run vault setup."

---

## /skills (List)

**When user runs `/skills` with no arguments:**

1. Read the `skill-source` path from CLAUDE.md
2. Read `skills/registry.json` from that path
3. List directories in this vault's `.claude/skills/` folder
4. For each installed skill:
   - If it's `laura`, detect variant by checking SKILL.md content:
     - Contains "Emergency Check Before Submission" → academic
     - Otherwise → professional
5. Display:

```
Installed:
  ✓ laura (professional)
  ✓ alex

Available to add:
  ○ riley - Product owner for user-centred thinking
  ○ casey - Reflection buddy for journaling

Commands:
  /skills add <name>      Install a skill
  /skills remove <name>   Remove a skill
  /skills update          Update all installed skills
```

---

## /skills add <name>

**When user runs `/skills add alex`:**

1. Read `skill-source` from CLAUDE.md
2. Read `skills/registry.json` to validate skill exists and get requirements
3. Check if `.claude/skills/<name>/` already exists
   - If yes: "alex is already installed. Use `/skills update alex` to refresh, or `/skills remove alex` first."
4. Get the source file path from registry:
   - Simple skills: `skills/<file>` (e.g., `skills/alex.md`)
   - Skills with variants (laura): prompt for variant, then use `skills/<variant-file>`
5. Read the source file content
6. Create `.claude/skills/<name>/` directory
7. Write content to `.claude/skills/<name>/SKILL.md`
8. **Create any folders the skill needs** (from registry `folders` array):
   - Create each folder if it doesn't already exist
   - Don't overwrite existing folders
9. **Copy any templates the skill needs** (from registry `templates` array):
   - Copy from `<skill-source>/templates/<template>` to `_templates/`
   - Don't overwrite existing templates
10. Confirm with summary:

```
Added skill: casey

Created folders:
  + journal/daily
  + journal/weekly
  + journal/monthly
  + journal/quarterly

Added templates:
  + daily-reflection.md
  + weekly-review.md
  + monthly-review.md
  + quarterly-review.md

Use /casey to activate.
```

If folders/templates already exist, note "(already exists)" instead of "+".

**For skills with variants (laura):**

Ask: "Which variant? Options: professional (default), academic"
- professional: Work research with lighter verification
- academic: Dissertations/theses with strict verification

Then install the chosen variant.

---

## /skills remove <name>

**When user runs `/skills remove alex`:**

1. Check if `.claude/skills/<name>/` exists
   - If not: "alex is not installed."
2. Delete the entire `.claude/skills/<name>/` directory
3. Confirm: "Removed skill: alex"

**Special case for `skills` (this skill):**
- Allow removal but warn: "This will disable /skills commands. Re-run vault setup to restore."

---

## /skills switch <name> <variant>

**When user runs `/skills switch laura academic`:**

1. Read registry to check skill supports variants
   - If no variants: "<name> doesn't have variants."
2. Check variant is valid
   - If invalid: "Unknown variant. Available: professional, academic"
3. Check skill is installed
   - If not: "laura is not installed. Use `/skills add laura` first."
4. Read new variant source file from repo
5. Overwrite `.claude/skills/<name>/SKILL.md`
6. Confirm: "Switched laura to academic variant."

---

## /skills update [name]

**When user runs `/skills update` or `/skills update alex`:**

**If no name specified:** Update all installed skills.

**Process for each skill:**

1. Check it's installed in `.claude/skills/<name>/`
2. For laura: detect current variant first (check for "Emergency Check Before Submission")
3. Read fresh content from repo's `skills/` directory
4. Overwrite `.claude/skills/<name>/SKILL.md`
5. Report what was updated

**Output:**
```
Updated 2 skills:
  ✓ laura (professional)
  ✓ alex

Use /skills switch laura <variant> to change variants.
```

---

## Error Handling

**Repo path not found:**
> "Cannot find skill source. Check the `skill-source` path in CLAUDE.md exists and is accessible."

**Registry file missing:**
> "Cannot find skills/registry.json in the source repo. Is the repo up to date?"

**Source skill file missing:**
> "Cannot find <file> in source repo. The skill may have been renamed or removed."

**Unknown skill name:**
> "Unknown skill: <name>. Available skills: laura, alex, riley, casey"

---

## Notes

- Skills are self-contained once installed - no external dependencies
- The `skills` skill itself can be removed but this disables management commands
- Laura has two variants; other skills currently have one version each
- All paths should work on both Windows and Linux (Claude handles path differences)
- **Adding a skill** creates folders and copies templates the skill needs
- **Removing a skill** only removes the skill file - folders and templates remain (user's content is preserved)
