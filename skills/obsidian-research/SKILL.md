# Research Assistant - Knowledge Base Building

## Purpose
Guide systematic research and knowledge base construction in Obsidian vaults. This skill focuses on research methodology, not domain expertise.

## When to Use This Skill
- User requests background research on any topic
- User asks to process/structure source material
- User needs help organizing knowledge
- User wants to identify research gaps or next steps

## Research Methodology Principles

### 1. Scope Definition First
Before gathering information, establish clear boundaries:

**Questions to clarify:**
- What is the specific question being answered?
- What's in scope vs out of scope?
- What level of depth is needed? (Survey vs deep dive)
- What's the intended use? (Background knowledge, decision support, comprehensive understanding)

**Output:** Clear problem statement and scope boundaries

### 2. Source Quality Assessment
Not all sources are equal. Evaluate credibility:

**Academic research:**
- Peer-reviewed journals > Conference papers > Preprints
- Check citation count and recency
- Look for systematic reviews or meta-analyses
- Note methodology limitations

**Industry/professional:**
- Authoritative organizations in the field
- Practitioners with track record
- Primary sources over commentary
- Check for conflicts of interest

**General web:**
- Verify author credentials
- Cross-reference claims across sources
- Prefer original sources over aggregators
- Be skeptical of claims without evidence

**Red flags:**
- No author attribution
- Lack of citations or sources
- Overly promotional language
- Sweeping claims without nuance

### 3. Information Architecture
Structure knowledge for discovery and connection:

**Note types and their purposes:**

**Source notes** - One per source document
- Full citation details
- Summary of main arguments
- Key quotes (with page numbers)
- Personal assessment/critique
- Links to concepts discussed

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
- Visual representation of structure

### 4. Progressive Knowledge Building
Build understanding in layers:

**Layer 1: Foundations**
- Core definitions and concepts
- Established facts and frameworks
- Key thinkers and seminal works

**Layer 2: Context**
- Historical development
- Different schools of thought
- Debates and controversies
- Practical applications

**Layer 3: Frontiers**
- Recent developments
- Open questions
- Emerging perspectives
- Critical analysis

**Always work from foundations up** - don't start with advanced topics before basics are covered.

### 5. Connection-Making
Knowledge value comes from connections:

**Link creation strategy:**
- Every new note should connect to at least 2 existing notes
- Look for: similar concepts, contrasting ideas, cause-effect, part-whole, examples-of
- Use descriptive link context: "This relates to [[concept]] because..."
- Create bi-directional understanding (A→B and B→A should both make sense)

**Identifying connection opportunities:**
- Shared terminology
- Similar problem spaces
- Complementary perspectives
- Dependencies or prerequisites
- Real-world applications

### 6. Gap Identification
Research is never "complete" - make gaps visible:

**Types of gaps:**
- Conceptual: "We understand X but not Y"
- Empirical: "This claim needs evidence"
- Perspective: "Missing voices or viewpoints"
- Application: "How does this work in practice?"
- Connection: "How does X relate to Y?"

**Documenting gaps:**
- Create question notes for unresolved issues
- Tag notes with #needs-research or #uncertain
- Maintain research log tracking what's explored vs what remains

## Progress Tracking

Track research activity for momentum and reporting using BlogLog or fallback timeline:

**Primary: Use BlogLog commands if available:**
- Log wins (breakthroughs, significant findings)
- Log notes (regular research activity)
- Log blockers (obstacles needing resolution)

**Fallback: If `bl` command not available:**
- Write directly to `.bloglog/timeline.json`
- Maintain same structure for compatibility
- User can still generate progress reports

**Timeline JSON structure:**
```json
{
  "entries": [
    {
      "type": "win",
      "message": "Connected TOD concepts to housing affordability framework",
      "timestamp": "2024-02-14T15:30:00Z"
    },
    {
      "type": "note", 
      "message": "Processed 3 papers on density policy",
      "timestamp": "2024-02-14T16:00:00Z"
    },
    {
      "type": "blocker",
      "message": "Need institutional access for Smith 2023 paper",
      "timestamp": "2024-02-14T16:15:00Z"
    }
  ]
}
```

**When to log:**

**Wins** - Significant progress or insights
- Found authoritative source that clarifies key concept
- Made important connection between concepts
- Resolved conflicting information
- Completed foundation understanding of major topic
- Breakthrough that unblocks further research

**Notes** - Regular research activity
- Completed research session
- Processed sources (with count)
- Created concept/source notes (with count)
- Updated MOCs or themes
- Routine maintenance work

**Blockers** - Obstacles preventing progress
- Can't access needed sources (paywall, institutional access)
- Contradictory information that needs resolution
- Missing foundational knowledge to proceed
- Technical issues with tools or workflow
- Awaiting external input (interviews, expert feedback)

**Implementation:**
1. Check if `bl` command exists
2. If yes: Use `bl win "message"`, `bl note "message"`, `bl blocker "message"`
3. If no: Append to `.bloglog/timeline.json` directly with proper JSON structure
4. Ensure `.bloglog/metadata.json` exists (create if needed)

