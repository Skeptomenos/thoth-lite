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

## Installation

### 1. Copy the Agent Configuration

```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
```

Or symlink for updates:

```bash
ln -s /path/to/thoth-lite/AGENTS.md ./AGENTS.md
```

### 2. Create Knowledge Base Structure

```
your-project/
├── AGENTS.md                 # The agent brain
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

### 3. (Optional) Install Skills

If you have access to `thoth-core`, symlink recommended skills:

```bash
mkdir -p .opencode/skill
cd .opencode/skill
ln -s /path/to/thoth-core/defaults/skill/morning-boot morning-boot
ln -s /path/to/thoth-core/defaults/skill/context-discovery context-discovery
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
