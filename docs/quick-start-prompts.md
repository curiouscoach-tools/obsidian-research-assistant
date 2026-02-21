# Quick Start Prompts - Getting Your Research Assistant Up to Speed

When you first open Claude Code in your new research vault, use these prompts to quickly orient the assistant and start productive research.

## First Session: Introduce Your Research

### Step 1: Set the Context

Copy and paste this prompt, filling in your specifics:

```
I'm using you as a research assistant for my [dissertation/work project/personal learning] on [topic]. 

My research focus is: [1-2 sentence description]

My main questions are:
- [Question 1]
- [Question 2]
- [Question 3]

I need you to help me:
1. Build systematic knowledge through structured notes
2. Identify and process authoritative sources
3. Make connections between concepts
4. Track my progress

Please read the CLAUDE.md file in this vault and confirm you understand the research focus.
```

**Example:**
```
I'm using you as a research assistant for my master's dissertation on sustainable transport planning.

My research focus is: Understanding how transit-oriented development policies affect housing affordability in medium-density urban areas.

My main questions are:
- What are the key principles of transit-oriented development?
- How do TOD policies interact with housing markets?
- What are successful case studies of TOD implementation?

I need you to help me:
1. Build systematic knowledge through structured notes
2. Identify and process authoritative sources
3. Make connections between concepts
4. Track my progress

Please read the CLAUDE.md file in this vault and confirm you understand the research focus.
```

### Step 2: Start Your First Research

Use one of these patterns:

**Pattern A: Topic Overview**
```
Research the fundamentals of [topic]. I need:
- Core concepts and definitions
- 3-5 authoritative sources
- An initial map of the knowledge domain
- Identification of key sub-topics I should explore next

Create structured notes following the vault templates.
```

**Pattern B: Specific Question**
```
I need to understand: [specific question]

Please:
1. Find authoritative sources that address this question
2. Create concept notes for key ideas
3. Build a map of content showing how these concepts relate
4. Identify gaps or contradictions in the literature
```

**Pattern C: Source Processing**
```
I've downloaded a paper about [topic] and placed it in sources/raw/.

Please:
1. Extract the main arguments and findings
2. Create a structured source note
3. Identify key concepts and create concept notes
4. Link these concepts to existing knowledge in the vault
5. Note any questions this raises for further research
```

## Common Follow-Up Prompts

### Exploring Connections
```
How does [concept A] relate to [concept B]? Create a synthesis note explaining their relationship.
```

### Identifying Gaps
```
Based on what we've researched so far, what are the main gaps in my knowledge about [topic]?
```

### Creating Questions
```
I'm seeing contradictory information about [topic]. Document this as a research question with all the context you've gathered.
```

### Checking Vault Health
```
Check the vault health:
- Are there any orphaned notes (not linked to anything)?
- Which concepts need more development?
- What areas have good coverage vs thin coverage?
```

### Progress Summary
```
Summarize my research progress over the last [week/2 weeks/month] for my supervisor meeting. Include:
- Key breakthroughs (wins)
- Research activity (sources processed, concepts mapped)
- Current blockers
- Suggested next steps
```

## Handling Common Situations

### When Web Fetch Fails (403 Error)
```
The web fetch failed for [URL]. I'll download it manually and add to sources/raw/.

For now, please create a source note stub with:
- Citation information
- URL for reference
- Tag it #needs-content so I can process it later
```

### Academic Integrity: Verification Workflow
```
This is dissertation research. For any claims you make:
- Mark unverified information with #verify tags
- Use [needs citation] for claims from general knowledge
- Only create source notes for papers I've provided or you've fetched
- Never fabricate quotes - if you haven't seen the exact text, don't quote it

If you're unsure about something, say "I don't know" rather than guess.
```

### Checking Verification Status
```
Review the notes created in this session:
- Which claims are marked #verify or #needs-citation?
- Are there any source notes for papers we haven't actually read?
- What needs my verification before I can use it in my dissertation?
```

