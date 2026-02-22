# Research Assistant - Professional Knowledge Base Building

Use this skill for work research, knowledge management, learning projects, and general note-taking where verification overhead can be lighter than academic contexts.

## CRITICAL: You Must Create Files

**PRIMARY DIRECTIVE: Always create actual files in the vault. Never just discuss what you would create.**

When the user asks you to research a topic:
1. ✅ CREATE concept note files in /concepts/
2. ✅ CREATE source note files in /sources/
3. ✅ CREATE question notes in /questions/ when gaps emerge
4. ✅ CREATE Maps of Content in /themes/
5. ✅ UPDATE research log in /_meta/research-log.md

**DO NOT:**
- ❌ Just summarize findings in conversation
- ❌ Describe what files you would create
- ❌ Wait for permission to create files
- ❌ Only update CLAUDE.md

**The user expects to see markdown files appear in their Obsidian vault.**

If you write more than 2 paragraphs without using create_file tools, you're doing it wrong.

## First Session Setup

**In your first session with a new vault, offer to streamline the research workflow.**

Research involves frequent web fetching, file creation, and git operations. Offer to help configure permissions:

```
"To speed up research, I can help you configure permissions so you won't be
interrupted for common actions. Would you like to set up blanket approvals for:

- Web fetching (any domain) - for discovering sources
- Git commands - for version control
- File creation in vault folders - for creating notes

You can always change these later."
```

Record preferences in CLAUDE.md. Don't ask again if declined.

## Research Methodology

### 1. Scope Definition First

Before gathering information:
- What specific question is being answered?
- What's in scope vs out of scope?
- What depth needed? (Survey vs deep dive)
- What's the intended use?

### 2. Source Quality Assessment

**For professional/work research:**
- **PRIORITIZE**: Industry reports (Gartner, Forrester), reputable vendor whitepapers
- **ACCEPTABLE**: Practitioner blogs from known experts, case studies, documentation
- **CAUTION**: Marketing content, unverified claims, echo chambers
- **VERIFY**: Author track record, company reputation, conflicts of interest

**For general learning:**
- **PRIORITIZE**: Well-written explanations that cite sources
- **ACCEPTABLE**: Tutorial content, curated lists, educational sites
- **CAUTION**: Outdated content, unverified claims

**Red flags:**
- No author attribution
- Lack of citations
- Promotional language
- Sweeping claims without nuance

**When uncertain:** Cross-reference across sources, note uncertainty in notes.

### 3. Note Types

**Source notes** - One per source document
- Citation details (author, date, title, URL)
- Summary of main points (2-3 paragraphs)
- Key quotes or findings
- Critical assessment (strengths, weaknesses, biases)
- Links to concepts discussed
- Quality indicator: industry report | practitioner | documentation | general web

**Concept notes** - One per distinct idea
- Clear definition
- Context (where does this concept apply?)
- Relationships to other concepts
- Examples
- Sources where concept appears

**Question notes** - Open questions driving research
- What are we trying to understand?
- Why does this matter?
- What would answer this question?
- Related questions

**Maps of Content (MOCs)** - Thematic overviews
- Navigation hub for a topic area
- Organized links to related notes
- Narrative explaining connections

### 4. Progressive Knowledge Building

Build understanding in layers:

**Layer 1: Foundations**
- Core definitions and concepts
- Established frameworks
- Key thinkers or sources

**Layer 2: Context**
- Historical development
- Different approaches or schools of thought
- Practical applications

**Layer 3: Frontiers**
- Recent developments
- Open questions
- Emerging perspectives

**Always work from foundations up.**

### 5. Connection-Making

**Link creation strategy:**
- Every new note should connect to at least 2 existing notes
- Use wikilinks with the ACTUAL filename: `[[walkability]]` not `[[concept-walkability]]`
- Use descriptive context: "This relates to [[walkability]] because..."
- Create bi-directional understanding

**Connection opportunities:**
- Shared terminology
- Similar problem spaces
- Complementary perspectives
- Dependencies or prerequisites
- Real-world applications

### 6. Gap Identification

**Types of gaps:**
- Conceptual: "We understand X but not Y"
- Empirical: "This claim needs evidence"
- Application: "How does this work in practice?"
- Connection: "How does X relate to Y?"

**Document gaps:**
- Create question notes for unresolved issues
- Tag notes with `#needs-research` or `#uncertain`
- Track in research backlog

## Progress Tracking

### Core Files

**`_meta/research-log.md`** - Session diary
- What was researched
- Key insights
- Blockers encountered
- Sources processed

**`_meta/research-backlog.md`** - Research agenda
- Questions to investigate
- Topics to explore
- Sources to find/process
- Prioritised by importance

### Research Log Format

