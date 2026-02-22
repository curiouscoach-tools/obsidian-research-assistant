# Obsidian Research Assistant

## Why This Exists

Postgraduate researchers, knowledge workers, and anyone building deep understanding of complex topics face a common problem: **research is fragmented and connections are invisible until you have critical mass**.

Manual note-taking creates isolated fragments. Traditional tools focus on capturing information but don't help you **think with** that information. You end up with:
- Scattered notes across documents
- Lost connections between ideas
- Unclear knowledge gaps
- Risk of losing work
- Overwhelm from trying to maintain structure manually

This project builds an AI research assistant that scaffolds systematic knowledge building in Obsidian, handling the structural overhead so the researcher can focus on thinking and understanding.

## What We're Building

An AI-powered research assistant (via Claude Code) that:

1. **Conducts structured research** - Takes a research topic, identifies authoritative sources, extracts key concepts, creates cross-referenced notes
2. **Builds knowledge systematically** - Works from foundations up, identifies gaps, suggests next research directions
3. **Maintains vault health** - Version control, link integrity, consistent structure
4. **Learns the research domain** - Uses vault content and research logs to build context over time
5. **Coaches thinking** - Helps identify connections, synthesize ideas, formulate questions

## The Product Philosophy

This is **AI augmentation, not automation**:
- AI handles structure, linking, source processing
- Human provides direction, critical thinking, synthesis
- The vault becomes a thinking tool, not just storage
- Value comes from connections, not just information

## Core User Workflows

### Initial Research Request

User: "I need to understand transit-oriented development"

**Assistant clarifies scope:**
- What specifically? (Overview, policy, design, economics?)
- What depth? (Survey understanding vs deep expertise)
- What's it for? (Background context, decision support, comprehensive study)

**Assistant conducts research:**
- Identifies 3-5 authoritative sources
- Maps core concepts and relationships
- Creates structured notes in vault
- Builds initial Map of Content as navigation hub

**Output in vault:**
- `/sources/tod-urban-planning-guide.md`
- `/sources/academic-tod-framework.md`
- `/concepts/transit-oriented-development.md`
- `/concepts/walkable-urbanism.md`
- `/concepts/density-bonuses.md`
- `/themes/sustainable-urban-planning.md` (MOC)
- `/_meta/research-log.md` (updated)

### Processing Paywalled Sources

For academic content behind institutional access or bot protection:

User downloads PDF using university credentials (or copies content from browser) → User places in sources/raw/ → User: "Process the transport planning paper I just added to /sources/raw/"

**Assistant processes:**
- Extracts text from PDF (or uses provided text)
- Creates structured source note with citation
- Identifies key concepts (3-7)
- Creates/updates concept notes
- Cross-references with existing knowledge
- Flags any contradictions with existing notes

**If web_fetch fails (403 Forbidden, 401 Unauthorized):**
- Assistant informs user of fetch failure
- Requests manual download or content provision
- OR creates stub source note with citation and #needs-content tag
- Never retries failed fetches - bot protection won't allow it

**Output:**
- `/sources/author-year-title.md` (structured source note)
- New or updated concept notes
- Updated links and MOCs
- Git commit: "Source: Add [Author] on [Topic]"

### Knowledge Synthesis

User: "Help me understand how transit-oriented development relates to housing affordability"

**Assistant synthesizes:**
- Reviews existing notes on both concepts
- Identifies relationship type (causal, complementary, contradictory)
- Creates synthesis note or updates MOC
- Provides evidence from sources
- Flags gaps or conflicting viewpoints

**Output:**
- New synthesis note connecting concepts
- Updated concept notes with new links
- Questions for further investigation

### Supervisor Progress Reports

User: "I have a meeting with my supervisor - summarize my progress over the last 2 weeks"

**Assistant generates report from research log:**
- Reads `_meta/research-log.md`
- Analyzes research activity patterns
- Summarizes wins, progress, active blockers
- Highlights key breakthroughs and next directions

