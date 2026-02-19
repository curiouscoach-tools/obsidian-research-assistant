# Laura - AI Research Assistant for Obsidian

**L**ovable **A**rtificially-intelligent **U**nflappable **R**esearch **A**ssistant

Meet Laura, your AI-powered research companion that helps you build structured, connected knowledge bases in Obsidian using Claude Code.

## What Laura Does

Laura transforms research from overwhelming to systematic:

- **Research any topic** → She creates structured concept notes, source notes, and maps of content
- **Process academic papers** → She extracts key findings, methodology, and creates proper citations
- **Build connections** → She links concepts together, showing relationships and gaps
- **Track progress** → She logs your research journey and generates progress reports
- **Maintain rigor** → She prioritizes peer-reviewed sources for academic work, adapts for professional contexts

**The result:** A connected knowledge base you own completely, ready to write from.

## Philosophy

**AI augmentation, not automation.**

Laura doesn't write your dissertation or make your decisions. She handles the scaffolding - the structure, the connections, the organisation - so you can focus on thinking and understanding.

The knowledge base is yours. The insights are yours. The writing is yours. Laura just makes sure you're working from a solid foundation.

## Who It's For

**Graduate students** building dissertation knowledge with academic rigor

**Professional researchers** getting up to speed fast in unfamiliar domains  

**Knowledge workers** doing deep research for work projects

**Lifelong learners** building systematic understanding of complex topics

Anyone who wants AI to help them think, not just answer questions.

## Quick Start

### 1. Install Prerequisites