```markdown
# Research Log

## 2024-02-15

### Session Focus
Data streaming platforms comparison

### Key Insights
- Kafka dominates for high-throughput scenarios
- Pulsar offers better multi-tenancy

### Work Completed
- Processed 3 sources: [[kafka-docs]], [[pulsar-overview]], [[gartner-streaming]]
- Created 5 concept notes
- Updated [[streaming-platforms-moc]]

### Blockers
- Need access to internal case studies

### Next Session
- Deep dive on exactly-once semantics
- Compare pricing models
```

### Session Structure

**At Session Start:**
1. Read `_meta/research-backlog.md` to see pending work
2. Briefly summarise top 2-3 priorities
3. Ask which to focus on

**At Session End:**
When user signals they're finishing ("let's wrap up", "end session"):
1. Summarise what was accomplished
2. Update `_meta/research-log.md`
3. Add any new questions to backlog
4. Commit changes
5. Suggest focus for next session

## Workflow Patterns

### Pattern: Initial Topic Research

**INPUT:** "I need to understand [topic]"

**CRITICAL: Must create files. Never just discuss.**

**PROCESS:**
1. Scope clarification (one question max if truly ambiguous)

2. Research and CREATE FILES IMMEDIATELY
   - Search for 3-5 authoritative sources
   - CREATE source notes in /sources/
   - Identify 5-10 core concepts
   - CREATE concept notes in /concepts/

3. Build navigation
   - CREATE Map of Content in /themes/
   - Link concepts together

4. Log progress
   - UPDATE research-log.md
   - Add research questions to backlog

**Verification:** User should see 3-5 source files, 5-10 concept files, 1 MOC.

### Pattern: Source Processing

**INPUT:** User provides source (article, report, documentation)

**NOTE:** If web_fetch fails (403, 401), request manual download rather than retrying.

**PROCESS:**
1. Scan: Type, main points, key concepts
2. Create source note: Citation, summary, key findings, assessment
3. Extract concepts: Create new notes or update existing
4. Integrate: Link to related notes, update MOCs
5. Log: Update research-log.md

### Pattern: Knowledge Synthesis

**INPUT:** "Help me understand the relationship between [A] and [B]"

**PROCESS:**
1. Review notes on both concepts
2. Identify relationship type (causal, hierarchical, complementary, contradictory)
3. Create synthesis note with evidence
4. Note gaps, log connections

### Pattern: Question Note Creation

**INPUT:** Research reveals unanswered question or gap

**PROCESS:**
1. Capture: What's unclear? Why does it matter? What would answer it?
2. Create question note in `/questions/` with frontmatter and context
3. Link to related concepts
4. Add to backlog

## Quality Standards

### Note Checklist
- [ ] Clear, descriptive title
- [ ] YAML frontmatter (date, tags, type)
- [ ] At least 2 wikilinks to other notes
- [ ] Source attribution where appropriate
- [ ] Flags uncertainty

### Vault Health

✅ Good signs:
- Dense connection network
- Balance across note types
- Clear navigation via MOCs
- Recent research log updates

⚠️ Warning signs:
- Many orphaned notes
- Long notes (>500 words)
- Vague titles
- No MOCs

## Common Pitfalls

**Over-collection without synthesis** - Extract concepts and connections, aim for understanding
**Premature deep-diving** - Build foundations first
**Link spam** - Links should be meaningful with context
**Isolated notes** - Every note connects to broader structure
**Uncritical acceptance** - Note biases, flag contradictions

## Template Governance

Templates should evolve with the vault.

**On setup:** Review templates, identify domain-specific YAML fields, document in `_meta/domain-context.md`

**Ongoing:** Watch for repeated manual additions, unused sections, inconsistent metadata. Propose changes, get confirmation.

**YAML practices:** Consistent formats, lean frontmatter, ISO dates, lowercase kebab-case tags.

## Version Control

After each session:
```bash
git commit -m "Research: [Topic] - [X] sources, [Y] concepts"
```

## Paywalled Content

**Cannot:** Log into portals, download protected content, bypass bot protection

**Workflow:** User downloads to `/sources/raw/`, prompts "Process the source I added"

**When fetch fails (403, 401):** Don't retry, request manual download, create stub with `#needs-content` if needed.

## Self-Check

Before completing:
1. ✅ Created actual .md files?
2. ✅ Sources appropriate for context?
3. ✅ Notes linked (≥2 links)?
4. ✅ Uncertainties flagged?
5. ✅ Research log updated?
6. ✅ Changes committed?

**Quality over speed** - fewer, well-connected notes beat many isolated fragments.

## FINAL REMINDER: Always Create Files

Before responding to ANY research request:
1. "Have I created actual .md files?"
2. "Will user see new files in Obsidian?"
3. "Did I use create_file tools?"
4. "Do wikilinks match actual filenames?"

**Every research request should result in multiple create_file tool calls.**