**Example output:**
```markdown
## Research Progress (Last 2 Weeks)

### Wins (5)
- Connected TOD concepts to housing affordability framework
- Found authoritative WHO framework on transit planning
- Completed foundational understanding of density policy
- Resolved contradictory sources on mixed-use zoning
- Identified 3 case studies for comparative analysis

### Research Activity
- 12 research sessions
- 23 sources processed (18 academic, 5 policy documents)
- 47 concept notes created
- 8 Maps of Content developed

### Active Blockers (2)
- Need institutional access for Smith 2023 paper on TOD economics
- Awaiting response from transport planning expert for interview

### Focus Areas
- Transit-oriented development fundamentals ✅
- Policy frameworks and governance (in progress)
- Case study analysis (next phase)

### Next Steps
- Deep dive on TOD implementation challenges
- Comparative analysis of 3 identified case studies
- Resolve access blocker for Smith paper
```

## Vault Structure

```
dissertation-research/
├── .obsidian/        # Obsidian configuration (gitignored)
├── sources/          # Notes about specific papers, books, articles
│   ├── raw/         # Original PDFs (gitignored)
│   └── *.md         # Structured source notes
├── concepts/         # Individual concept explanations
├── themes/          # Maps of Content - thematic overviews
├── questions/       # Open research questions
├── _meta/
│   ├── research-log.md      # Session-by-session research diary
│   ├── research-backlog.md  # Prioritised research agenda
│   └── domain-context.md    # Current understanding & gaps
├── _templates/      # Note templates
├── .gitignore
└── README.md
```

## Technical Setup

### Prerequisites
- Git for Windows (includes Git Bash)
- Claude Code
- Obsidian

### Initial Vault Setup

Run: `setup-vault.sh [vault-name]`

This creates:
- Vault directory structure
- Git repository with appropriate .gitignore
- Templates for different note types
- Progress tracking files (research-log.md, research-backlog.md)
- README with usage guide

The setup script:
1. Creates folder structure
2. Initializes git
3. Creates progress tracking files
4. Creates templates
5. Makes initial commit

### Version Control Workflow

After each research session, assistant commits:
```bash
git add .
git commit -m "Research: [Topic] - [X] sources, [Y] concepts"
```

User can optionally connect to GitHub for backup:
```bash
git remote add origin https://github.com/username/research-vault.git
git push -u origin main
```

### Progress Tracking

Research progress is tracked in markdown files within `_meta/`:

**`_meta/research-log.md`** - Session diary (chronological)
- What you explored
- Key findings
- Questions that emerged
- Next steps

**`_meta/research-backlog.md`** - Research agenda (prioritised)
- High/Medium/Low priority items
- Completed items for reference

**Example research log entry:**
```markdown
### 2026-02-22 - Event Streaming Research

**Explored:**
- Kafka vs Pulsar architecture comparison
- Event sourcing patterns

**Key findings:**
- Kafka better for high-throughput scenarios
- Pulsar has built-in tiered storage

**Questions:**
- How does Schema Registry fit in?

**Next:**
- Deep dive on exactly-once semantics
```

**Viewing progress:**
```
"Summarize my progress this week"
"What's on my research backlog?"
```

**Questions** are tracked as notes in `/questions/*.md` for full context and linking to concepts.

## Quality Standards

### Every Note Should Have
- Clear, descriptive title
- YAML frontmatter (date, tags, type)
- At least 2 wikilinks to other notes
- Source attribution where appropriate
- Written for someone new to the topic

### Vault Health Indicators
✅ Good signs:
- Dense connection network (most notes linked)
- Balance across note types
- Clear navigation via MOCs
- Recent research log updates
- Few orphaned notes (<10%)

⚠️ Warning signs:
- Many orphaned notes
- Long notes (>500 words - consider splitting)
- Vague titles
- Missing citations
- No MOCs

## How the Assistant Learns the Domain

The assistant doesn't have persistent memory, but builds domain understanding through:

1. **Reading existing vault content** before creating new notes
2. **Checking research log** for context on what's been explored
3. **Following link structure** to understand concept relationships
4. **Reviewing domain-context.md** which captures key themes and gaps

Each research session builds on previous work, creating an accumulating knowledge base that informs future research.

## Success Metrics

User reports:
- "I'm seeing connections I hadn't thought of"
- "This saves me hours of manual linking"
- "The structure helps me think more clearly"
- "I can find things easily in my vault"

NOT:
- "It wrote my dissertation for me"
- "I just accept everything it generates"

The assistant should coach better thinking, not replace thinking.

## Current Research Domain

**This section gets updated as the project progresses**

**Focus Area:** [To be defined by user]

**Key Concepts Mapped:** [None yet]

**Authoritative Sources Identified:** [None yet]

**Open Questions:** [None yet]

**Research Gaps:** [None yet]
