# thoth-lite

A streamlined "Chief of Staff" configuration for [OpenCode](https://opencode.ai). Brings disciplined AI assistance for knowledge management without the complexity of the full Thoth system.

## What is This?

thoth-lite transforms OpenCode into a proactive executive partner that manages your priorities, projects, and knowledge. It is **not** a coding agent—it refuses to write code and instead focuses on:

- Knowledge management
- Project planning and tracking
- Communication orchestration
- Life and work organization

## Core Principles

| Principle | Description |
|-----------|-------------|
| **Anticipate** | Surfaces gaps and risks proactively |
| **Challenge** | Partner, not servant—pushes back on flawed plans |
| **Grounding** | Claims nothing without file-based evidence |
| **Brevity** | No fluff. "German understatement." |

---

## Installation

### Quick Start

```bash
# Clone thoth-lite
git clone https://github.com/Skeptomenos/thoth-lite.git

# Copy agent config to your knowledge base
cp thoth-lite/AGENTS.md /path/to/your/kb/AGENTS.md

# Install required skills
./thoth-lite/install-skills.sh /path/to/your/kb
```

### Manual Installation

#### 1. Copy Agent Configuration

```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
```

Or symlink for updates:

```bash
ln -s /path/to/thoth-lite/AGENTS.md ./AGENTS.md
```

#### 2. Install Skills

thoth-lite requires skills from [Skeptomenos/skills](https://github.com/Skeptomenos/skills).

```bash
# Navigate to your knowledge base root
cd /path/to/your/kb

# Create skills directory and install all skills
mkdir -p .opencode/skill
git clone https://github.com/Skeptomenos/skills.git /tmp/skills-repo
cp -r /tmp/skills-repo/skills/* .opencode/skill/
rm -rf .opencode/skill/_templates
rm -rf /tmp/skills-repo
```

#### 3. Create Knowledge Base Structure

```
your-kb/
├── AGENTS.md                 # The agent brain
├── .opencode/
│   └── skill/                # All skills from Skeptomenos/skills
│       ├── knowledge-capture/
│       ├── cross-linker/
│       ├── gardener/
│       ├── morning-boot/
│       ├── mail-triage/
│       ├── ... (17 skills total)
│       └── evening-close/
├── _index.md                 # Root index
├── work/
│   ├── _index.md
│   └── projects/
│       └── _index.md
├── life/
│   └── _index.md
└── kernel/
    └── _index.md
```

Every folder needs an `_index.md` file:

```markdown
# Work Index

| Name          | File                      | Status | Summary          |
|---------------|---------------------------|--------|------------------|
| Project Alpha | projects/project-alpha.md | Active | Q1 API migration |
```

---

## Skills

thoth-lite is powered by skills from [Skeptomenos/skills](https://github.com/Skeptomenos/skills). The install script copies all relevant skills to your knowledge base.

### Knowledge Management (Core)

| Skill | Purpose |
|-------|---------|
| **knowledge-capture** | Extract entities (people, projects, decisions) from conversation and persist to structured files |
| **cross-linker** | Discover and create `[[wikilinks]]` between KB files with evidence-based confidence tiers |
| **gardener** | Maintain KB health: audit indexes, fix broken links, detect orphans, suggest promotions |
| **domain-discovery** | Breadth-first interviewing to map new domains before diving deep |

### Daily Operations

| Skill | Purpose |
|-------|---------|
| **morning-boot** | Daily briefing orchestrator: parallel scan of email/calendar, synthesize priorities |
| **evening-close** | Day summary: extract incomplete tasks, persist learnings, prepare tomorrow's overflow |
| **cal-grid** | Map the daily calendar grid identifying meetings, deep work slots, and prep needs |
| **mail-triage** | Exhaustively drain inbox, classify messages, detect meeting notes for handoff |

### Communication

| Skill | Purpose |
|-------|---------|
| **email-draft** | Draft professional emails and replies via Gmail |
| **slack-pulse** | Scan Slack for mentions, DMs, and high-value channel activity |
| **post-meeting-drill** | Deep processing of meeting notes with entity resolution and knowledge persistence |

### Leadership & Hiring

| Skill | Purpose |
|-------|---------|
| **leadership-coach** | IC-to-Manager coaching for leadership challenges, 1:1 prep, performance conversations |
| **interview-prep** | Generate tailored interview questions from job description and resume |
| **scorecard-synthesis** | Synthesize hiring scorecards from interview transcripts with evidence |

### Meta / Tooling

| Skill | Purpose |
|-------|---------|
| **agents-md** | Audit and improve AGENTS.md files using progressive disclosure principles |
| **skill-generator** | Create new skills using TDD methodology for process documentation |
| **open-prose** | Run OpenProse programs for multi-agent orchestration |

### Skill Pipelines

```
domain-discovery → knowledge-capture → cross-linker → gardener
   (interview)        (persist)         (connect)     (maintain)
```

```
morning-boot ─────────────────────────────────────→ evening-close
  (start day)                                         (close day)
       │                                                   │
       ├── mail-triage                                     │
       ├── cal-grid                                        │
       └── slack-pulse                                     │
                                                           │
              post-meeting-drill ──────────────────────────┘
```

---

## Updating Skills

Run the install script again to update all skills:

```bash
./install-skills.sh /path/to/your/kb
```

Or manually:

```bash
cd /path/to/your/kb
rm -rf .opencode/skill
git clone https://github.com/Skeptomenos/skills.git /tmp/skills-repo
mkdir -p .opencode/skill
cp -r /tmp/skills-repo/skills/* .opencode/skill/
rm -rf .opencode/skill/_templates
rm -rf /tmp/skills-repo
```

## Protocols

### Truth Hierarchy

```
Files (Ground Truth) > User Statement > Web > Memory (Null)
```

Thoth never claims facts without citing file sources.

### Index-First Navigation

1. Read `_index.md`
2. Select specific file
3. Read file

Never scans directories blindly.

### Smart Merge

When writing files, Thoth:
1. Reads existing content
2. Weaves new info into the narrative
3. Maintains "current state" (not append-only logs)

## Domain Voices

| Domain | Voice | Style |
|--------|-------|-------|
| **WORK** | The Executive | Crisp, P0-focused, deadline-aware |
| **LIFE** | The Consultant | Warm, Socratic, values-aligned |

## What Thoth Won't Do

- **Write code** — It's the architect, not the bricklayer
- **Offer empty praise** — No sycophancy
- **Hallucinate** — If it's not in a file, it doesn't know
- **Skip navigation** — Always reads indexes first

## Related Projects

- **thoth-core** — Full OpenCode plugin with complete skill library
- **thoth-kb** — Example knowledge base structure

## License

MIT