### When You Have PDFs to Process
```
I've added 3 papers to sources/raw/ about [topic]:
1. [filename1.pdf]
2. [filename2.pdf]
3. [filename3.pdf]

Please process them one by one, creating source notes and extracting key concepts.
```

### When Starting a New Theme
```
I'm moving into a new area of research: [theme/topic]

Please:
1. Identify foundational concepts I should understand first
2. Suggest authoritative sources to start with
3. Create a Map of Content to organize this theme
4. Show how this connects to what I've already researched
```

### When Preparing for a Meeting
```
I have a supervisor meeting tomorrow. Generate a progress report covering:
- What I've researched (topics, sources, concepts)
- Key insights and breakthroughs
- Current questions and blockers
- Proposed next steps

Keep it concise - 1 page maximum.
```

## Daily Workflow Prompts

### Starting a Research Session
```
I have 2 hours to research [topic]. Help me plan:
1. What should I focus on first?
2. What are 2-3 sources I should find and process?
3. What concepts should I aim to understand by end of session?
```

### Ending a Research Session
```
Research session complete. Please:
1. Log this session to BlogLog (what we covered, key findings)
2. Commit changes to git with a descriptive message
3. Suggest what I should research next time
4. Identify any loose ends that need follow-up
```

## Tips for Effective Prompts

**Be Specific**
❌ "Research agile"
✅ "Research the core principles of agile transformation, focusing on why organizations adopt agile and common implementation challenges"

**State Your Intent**
❌ "Tell me about X"
✅ "I need to understand X so I can [evaluate/compare/apply] it to Y"

**Request Structure**
❌ "Find sources on X"
✅ "Find 3-5 authoritative sources on X and create structured source notes with concept extraction"

**Leverage Context**
❌ "What are the main concepts?"
✅ "Based on the sources we've processed so far, what are the main concepts I should understand about X?"

**Be Explicit About Deliverables**
❌ "Research transit planning"
✅ "Research transit planning and create: 5 concept notes, 2 source notes, 1 Map of Content, and identify 3 questions for further investigation"

## When Things Don't Work

### Assistant Seems Lost
```
Let's reset. Please:
1. Read the CLAUDE.md file
2. Review the existing vault structure (what notes exist)
3. Check the research log in _meta/
4. Tell me what you understand about this research project
```

### Notes Aren't Linking Properly
```
Review the last 5 concept notes you created. For each:
- Ensure it links to at least 2 other notes
- Check that links are meaningful (not just keyword matches)
- Add any missing connections you identify
```

### Too Generic or Surface Level
```
That's too high-level. I need deeper analysis. Please:
- Use more authoritative sources (academic papers, not blog posts)
- Extract more specific concepts with detailed definitions
- Identify debates and competing perspectives
- Note methodology and evidence quality
```

## Detailed Worked Examples

These examples show complete interaction patterns from start to finish.

### Example 1: Academic Dissertation Research (Caitlyn's Transport Planning)

**Context:** Master's dissertation on sustainable transport planning, needs academic rigor.

**Session 1: Getting Started**

```
cd ~/vaults/transport-dissertation
laura

You: Read CLAUDE.md to understand this research project. This is my 
     master's dissertation on transit-oriented development and housing 
     affordability, so I need peer-reviewed academic sources.
     
     Start by researching the fundamentals of transit-oriented development.

Laura: I've read CLAUDE.md and understand this is academic research requiring 
       peer-reviewed sources. I'll research transit-oriented development 
       fundamentals, prioritizing academic journals and systematic reviews.
       
       [Creates 5 concept notes, 3 source notes from peer-reviewed journals]
       [Logs: bl note "Research session: TOD fundamentals - 5 concepts, 3 academic sources"]

You: Great! Now I'm seeing the term "density bonus" mentioned. What does 
     that mean and how does it relate to TOD?

Laura: [Creates concept note on density bonuses]
       [Links to existing TOD notes]
       [References academic sources that discuss the relationship]

You: I found this paper on TOD implementation in Vancouver (shows PDF). 
     Can you process it?

Laura: I'll extract the key findings and create a structured source note.
       
       [Note: You'd place PDF in sources/raw/ first]
       [Creates source note with full academic citation]
       [Extracts 4 new concepts]
       [Links to existing TOD and density bonus notes]
```

