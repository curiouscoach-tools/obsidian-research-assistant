# Obsidian Research Assistant

An AI-powered research assistant that helps you build structured, connected knowledge bases in Obsidian using Claude Code.

## What It Does

Transform scattered research into a systematic knowledge base:
- **Conducts structured research** - Finds authoritative sources, extracts key concepts, creates cross-referenced notes
- **Builds knowledge systematically** - Works from foundations up, identifies gaps, suggests next directions
- **Maintains vault health** - Version control with git, progress tracking with BlogLog, consistent structure
- **Coaches thinking** - Helps identify connections, synthesize ideas, formulate questions

## Philosophy

This is **AI augmentation, not automation**:
- AI handles structure, linking, and source processing
- Human provides direction, critical thinking, and synthesis
- The vault becomes a thinking tool, not just storage
- Value comes from connections, not just information

## Who It's For

- **Postgraduate researchers** building dissertation knowledge
- **Knowledge workers** doing deep research for work projects
- **Lifelong learners** building understanding of complex topics
- Anyone who wants systematic research instead of scattered notes

## Quick Start

### 1. Install Prerequisites

See [Installation Guide](docs/installation.md) for detailed instructions.

**Required:**
- Git
- Node.js (for BlogLog)
- Obsidian
- Claude Code
- BlogLog

### 2. Clone This Repository

```bash
cd ~/projects
git clone https://github.com/yourusername/obsidian-research-assistant.git
cd obsidian-research-assistant
```

### 3. Install the Research Skill

```bash
mkdir -p ~/.claude/skills
cp skills/obsidian-research.md ~/.claude/skills/
```

### 4. Create a Research Vault

```bash
./setup-vault.sh ~/vaults/my-research "My Research Project"
```

### 5. Open in Obsidian

File → Open folder as vault → Navigate to your vault → Open

### 6. Start Researching

```bash
cd ~/vaults/my-research
claude-code
```

Then prompt: `"Research the fundamentals of [your topic]"`

## How It Works

### Repository Structure (The Factory)

This repository contains the **tooling to create research vaults**:

```
obsidian-research-assistant/
├── setup-vault.sh           # Creates new research vaults
├── skills/
│   └── obsidian-research.md # Research methodology (install globally)
├── templates/               # Note templates for vaults
│   ├── source-note.md
│   ├── concept-note.md
│   ├── question-note.md
│   └── map-of-content.md
├── config/                  # Configuration templates
│   ├── gitignore.template
│   ├── vault-readme.template
│   └── vault-claude.template
└── docs/
    └── installation.md      # Setup guide
```

### Created Vault Structure

When you run `setup-vault.sh`, it creates a **separate research vault**:

```
my-research/                 # Independent git repository
├── .bloglog/               # Progress tracking
├── sources/
│   ├── raw/               # Your PDFs (gitignored)
│   └── *.md               # Structured source notes
├── concepts/              # Individual concept explanations
├── themes/                # Maps of Content
├── questions/             # Open research questions
├── _meta/
│   ├── research-log.md
│   └── domain-context.md
├── _templates/            # Copied from factory
├── CLAUDE.md              # Project-specific context
└── README.md
```

Each vault is:
- A separate git repository (not related to the factory)
- Self-contained and portable
- Can be pushed to its own GitHub repo
- Contains all your research for one project

## Core Workflows

### Initial Research

```
You: "I need to understand transit-oriented development"

Claude Code:
1. Clarifies scope and depth needed
2. Identifies 3-5 authoritative sources
3. Creates concept notes with definitions and relationships
4. Creates source notes with summaries and citations
5. Builds Map of Content as navigation hub
6. Logs progress: bl note "Research session: TOD foundations"
7. Commits to git: "Research: TOD - 5 concepts, 2 sources"
```

### Processing Sources

```
You: [Download PDF using university access]
You: "Process the transport planning paper I added to sources/raw/"

Claude Code:
1. Extracts text from PDF
2. Creates structured source note with citation
3. Identifies key concepts (creates or updates concept notes)
4. Cross-references with existing knowledge
5. Flags contradictions
6. Logs: bl win "Key insight on X from Y paper"
```

### Progress Reporting

```
You: "Summarize my progress for my supervisor meeting"

Claude Code:
1. Reads .bloglog/timeline.json
2. Analyzes activity patterns
3. Generates summary:
   - Wins (breakthroughs)
   - Research activity (sources processed, notes created)
   - Active blockers
   - Next steps
```

## Features

### Version Control
- Every change tracked in git
- Full history of knowledge evolution
- Can roll back or branch research directions
- Optional GitHub backup

### Progress Tracking (BlogLog)
- Timeline of research activity
- Wins, progress notes, blockers
- Generate reports for meetings
- See research velocity

### Connected Knowledge
- Every note links to related notes
- Graph view shows knowledge structure
- Maps of Content provide navigation
- Questions drive future research

### Quality Standards
- Structured templates ensure consistency
- Link integrity checking
- Orphan detection
- Source attribution

## Examples

This system has been tested for:
- **Academic dissertation research** (transport planning)
- **Professional knowledge building** (agile transformation)
- **Work project research** (policy analysis, technical topics)

The same methodology works across domains.

## Documentation

- [Installation Guide](docs/installation.md) - Detailed setup instructions
- [About This Project](CLAUDE-about-this-repo.md) - Project vision and philosophy
- [Research Skill](skills/obsidian-research.md) - The methodology Claude Code uses

## CuriousCoach Tools

This is part of the [CuriousCoach](https://curiouscoach.tools) suite of AI coaching tools:
- **Jironaut** - Coaches better ticket writing
- **Worthsmith** - Coaches value-focused thinking
- **STAR Coach** - Coaches interview preparation
- **The Writing Gym** - Coaches structured writing
- **Obsidian Research Assistant** - Coaches systematic research

All tools share a philosophy: **AI coaches thinking, doesn't replace it**.

## Contributing

Issues and pull requests welcome! Areas for improvement:
- Additional note templates
- More workflow patterns
- Integration with other tools
- Platform-specific optimizations

## License

MIT License - see LICENSE file

## Credits

Created by Ian Simon as part of the CuriousCoach tools portfolio.

Built on:
- [Obsidian](https://obsidian.md/) - Knowledge base application
- [Claude Code](https://claude.ai/code) - AI coding assistant
- [BlogLog](https://github.com/IanSimon23/bloglog) - Activity timeline tool
