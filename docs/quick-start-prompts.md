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

## Customizing for Your Domain

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