**Don't log:**
- Every individual file creation (too granular)
- Failed attempts or iterations (that's normal process)
- Exploratory dead-ends (unless they reveal important blocker)

**Progress reporting:**
- Read `.bloglog/timeline.json` for activity history
- Generate activity summaries over time periods
- Shows research velocity and patterns
- Highlights wins and persistent blockers

## Workflow Patterns

### Pattern: Initial Topic Research

**INPUT:** "I need to understand [topic]"

**PROCESS:**
1. Scope clarification
   - Ask: What specifically about this topic?
   - Ask: What will you use this knowledge for?
   - Define boundaries

2. Landscape mapping
   - Identify 3-5 authoritative overview sources
   - Create high-level concept map
   - Note major sub-topics or schools of thought
   - Log: Try `bl note "Research session: [topic] - initial exploration"` or append to timeline.json

3. Foundation building
   - Research core concepts (5-10 concept notes)
   - Create source notes for key references
   - Build initial MOC as navigation hub
   - Log significant findings: Try `bl win "Found authoritative [source] framework"` or append to timeline.json

4. Gap analysis
   - What foundational concepts are still unclear?
   - What questions emerged from initial research?
   - What areas need deeper exploration?
   - Create question notes for unresolved issues

**OUTPUT:**
- Structured vault content (sources, concepts, MOC)
- Research log entry documenting what's covered
- List of next research directions
- BlogLog entries: `bl note "Created [X] concept notes, [Y] source notes"`

### Pattern: Source Processing

**INPUT:** User provides source (PDF, article, book chapter)

**NOTE:** If web_fetch fails (403, 401, timeout), inform user and request manual download rather than retrying.

**PROCESS:**
1. Initial scan
   - What type of source? (Academic paper, book, report, blog)
   - Main thesis or argument?
   - Key concepts discussed?
   - If fetch failed: Request user provide PDF or content manually

2. Source note creation
   - Full citation
   - Summary (2-3 paragraphs)
   - Key arguments/findings
   - Notable quotes
   - Critical assessment
   - If only citation info available: Create stub with #needs-content tag

3. Concept extraction
   - Identify 3-7 key concepts
   - For each: Does this concept already exist in vault?
   - If yes: Add to existing note, link source
   - If no: Create new concept note
   - Log wins for significant findings: Try `bl win "Key insight on [concept] from [source]"` or append to timeline.json

4. Integration
   - Link source to related sources
   - Link concepts to each other
   - Update relevant MOCs
   - Note any contradictions with existing knowledge
   - If contradictions found: Try `bl blocker "Conflicting info on [topic] - needs resolution"` or append to timeline.json

5. Progress logging
   - Try `bl note "Processed [source] - [X] new concepts extracted"` or append to timeline.json

**OUTPUT:**
- Source note
- New/updated concept notes
- Updated cross-references
- BlogLog entry documenting processing

### Pattern: Knowledge Synthesis

**INPUT:** "Help me understand the relationship between [A] and [B]"

**PROCESS:**
1. Gather existing knowledge
   - Review notes on both concepts
   - Check sources mentioning both
   - Look for existing connections

2. Identify relationship type
   - Causal (A causes B)
   - Hierarchical (A is part of B)
   - Temporal (A precedes B)
   - Complementary (A and B work together)
   - Contradictory (A vs B)

3. Build synthesis
   - Create new note or MOC
   - Explain relationship with evidence
   - Show supporting sources
   - Note gaps or uncertainties
   - If major connection: Try `bl win "Connected [A] and [B] - clarifies [insight]"` or append to timeline.json

**OUTPUT:**
- Synthesis note connecting concepts
- Updated concept notes with new links
- Questions for further investigation

### Pattern: Question Note Creation

**INPUT:** Research reveals unanswered question or gap in understanding

**TRIGGER PHRASES:**
- "I'm seeing contradictory claims about..."
- "It's unclear how X relates to Y"
- "This source mentions Z but doesn't explain..."
- "What's the evidence for...?"
- "How does this work in practice?"

**PROCESS:**
1. Capture the question clearly
   - What specifically is unclear?
   - Why does this matter for the research?
   - What would constitute an answer?

2. Create question note in `/questions/`
   - Descriptive filename: `how-does-tod-vary-by-context.md`
   - YAML frontmatter: date, tags, related concepts
   - Full question statement
   - Context: What led to this question?
   - Current understanding: What do we know so far?
   - Links to related concepts and sources
   - What would answer this: Criteria for resolution

3. Link to broader research
   - Add to relevant MOCs
   - Link from related concept notes
   - Note in research log

4. Log the question
   - Try `bl note "Generated research question: [brief question]"` or append to timeline.json
   - If blocking progress: Try `bl blocker "Need to resolve: [question]"` or append to timeline.json

**EXAMPLE QUESTION NOTE:**

```markdown
---
created: 2024-02-15
tags: [question, tod, implementation]
status: open
related: [[transit-oriented-development]], [[policy-frameworks]]
---

# How does TOD implementation differ across political contexts?

## Context
While researching TOD policy frameworks, noticed that [[academic-framework-tod]] focuses on US/Canadian context, while [[who-sustainable-transport]] emphasizes European approaches. These seem to assume different governance structures.

## What We Know
- TOD requires coordination across transport, housing, land-use planning
- [[governance-models]] vary significantly by country
- [[density-bonuses]] are common in North America but rare in Europe

## What's Unclear
- How do different political systems affect TOD adoption?
- Are there common patterns despite political differences?
- Which governance models are most effective for TOD?

## What Would Answer This
- Comparative policy analysis across contexts
- Case studies from different political systems
- Literature on governance and TOD outcomes

## Related Questions
- [[how-to-measure-tod-success]]
- [[community-engagement-in-planning]]
```

**OUTPUT:**
- Question note in `/questions/`
- Links added to related notes
- Research log updated
- BlogLog entry documenting question

## Quality Standards

### Note Quality Checklist
- [ ] Clear, descriptive title
- [ ] YAML frontmatter (date, tags, type)
- [ ] Concept clearly defined/explained
- [ ] At least 2 wikilinks to other notes
- [ ] Source attribution where appropriate
- [ ] Written for someone new to topic
- [ ] Flags uncertainty or conflicting views

### Vault Health Indicators
✅ Good signs:
- Dense connection network (most notes linked)
- Balance across note types (not all sources, not all concepts)
- Clear navigation via MOCs
- Recent research log updates
- Few orphaned notes

⚠️ Warning signs:
- Many orphaned notes (>10% unlinked)
- Long notes (>500 words - consider splitting)
- Vague titles ("Notes on X")
- Missing citations on factual claims
- No MOCs or navigation structure

## Common Pitfalls to Avoid

**Over-collection without synthesis**
- Don't just save sources - extract concepts and connections
- Aim for understanding, not just information accumulation

**Premature deep-diving**
- Build foundations before advanced topics
- Understand basic terminology before complex debates

**Link spam**
- Links should be meaningful, not every word that appears elsewhere
- Explain why links matter: "This relates to [[X]] because..."

**Isolated notes**
- Every note should connect to the broader knowledge structure
- If a note doesn't link to anything, question whether it belongs

**Uncritical acceptance**
- Note source quality and potential biases
- Flag contradictions between sources
- Distinguish facts from claims from opinions

## Version Control Integration

**After each research session:**
```bash
git add .
git commit -m "Research: [Topic] - [X] sources, [Y] concepts, [Z] links"
```

**Commit message patterns:**
- `Research: [topic] - initial exploration`
- `Source: Add [author] on [topic]`
- `Concept: Deep dive on [concept]`
- `Synthesis: Connect [A] and [B]`
- `Maintenance: Fix broken links, update MOC`

## Adaptation to User's Domain

This skill provides the **method**, not the **domain knowledge**. 

Domain-specific context lives in:
- Project CLAUDE.md (research focus, current status)
- Vault metadata (`/_meta/research-log.md`, `/_meta/domain-context.md`)
- Vault content itself (previous research informs future research)

The assistant reads existing vault content to understand the domain, but applies this generic research methodology.

## Example Self-Check

Before completing a research task, verify:
1. ✅ Scope was clarified before research began
2. ✅ Sources are authoritative for this domain
3. ✅ New notes follow templates and conventions
4. ✅ Concepts are linked to related concepts
5. ✅ Gaps or uncertainties are flagged
6. ✅ Research log is updated
7. ✅ Changes are committed with clear message
8. ✅ Significant progress logged to BlogLog (wins, notes, blockers as appropriate)

**Quality over speed** - better to create fewer, well-connected notes than many isolated fragments.

## Progress Reporting

When asked to summarize research progress (e.g., for supervisor meeting):

1. Read `.bloglog/timeline.json` for activity history
2. Analyze patterns:
   - Count of wins, notes, blockers over period
   - Research velocity (sessions per week, sources processed)
   - Focus areas and topic coverage
   - Persistent blockers needing attention
3. Generate narrative summary with key achievements and next steps
4. Highlight wins as evidence of progress
5. Frame blockers as known challenges being addressed

**Example prompt:** "Summarize my research progress over the last 2 weeks for my supervisor"

## Working with Paywalled Content

For academic sources behind institutional access:

**Assistant cannot:**
- Log into university portals
- Download paywalled papers
- Access content requiring authentication
- Bypass bot protection (403 errors are common)

**User workflow:**
1. User downloads PDF using their credentials (or copies content from browser)
2. User places PDF in `/sources/raw/` (or provides text directly)
3. User prompts: "Process the paper I just added"
4. Assistant extracts text, creates structured notes

This separation maintains security while enabling AI-assisted processing.

**When web_fetch fails (403, 401, timeout):**
- Don't retry fetching - it will fail again
- Inform user that direct fetch failed
- Request they download/provide the content manually
- Offer to create source note from user-provided information
- Never claim content is inaccessible if it might be behind authentication

**Alternative when fetch fails:**
If user can't provide the full source, create a stub source note with:
- Citation details
- URL for reference
- Note that full content needs manual retrieval
- Tag with #needs-content for later processing
