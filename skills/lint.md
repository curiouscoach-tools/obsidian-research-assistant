# Lint - Vault Health Checker

Audit vault structure, connections, and content quality. Surfaces issues without being preachy. Use UK English throughout.

## Core Directives

1. **Report, don't lecture.** Surface issues with counts and examples. User decides what to fix.

2. **Machine-readable output.** Write reports to `_meta/lint-report.md` with consistent format for tracking over time.

3. **Prioritise actionable.** Orphaned notes are fixable. "Could be better" isn't helpful.

4. **Respect all vault types.** Works with research, journal, architecture, product vaults. Adapts checks to what exists.

## Commands

| Command | Action |
|---------|--------|
| `/lint` | Full vault health check, write report |
| `/lint orphans` | Notes with <2 wikilinks |
| `/lint stale` | Notes with verification tags or not updated in 30+ days |
| `/lint verify` | Notes tagged #verify, #needs-citation, #needs-research, #uncertain |
| `/lint structure` | Missing frontmatter, oversized notes, empty folders |
| `/lint connections` | Broken links, missing backlinks, cluster analysis |
| `/lint quick` | Summary stats only, no file writes |

## Full Lint Report Structure

Write to `_meta/lint-report.md`:

```markdown
---
type: lint-report
generated: {{datetime}}
---

# Vault Health Report

Generated: {{datetime}}

## Summary

| Metric | Count | Status |
|--------|-------|--------|
| Total notes | X | |
| Orphaned (<2 links) | X | {{ok/warning/alert}} |
| Pending verification | X | {{ok/warning/alert}} |
| Stale (>30 days) | X | {{ok/warning/alert}} |
| Oversized (>500 lines) | X | {{ok/warning/alert}} |
| Missing frontmatter | X | {{ok/warning/alert}} |
| Broken links | X | {{ok/warning/alert}} |

## Orphaned Notes

Notes with fewer than 2 wikilinks (incoming + outgoing):

- `concepts/example.md` (0 links)
- `sources/another.md` (1 link)

**Suggestion:** Add links or consider if these notes belong elsewhere.

## Pending Verification

Notes with verification tags that need attention:

| Note | Tag | Created |
|------|-----|---------|
| `concepts/claim.md` | #verify | 2026-01-15 |
| `sources/paper.md` | #needs-citation | 2026-02-01 |

## Stale Notes

Notes not modified in 30+ days (excluding templates and meta):

- `concepts/old-topic.md` (45 days)
- `questions/unanswered.md` (60 days)

## Structure Issues

### Missing Frontmatter
- `concepts/no-yaml.md`

### Oversized Notes (>500 lines)
- `themes/massive-moc.md` (723 lines) - consider splitting

### Empty Folders
- `architecture/risks/` (0 files)

## Connection Analysis

### Broken Links
Wikilinks pointing to non-existent notes:
- `concepts/foo.md` links to [[nonexistent]]

### Hub Notes
Most connected notes (potential MOC candidates if not already):
- `concepts/core-idea.md` (15 incoming links)

### Isolated Clusters
Groups of notes that link to each other but not the wider vault:
- Cluster: api-design, rest-patterns, endpoint-naming (no links outside cluster)

## Recommended Actions

1. **High priority:** Fix X broken links
2. **Medium priority:** Review X verification tags
3. **Low priority:** Add links to X orphaned notes
```

## Check Definitions

### Orphaned Notes
- Fewer than 2 total links (incoming + outgoing wikilinks)
- Exclude: `_meta/`, `_templates/`, `CLAUDE.md`, `README.md`
- Status: 0 = ok, 1-5 = warning, 6+ = alert

### Verification Tags
Scan for: `#verify`, `#needs-citation`, `#needs-research`, `#uncertain`, `#unverified`, `#ai-generated`
- Status: 0 = ok, 1-10 = warning, 11+ = alert

### Stale Notes
- Not modified in 30+ days
- Exclude: `_meta/`, `_templates/`, templates, config files
- Status: 0-10 = ok, 11-25 = warning, 26+ = alert

### Log Parsing
Logs follow format: `## [YYYY-MM-DD] operation | Subject`

**Research operations:** `ingest`, `research`, `synthesise`, `review`, `question`, `fix`
**Journal operations:** `daily`, `weekly`, `monthly`, `quarterly`, `pattern`, `theme`

Use log dates to determine actual activity vs file modification time.

### Oversized Notes
- More than 500 lines
- Likely needs splitting into sub-concepts or sub-MOCs
- Status: 0 = ok, 1-3 = warning, 4+ = alert

### Connection Health
- Broken links: any wikilink `[[target]]` where target.md doesn't exist
- Hub detection: notes with 10+ incoming links (potential MOCs)
- Cluster detection: 3+ notes linking only to each other

## Session Flow

1. **Scan** - Read all .md files, parse frontmatter and wikilinks
2. **Analyse** - Run checks, collect issues
3. **Report** - Write `_meta/lint-report.md`
4. **Summarise** - Display key findings in conversation

Don't auto-fix anything. User decides what to address.

## Tracking Over Time

Append to `_meta/lint-history.md` (create if missing):

```markdown
## {{date}}
- Orphaned: X ({{+/-Y}} from last)
- Verification: X
- Stale: X
- Health score: X/100
```

Health score = 100 - (orphaned×2) - (verification×3) - (broken×5) - (oversized×1)
Capped at 0 minimum.

## Limitations

- Cannot detect semantic contradictions (only surfaces notes on same topic for manual review)
- Stale detection uses file modification time, not content analysis
- Cluster detection is approximate based on link patterns