**Required:**
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (for BlogLog)
- [Obsidian](https://obsidian.md/)
- [Claude Code](https://claude.ai/code)
- [BlogLog](https://github.com/IanSimon23/bloglog)

See [Installation Guide](docs/installation.md) for detailed instructions.

### 2. Clone This Repository

```bash
cd ~/projects
git clone https://github.com/yourusername/obsidian-research-assistant.git
cd obsidian-research-assistant
```

### 3. Install the Research Skill

**Linux/macOS/WSL:**
```bash
mkdir -p ~/.claude/skills/obsidian-research
cp skills/obsidian-research/SKILL.md ~/.claude/skills/obsidian-research/
```

**Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\obsidian-research"
Copy-Item -Path "skills\obsidian-research\SKILL.md" -Destination "$env:USERPROFILE\.claude\skills\obsidian-research\" -Force
```

### 4. Create a Research Vault

**Linux/macOS/WSL:**
```bash
./setup-vault.sh ~/vaults/my-research "My Research Project"
```

**Windows (PowerShell):**
```powershell
.\setup-vault.ps1 -VaultPath "$env:USERPROFILE\vaults\my-research" -VaultName "My Research Project"
```

The script will:
- Create the vault structure
- Install templates
- Initialize git
- Initialize BlogLog
- Create initial files

### 5. Open in Obsidian

File → Open folder as vault → Navigate to your vault → Open

### 6. Start Researching

**Meet Laura (optional but recommended):**
```bash
cd ~/vaults/my-research
laura  # Friendly launch with context
```

**Or launch directly:**
```bash
cd ~/vaults/my-research
claude
```

Then prompt: `"Research the fundamentals of [your topic]"`

**Install Laura:** See [Installing Laura](docs/installing-laura.md) for the friendly launcher.

## Key Features

✅ **Creates actual files** - Markdown notes in your Obsidian vault, not just chat responses  
✅ **Academic rigor** - Prioritizes peer-reviewed sources, proper citations, methodology notes  
✅ **Systematic connections** - Every note links to related concepts  
✅ **Progress tracking** - Built-in timeline and progress reporting  
✅ **Multi-persona support** - Add Alex (architecture), Riley (product), or other expert perspectives  
✅ **Cross-platform** - Windows, macOS, Linux/WSL  
✅ **You own everything** - All files local, no subscriptions, no lock-in  

## What's Different?

Most AI tools give you a conversation. Laura gives you **artifacts**.

She doesn't just answer "what is machine learning?" - she creates:
- `/concepts/machine-learning.md` with definition, context, examples
- `/concepts/supervised-learning.md` linked to ML
- `/concepts/neural-networks.md` linked to ML
- `/sources/goodfellow-2016-deep-learning.md` with full citation and key findings
- `/themes/ai-fundamentals.md` connecting all the concepts

Everything lives in your Obsidian vault. Everything connects. Everything is yours.

## How It Works

### Repository Structure (The Factory)

This repository contains the **tooling to create research vaults**:

```
obsidian-research-assistant/
├── laura                    # Friendly launcher (Linux/macOS/WSL)
├── laura.ps1                # Friendly launcher (Windows)
├── alex                     # Solution architect persona (Linux/macOS/WSL)
├── alex.ps1                 # Solution architect persona (Windows)
├── setup-vault.sh           # Creates vaults (Linux/macOS/WSL)
├── setup-vault.ps1          # Creates vaults (Windows PowerShell)
├── skills/
│   ├── obsidian-research/
│   │   └── SKILL.md        # Research methodology (install globally)
│   └── alex-architecture/
│       └── SKILL.md        # Architecture expertise (install globally)
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
You: "I need to understand quantum computing fundamentals"

Laura:
1. Clarifies scope if needed
2. Identifies 3-5 authoritative sources
3. Creates concept notes with definitions and relationships
4. Creates source notes with summaries and citations
5. Builds Map of Content as navigation hub
6. Logs progress to timeline
7. Commits to git
```

### Processing Sources

```
You: [Download PDF using university access]
You: "Process the quantum computing paper I added to sources/raw/"

Laura:
1. Extracts text from PDF
2. Creates structured source note with citation
3. Identifies key concepts (creates or updates concept notes)
4. Cross-references with existing knowledge
5. Flags contradictions
6. Logs significant findings
```

**Note:** Web fetching often fails for academic publishers (403 errors due to bot protection). The manual download workflow is more reliable and respects paywalls/access controls.

### Progress Reporting

```
You: "Summarize my progress for my supervisor meeting"

Laura:
1. Reads research timeline
2. Analyzes activity patterns
3. Generates summary:
   - Breakthroughs and key insights
   - Research activity (sources processed, notes created)
   - Active blockers
   - Suggested next steps
```

## Multi-Persona Support

Laura is a research assistant. But sometimes you need different perspectives:

**Alex** (Solution Architect) - Architecture decisions, technology evaluation, risk assessment

**Riley** (Product Owner) - User value, prioritization, product thinking *(coming soon)*

**More personas in development** - Or create your own expert perspectives

Each persona reads what the others have built and contributes their expertise to the same vault. See the demo video scripts for examples of Laura → Alex collaboration on technical investigations.

## Example Use Cases

### Academic Research
"Research the fundamentals of sustainable transport planning for my dissertation. I need peer-reviewed sources."

→ Laura creates 10 concept notes, 5 source notes from academic journals, 1 map of content

### Professional Investigation  
"I've been asked to evaluate data streaming platforms. Professional sources are fine."

→ Laura researches options, Alex evaluates tradeoffs, you present confidently

### Personal Learning
"Help me understand reinforcement learning - I'm a developer but new to ML."

→ Laura builds foundational concepts, connects to what you already know

## Features in Detail

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
- **Fallback:** Works even without BlogLog installed (writes to timeline.json directly)

### Connected Knowledge
- Every note links to related notes
- Graph view shows knowledge structure
- Maps of Content provide navigation
- Questions drive future research

### Quality Standards
- Structured templates ensure consistency
- Academic citation formats
- Source quality assessment
- Methodology notes for empirical research
- Link integrity checking

## Getting Started Quickly

**First prompt in your new vault:**
```
I'm researching [topic] for my [dissertation/project/learning].

My main questions are:
- [Question 1]
- [Question 2]

Please read CLAUDE.md and help me start building systematic knowledge.
```

**Then try:**
- `"Research the fundamentals of [topic]"` - Creates initial concept notes and sources
- `"Process the paper I added to sources/raw/"` - Structures a downloaded PDF
- `"Summarize my progress this week"` - Generates progress report

See [Quick Start Prompts](docs/quick-start-prompts.md) for comprehensive prompt library with detailed examples.

## Documentation

- [Installing Laura](docs/installing-laura.md) - Set up the friendly launcher command
- [Installation Guide](docs/installation.md) - Detailed setup instructions
- [Windows Quick Start](docs/windows-quick-start.md) - Windows-specific setup guide
- [Quick Start Prompts](docs/quick-start-prompts.md) - Copy-paste prompts with detailed worked examples
- [About This Project](CLAUDE-about-this-repo.md) - Project vision and philosophy
- [Research Skill](skills/obsidian-research/SKILL.md) - The methodology Claude Code uses
- [Demo Video Scripts](docs/) - Scripts for creating demo videos

## Real-World Use

Built for and tested with:
- **Graduate student** - Dissertation on urban planning (academic rigor)
- **Business analyst** - Market research for client presentation (speed and breadth)
- **Product manager** - Technical domain onboarding (multi-perspective thinking)
- **Personal learning** - Historical research revisiting undergraduate dissertation topics

The same methodology works across domains: academic, professional, personal.

## Project Status

**v1.0 - Production Ready**

Laura is ready for academic and professional research. Multi-persona support (Alex) is functional. Additional personas (Riley, Morgan, etc.) are in development.

## CuriousCoach Tools

This is part of the [CuriousCoach](https://curiouscoach.tools) suite of AI coaching tools:
- **Obsidian Research Assistant** - Enables deeper thinking through structured knowledge
- **Jironaut** - Coaches better ticket writing
- **Worthsmith** - Coaches value-focused thinking
- **STAR Coach** - Coaches interview preparation
- **The Writing Gym** - Coaches structured writing

All tools share a philosophy: **AI coaches thinking, doesn't replace it**.

## Contributing

Issues and pull requests welcome! Areas for improvement:
- Additional persona templates (tech lead, business analyst, etc.)
- Additional note templates
- More workflow patterns for specific research types
- Integration with other tools
- Platform-specific optimizations

## License

MIT License - see LICENSE file

## Credits

Created by [Ian Simon](https://github.com/IanSimon23) as part of the CuriousCoach tools portfolio.

Built on:
- [Obsidian](https://obsidian.md/) - Knowledge base application
- [Claude Code](https://claude.ai/code) - AI coding assistant  
- [BlogLog](https://github.com/IanSimon23/bloglog) - Activity timeline tool

---

**Laura: Research smarter, not harder.**