**Session 2: Deepening Understanding (Next Day)**

```
laura

You: What did we cover yesterday on TOD?

Laura: [Reads research log and timeline]
       Yesterday we established foundational understanding of transit-oriented 
       development, created 5 concept notes covering TOD principles, walkability, 
       density bonuses, mixed-use development, and station area planning. We 
       processed 3 peer-reviewed sources.

You: Good. I'm seeing contradictory information about optimal density 
     levels for TOD. Document this as a research question.

Laura: [Creates question note in /questions/]
       Question: "What are optimal density levels for transit-oriented development?"
       Context: Sources disagree - some suggest 30+ units/acre, others 60+
       [Links to conflicting sources]
       [Notes: This needs resolution through literature review]
       [Logs: bl note "Generated research question: TOD density levels"]

You: Help me find recent systematic reviews or meta-analyses on TOD effectiveness.

Laura: [Searches for academic systematic reviews]
       [Prioritizes Cochrane-style reviews, meta-analyses]
       [Creates source notes with methodology assessment]
```

**Session 3: Verification Before Supervisor Meeting**

```
laura

You: Before my supervisor meeting, I need to check my notes are properly verified.
     Review all notes created this week and flag anything that:
     - Has #verify tags still unresolved
     - Contains claims I need to check against original sources
     - Has quotes I should verify against the actual papers

Laura: [Reviews notes]
       Verification audit for supervisor meeting:

       Unresolved #verify tags: 3
       - [[density-thresholds]] - claim about 60 units/acre needs source check
       - [[tod-effectiveness]] - statistic needs page number
       - [[housing-prices]] - percentage change needs verification

       Quotes to verify: 2
       - [[smith-2020-tod]] - quote on p.47 should be confirmed
       - [[jones-2022-density]] - paraphrased, not direct quote

       Source notes without full access: 1
       - [[chen-2023-review]] - stub only, needs full paper processing

       Recommendation: Verify these 6 items before citing in dissertation work.

You: Good. Now I have my supervisor meeting tomorrow. Summarize my research progress
     over the last 2 weeks.

Laura: [Reads .bloglog/timeline.json]
       
       Research Progress Summary (Last 2 Weeks):
       
       Topics Covered:
       - Transit-oriented development fundamentals (10 concept notes)
       - Housing affordability relationships (6 concept notes)
       - Policy frameworks (4 concept notes)
       
       Sources Processed: 12 peer-reviewed journal articles
       - 3 systematic reviews
       - 7 empirical studies
       - 2 theoretical frameworks
       
       Key Findings:
       - Strong evidence for TOD reducing car dependency
       - Mixed evidence on housing affordability impacts
       - Context matters: implementation varies by governance model
       
       Open Questions:
       - Optimal density levels (contradictory evidence)
       - Gentrification vs. accessibility tradeoff
       - Long-term vs. short-term affordability impacts
       
       Next Steps Recommended:
       - Systematic review of affordability evidence
       - Case study comparison across contexts
       - Stakeholder interview preparation
```

---

### Example 2: Professional Work Research (Your Brother's Industry Analysis)

**Context:** Business analyst researching market entry strategy, needs speed over academic rigor.

**Session 1: Fast Industry Research**

