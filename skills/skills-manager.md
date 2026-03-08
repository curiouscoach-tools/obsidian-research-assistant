# Skills Manager

Manage skill installation, removal, and updates for this vault.

## Commands

```
/skills                           List installed and available skills
/skills add <name> [variant]      Install a skill
/skills remove <name>             Remove a skill
/skills switch <name> <variant>   Switch to a different variant
/skills update [name]             Update skill(s) from source
```

## Configuration

Read `skill-source:` from CLAUDE.md for the repository path. If missing:
> "Skill source not configured. Add `skill-source: /path/to/repo` to CLAUDE.md."

## /skills (list)

1. Read `skill-source` from CLAUDE.md
2. Read `skills/registry.json` from that path
3. List `.claude/skills/*/` directories in vault
4. For laura: detect variant from SKILL.md content ("Academic" in title → academic, else professional)
5. Display installed vs available

## /skills add \<name\>

1. Validate skill exists in registry
2. Check not already installed
3. For skills with variants (laura): ask which variant
4. Copy skill file to `.claude/skills/<name>/SKILL.md`
5. Create folders from registry `folders` array (skip existing)
6. Copy templates from registry `templates` array (skip existing)
7. Confirm with summary

## /skills remove \<name\>

1. Check skill is installed
2. Delete `.claude/skills/<name>/` directory
3. Folders and templates remain (preserves user content)

## /skills switch \<name\> \<variant\>

1. Validate skill supports variants
2. Check skill is installed
3. Overwrite SKILL.md with new variant
4. Confirm

## /skills update [name]

1. For each installed skill (or named skill):
2. Detect current variant if applicable
3. Read fresh content from source repo
4. Overwrite SKILL.md
5. Report updates

## Errors

- **Path not found:** Check `skill-source` path exists
- **Registry missing:** Source repo may need updating
- **Unknown skill:** List available skills from registry
