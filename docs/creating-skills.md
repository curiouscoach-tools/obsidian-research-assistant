# Creating Custom Skills

This guide explains how to create your own skill (persona) for use in Obsidian research vaults.

## What is a Skill?

A skill is a markdown file that instructs Claude how to behave for a specific purpose. When you type `/skillname` in Claude Code, it loads the skill and follows its instructions.

Skills can include:
- A persona with expertise in a domain
- Workflows and methodologies
- Templates for creating notes
- Folder structures for organising work

## File Structure

Skills live in the `skills/` directory:

```
obsidian-research-assistant/
├── skills/
│   ├── registry.json       # Declares all available skills
│   ├── skills-manager.md   # The /skills command itself
│   ├── laura-academic.md   # Research assistant (academic)
│   ├── laura-professional.md
│   ├── alex.md             # Solution architect
│   ├── riley.md            # Product owner
│   ├── casey.md            # Reflection buddy
│   └── your-skill.md       # Your custom skill
├── templates/              # Note templates skills can use
│   ├── source-note.md
│   ├── concept-note.md
│   └── ...
```

## Creating a Skill

### 1. Write the SKILL.md File

Create a markdown file in `skills/` with your skill name (e.g., `analyst.md`).

**Basic structure:**

```markdown
# Analyst - Competitive Intelligence

## Purpose

[One paragraph explaining what this skill does and when to use it]

## When to Use This Skill

- [Situation 1]
- [Situation 2]
- [Situation 3]

## Core Expertise

### [Area 1]
- [Capability]
- [Capability]

### [Area 2]
- [Capability]
- [Capability]

## Workflows

### [Workflow Name]

**Input:** [What triggers this workflow]

**Process:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Output:** [What gets created]

## Quality Standards

[What good looks like for this skill's outputs]

## Notes

[Anything else Claude should know]
```

### 2. Register the Skill

Add your skill to `skills/registry.json`:

```json
{
  "skills": {
    "analyst": {
      "file": "analyst.md",
      "description": "Competitive intelligence and market analysis",
      "folders": ["analysis/competitors", "analysis/markets"],
      "templates": ["competitor-profile.md", "market-overview.md"]
    }
  }
}
```

**Fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `file` | Yes | Filename in skills/ directory |
| `description` | Yes | One-line description shown in `/skills` list |
| `folders` | No | Folders to create when skill is added |
| `templates` | No | Templates to copy to `_templates/` when added |
| `variants` | No | For skills with multiple versions (like laura) |
| `default_variant` | No | Which variant to use by default |

### 3. Create Templates (Optional)

If your skill needs specific note templates, create them in `templates/`:

```markdown
---
type: competitor-profile
company:
industry:
updated: {{date}}
tags:
  - competitor
  - analysis
---

# {{company}}

## Overview
[Brief description of the company]

## Products/Services
-

## Strengths
-

## Weaknesses
-

## Recent Moves
-

## Implications for Us
[What this means for our strategy]
```

### 4. Test Your Skill

1. Add the skill to a test vault: `/skills add analyst`
2. Verify folders were created
3. Verify templates were copied
4. Activate the skill: `/analyst`
5. Test the workflows

## Design Considerations

### Scope

**Good scope:**
- Focused on one domain or activity
- Clear when to use vs other skills
- Complements rather than duplicates existing skills

**Too broad:**
- "General assistant" (no focus)
- Overlaps significantly with existing skills

**Too narrow:**
- Only useful for one very specific task
- Could be a workflow within another skill instead

### Folder Structure

Consider what structure your skill needs:

```
# Analyst might need:
analysis/
├── competitors/     # One note per competitor
├── markets/         # Market overviews
├── trends/          # Trend analysis
└── reports/         # Synthesised reports
```

**Guidelines:**
- Keep it minimal - only create folders you'll actually use
- Use lowercase, hyphenated names
- Think about how notes will be organised and found
- Consider how this integrates with existing vault structure

### Templates

Templates should:
- Have clear YAML frontmatter with relevant fields
- Include section headings that guide the user
- Use placeholders like `{{date}}`, `{{title}}` where appropriate
- Be concise - templates are starting points, not forms to fill

### Workflows

Good workflows:
- Have clear triggers ("When user asks to analyse a competitor...")
- Specify concrete steps
- Define what artifacts get created
- Include quality checks

### Integration with Other Skills

Consider:
- How does your skill's output feed into other skills?
- What existing notes might your skill reference?
- Should your skill update shared files (like research-log.md)?

## Examples

### Simple Skill (No Templates/Folders)

A skill that doesn't need its own structure:

```json
"reviewer": {
  "file": "reviewer.md",
  "description": "Code review and PR feedback",
  "folders": [],
  "templates": []
}
```

### Skill with Variants

For skills that have different modes:

```json
"writer": {
  "description": "Writing assistant",
  "variants": {
    "technical": {
      "file": "writer-technical.md",
      "description": "Technical documentation and specs"
    },
    "creative": {
      "file": "writer-creative.md",
      "description": "Creative and narrative writing"
    }
  },
  "default_variant": "technical",
  "folders": ["drafts", "published"],
  "templates": ["document-outline.md"]
}
```

### Skill with Full Structure

A comprehensive skill:

```json
"legal": {
  "file": "legal.md",
  "description": "Legal research and case analysis",
  "folders": [
    "cases",
    "statutes",
    "arguments",
    "briefs"
  ],
  "templates": [
    "case-brief.md",
    "statute-note.md",
    "legal-argument.md"
  ]
}
```

## Checklist

Before finalising your skill:

- [ ] Clear, focused purpose
- [ ] Doesn't duplicate existing skills
- [ ] SKILL.md has all necessary sections
- [ ] Registered in registry.json
- [ ] Folders are minimal and well-named
- [ ] Templates have proper frontmatter
- [ ] Tested in a vault
- [ ] Works alongside other skills

## Contributing

To contribute a skill to this repository:

1. Create the skill following this guide
2. Test thoroughly in your own vaults
3. Submit a pull request with:
   - The skill file
   - Any templates
   - Updated registry.json
   - Brief description of use cases

## Questions?

- How skills work: See `skills/skills-manager.md`
- Existing skills as examples: See `skills/*.md`
- Vault setup: See main README.md