```
cd ~/vaults/market-entry-analysis
laura

You: Read CLAUDE.md. This is professional work research for a client 
     presentation next week. Industry reports and expert blogs are fine - 
     I need breadth and speed more than academic rigor.
     
     Research the European fintech regulatory landscape.

Laura: Understood - professional context, industry sources acceptable.
       I'll prioritize analyst reports (Gartner, Forrester), regulatory 
       bodies, and reputable fintech publications.
       
       [Creates concept notes from McKinsey reports, EU regulatory docs]
       [Notes source types: "industry report" vs "government document"]
       [Focuses on recent publications - last 2 years]

You: What are the key regulatory differences between UK and EU post-Brexit?

Laura: [Synthesizes from multiple industry sources]
       [Creates comparison note]
       [Links to regulatory framework concepts]
       [Flags: "Check official FCA and EU sources for legal accuracy"]

You: I need 3-5 case studies of successful fintech market entries in Europe.

Laura: [Searches for case studies in industry publications]
       [Creates source notes for each case study]
       [Extracts success factors as concept notes]
       [Creates comparison matrix]
```

**Session 2: Client Presentation Prep**

```
laura

You: I need to explain "open banking" to non-technical stakeholders. 
     Create a simple explanation.

Laura: [Reviews existing concept note]
       [Simplifies technical language]
       [Adds real-world examples]
       [Links to case studies showing business impact]

You: Build me a summary of market entry barriers - regulatory, technical, 
     and competitive. I'll use this in my presentation.

Laura: [Synthesizes across sources]
       [Organizes by category]
       [Includes specific examples from case studies]
       [Notes which barriers are highest priority based on research]
```

---

### Example 3: Your ODIE Platform Design (Multi-Persona Solo Work)

**Context:** You're designing a streaming platform, using multiple personas to challenge your thinking.

**Session 1: Research Phase**

```
cd ~/vaults/odie-platform
laura

You: Read CLAUDE.md. This is a technical programme design exercise. 
     I need to understand event streaming platforms - Kafka, Pulsar, 
     AWS Kinesis. Professional sources are fine but I want depth on 
     architecture and operations.
     
     Research event streaming platform options.

Laura: [Researches from vendor docs, architecture blogs, case studies]
       [Creates concept notes on event streaming, pub/sub, exactly-once semantics]
       [Source notes from Confluent, Apache, AWS documentation]
       [Creates comparison matrix showing strengths/weaknesses]
       [Logs: bl note "Research: Event streaming platforms - 8 concepts, 5 sources"]
```

**Session 2: Architecture Decisions**

```
alex

You: Read CLAUDE.md to understand this is an enterprise streaming platform.
     
     Based on Laura's research, evaluate Kafka vs Pulsar for our use case.

Alex: [Reads Laura's research notes]
      I see Laura researched both platforms. Let me create a systematic evaluation.
      
      [Creates technology comparison matrix in /architecture/comparisons/]
      [Scores against criteria: performance, ops complexity, ecosystem, cost]
      [Creates ADR-001: Event Streaming Platform Selection]
      [Links to Laura's concept notes for technical details]
      [Identifies risks: Kafka operational complexity, team skill gaps]
      [Logs: bl win "Decided on Kafka for event streaming platform"]

You: What are the biggest risks with this Kafka decision?

Alex: [Creates risk assessment in /architecture/risks/]
      Top risks:
      1. Operational complexity - team lacks Kafka experience
      2. Schema evolution - need robust governance
      3. Cost at scale - licensing and infrastructure
      
      Mitigations:
      - Training plan for team
      - Spike on schema registry
      - Proof of concept on cost modeling
      
      [Flags for Morgan: Need DevOps support for K8s deployment]
```

**Session 3: Sanity Check**

```
laura

You: Review Alex's architecture decision on Kafka. Are there any concerns 
     from the research that Alex might have missed?

Laura: [Reads Alex's ADR]
       [Cross-references with research notes]
       
       Alex's decision looks sound and well-reasoned. A few additional 
       considerations from the research:
       
       - The case study from [Source] noted governance overhead was 
         significant - make sure that's in the risk assessment
       - [Source] mentioned Kafka's learning curve - Alex flagged this 
         but might want to quantify training time
       - Consider data retention costs - not mentioned in ADR
       
       [Creates discussion note linking Alex's ADR and research findings]
```

