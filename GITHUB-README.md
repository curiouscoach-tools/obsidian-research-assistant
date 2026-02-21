# Laura - AI Research Assistant for Obsidian

**Meet Laura: Your Lovable, Artificially-intelligent, Unflappable Research Assistant**

Laura helps you build structured, connected knowledge bases in Obsidian using Claude Code. She's designed for anyone doing systematic research - whether that's a dissertation, professional investigation, or deep learning on a new topic.

## What Laura Does

Laura transforms research from overwhelming to systematic:

- **Research any topic** → She creates structured concept notes, source notes, and maps of content
- **Process academic papers** → She extracts key findings, methodology, and creates proper citations
- **Build connections** → She links concepts together, showing relationships and gaps
- **Track progress** → She logs your research journey and generates progress reports
- **Maintain rigor** → She prioritizes peer-reviewed sources for academic work, adapts for professional contexts

**The result:** A connected knowledge base you own completely, ready to write from.

## Quick Start

```bash
# Clone the repo
git clone https://github.com/curiouscoach-tools/obsidian-research-assistant.git
cd obsidian-research-assistant

# Create a research vault (installs personas automatically)
./setup-vault.sh ~/vaults/my-research "My Research Project"

# Start researching
cd ~/vaults/my-research
claude

# Then type /laura and prompt:
"Research [your topic]. This is my dissertation so I need academic sources."
```

Files appear in Obsidian immediately - structured, linked, ready to use.

## Who Is This For?

**Dissertation students** building systematic literature reviews

**Professional researchers** getting up to speed fast in unfamiliar domains

**Knowledge workers** building deep understanding of complex topics

**Anyone** who wants AI to help them think, not just answer questions

## Key Features

✅ **Creates actual files** - Markdown notes in your Obsidian vault, not just chat responses
✅ **Academic rigor** - Prioritizes peer-reviewed sources, proper citations, methodology notes
✅ **Academic integrity** - Never fabricates sources; marks unverified claims with `#verify` tags
✅ **Systematic connections** - Every note links to related concepts
✅ **Progress tracking** - Built-in timeline and progress reporting
✅ **Multi-persona** - Add Alex (architecture), Riley (product), or other expert perspectives
✅ **Cross-platform** - Windows, macOS, Linux/WSL
✅ **You own everything** - All files local, no subscriptions, no lock-in  

## What's Different?

Most AI tools give you a conversation. Laura gives you **artifacts**.

She doesn't just answer "what is transit-oriented development?" - she creates:
- `/concepts/transit-oriented-development.md` with definition, context, examples
- `/concepts/walkability.md` linked to TOD
- `/concepts/density-bonus.md` linked to TOD
- `/sources/smith-2020-tod-housing.md` with full citation and key findings
- `/themes/sustainable-transport.md` connecting all the concepts

Everything lives in your Obsidian vault. Everything connects. Everything is yours.

## Example Use Cases

### Academic Research
"Research the fundamentals of X for my dissertation. I need peer-reviewed sources."
→ Laura creates 10 concept notes, 5 source notes from academic journals, 1 map of content

### Professional Investigation  
"I've been asked to evaluate data streaming platforms. Professional sources are fine."
→ Laura researches options, Alex evaluates tradeoffs, you present confidently

### Personal Learning
"Help me understand machine learning - I'm a developer but new to ML."
→ Laura builds foundational concepts, connects to what you already know

## Requirements

- **Obsidian** - Note-taking app (free)
- **Claude Code** - AI coding assistant (free)
- **Git** - Version control (free)
- **BlogLog** - Optional, for timeline tracking

See [Installation Guide](docs/installation.md) for detailed setup.

## Documentation

- [Installation Guide](docs/installation.md) - Detailed setup for Windows/Mac/Linux
- [Windows Quick Start](docs/windows-quick-start.md) - Windows-specific guide
- [Quick Start Prompts](docs/quick-start-prompts.md) - Copy-paste prompts with detailed examples
- [Installing Laura](docs/installing-laura.md) - Set up the friendly launcher
- [About This Project](CLAUDE-about-this-repo.md) - Vision and philosophy

## Multi-Persona Support

Laura is a research assistant. But sometimes you need different perspectives:

**Alex** (Solution Architect) - Architecture decisions, technology evaluation, risk assessment

**Riley** (Product Owner) - User stories, value propositions, prioritisation

**More personas planned** - Or create your own expert perspectives

Each persona reads what the others have built and contributes their expertise to the same vault.

## The Philosophy

**AI augmentation, not automation.**

Laura doesn't write your dissertation or make your decisions. She handles the scaffolding - the structure, the connections, the organisation - so you can focus on thinking and understanding.

The knowledge base is yours. The insights are yours. The writing is yours.

Laura just makes sure you're working from a solid foundation.

## Real Users

Built for and tested with:
- **Graduate student** - Transport planning dissertation (academic rigor)
- **Professional analyst** - Market entry research (speed and breadth)
- **Product change manager** - Technical domain onboarding (multi-perspective thinking)

## Project Status

**v1.0 - Ready to use**

Laura is production-ready for academic and professional research. Multi-persona support (Alex, Riley, etc.) is functional but still evolving based on real-world use.

## Contributing

Issues and PRs welcome! Areas for contribution:
- Additional persona templates (tech lead, business analyst, etc.)
- More note templates
- Workflow patterns for specific research types
- Platform-specific optimizations

## License

MIT License - Use it however you want.

## Credits

Created by [Ian Simon](https://github.com/IanSimon23) as part of the CuriousCoach tools portfolio.

Built on:
- [Obsidian](https://obsidian.md/) - Knowledge base application
- [Claude Code](https://claude.ai/code) - AI coding assistant  
- [BlogLog](https://github.com/IanSimon23/bloglog) - Activity timeline tool

## Get Started

[Download the latest release](https://github.com/curiouscoach-tools/obsidian-research-assistant/releases) or clone this repo.

See [Installation Guide](docs/installation.md) for setup instructions.

Have questions? [Open an issue](https://github.com/curiouscoach-tools/obsidian-research-assistant/issues).

---

**Laura: Research smarter, not harder.**