This shows how **personas challenge each other** even when you're solo.

---

### Example 4: Processing Multiple Papers (Caitlyn's Literature Review)

**Context:** Weekend literature review blitz, processing multiple papers.

```
laura

You: I've downloaded 8 papers on TOD and housing affordability and put 
     them in sources/raw/. Process them one by one, prioritizing the 
     most recent systematic reviews first.

Laura: I'll process these papers in priority order. Let me start with 
       systematic reviews.
       
       [Scans sources/raw/]
       Found:
       - 2 systematic reviews (2023, 2021)
       - 4 empirical studies (2020-2024)
       - 2 theoretical papers (2019, 2022)
       
       Processing systematic review 1: [Author, 2023]...
       [Creates source note with full citation]
       [Extracts methodology: "Systematic review of 45 studies, 2010-2022"]
       [Notes key finding: "Mixed evidence on affordability - context dependent"]
       [Creates/updates 6 concept notes]
       [Logs: bl note "Processed systematic review: [Author 2023] - 6 concepts"]
       
       Processing systematic review 2: [Author, 2021]...
       [Similar process]
       
       Processing empirical study 1: [Author, 2024]...
       [Notes methodology: "Case study, 3 cities, mixed methods"]
       [Identifies limitation: "Small sample, UK-specific"]
       [Cross-references findings with systematic reviews]
       
       ...continues for all 8 papers...
       
       Summary:
       - Processed 8 academic sources
       - Created 12 new concept notes
       - Updated 8 existing concepts
       - Identified 3 contradictions requiring further investigation
       - Added 47 cross-references between notes
       
       [Logs: bl win "Completed literature review processing - 8 papers, 12 concepts"]

You: Are there any major contradictions I need to resolve?

Laura: Yes, three main contradictions emerged:
       
       1. Density thresholds: [Author A] suggests 60+ units/acre minimum,
          [Author B] shows success at 30-40 units/acre
          → See [[question-optimal-density-tod]]
       
       2. Affordability timeframe: [Author C] finds short-term price increases,
          [Author D] shows long-term affordability benefits
          → Different methodology and timeframes
       
       3. Governance models: [Author E] emphasizes top-down planning,
          [Author F] shows bottom-up community-led success
          → May be context-dependent (political systems)
       
       I've created question notes for each contradiction.
```

---

## Why These Examples Matter

**Example 1 (Academic)** shows:
- How to establish academic context
- Multi-session continuity
- Progress reporting for supervisors
- Research question management

**Example 2 (Professional)** shows:
- Speed over perfection
- Industry sources acceptable
- Client deliverable focus
- Practical timeframes

**Example 3 (Multi-Persona)** shows:
- Laura researches, Alex decides
- Cross-persona checking
- Solo work with multiple perspectives
- How personas build on each other

**Example 4 (Batch Processing)** shows:
- Handling multiple sources efficiently
- Systematic review prioritization
- Contradiction identification
- Literature review workflow

These give users **concrete patterns to copy**, not just abstract guidance.

**For Academic Research:**
Focus on: literature reviews, theoretical frameworks, methodology, evidence quality

**For Professional/Work Research:**
Focus on: practical applications, case studies, best practices, implementation challenges

**For Personal Learning:**
Focus on: progressive understanding (basics → advanced), practical examples, hands-on applications

## Remember

The assistant works best when you:
1. **Provide clear direction** - what you want to understand and why
2. **Build progressively** - foundations before advanced topics
3. **Review and guide** - check the notes created and refine as needed
4. **Use the structure** - leverage templates, links, and Maps of Content
5. **Track progress** - use BlogLog to see your research journey

The assistant handles structure and connections so you can focus on thinking and understanding.
