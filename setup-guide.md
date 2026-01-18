# Thoth Lite Setup Guide

Thoth Lite is a streamlined "Chief of Staff" configuration for OpenCode. It brings the core disciplined thinking of the Thoth system—Truth Hierarchy, Smart Merge, and Intent Gating—without the complexity of deep recursion prompts.

## 1. Installation

### Set up the Agent
1.  Navigate to the root of your workspace (or Knowledge Base).
2.  Copy `AGENTS.md` from this folder to your workspace root.
    ```bash
    cp thoth-lite/AGENTS.md ./AGENTS.md
    ```

### Set up Skills
Thoth relies on **Skills** for complex workflows. OpenCode looks for skills in `.opencode/skill/`.

1.  Create the skill directory:
    ```bash
    mkdir -p .opencode/skill
    ```

2.  Install recommended skills. You can copy them or symlink them from `thoth-core/defaults/skill`.

    **Recommended Core Skills:**
    *   `morning-boot`: For day planning and context synthesis.
    *   `context-discovery`: For user identity resolution.

    **Example (Symlinking for local dev):**
    ```bash
    # Assuming you are in your workspace root and thoth-core is a sibling directory
    cd .opencode/skill
    ln -s ../../thoth-core/defaults/skill/morning-boot morning-boot
    ln -s ../../thoth-core/defaults/skill/context-discovery context-discovery
    ```

    **Example (Copying for standalone):**
    ```bash
    cp -r path/to/thoth-core/defaults/skill/morning-boot .opencode/skill/
    cp -r path/to/thoth-core/defaults/skill/context-discovery .opencode/skill/
    ```

## 2. Knowledge Base Structure

Thoth uses **Index-First Navigation**. It expects a structured file system to find information efficiently without scanning thousands of files.

**Recommended Structure:**

```text
.
├── AGENTS.md                 # The brain (you just copied this)
├── _index.md                 # Root index listing top-level domains
├── work/
│   ├── _index.md             # Index of active projects/areas
│   ├── projects/
│   │   ├── _index.md
│   │   └── project-alpha.md
│   └── operations/
├── life/
│   ├── _index.md
│   └── finance/
└── kernel/
    ├── _index.md
    └── memory/               # Where Thoth stores learned facts
```

### The `_index.md` Protocol
Every folder should have an `_index.md` file that lists its contents and a brief summary.

**Example `work/_index.md`:**
```markdown
# Work Index

| Name | File | Status | Summary |
|------|------|--------|---------|
| Project Alpha | projects/project-alpha.md | Active | Q1 API migration |
| Operations | operations/_index.md | Ongoing | Hiring and Finance |
```

## 3. Core Protocols

### Smart Merge
Thoth is trained **NOT** to append information blindly. When you ask Thoth to "update the project file," it will:
1.  Read the file.
2.  Reword the relevant section to include the new fact.
3.  Ensure the document reads as a single, coherent narrative.

**Why?** This prevents files from becoming "chat logs" of appended updates. The file always represents the *current truth*.

### Truth Hierarchy
Thoth trusts files above all else. If you want Thoth to "know" something permanently:
*   **Don't** just say it in chat.
*   **Do** ask Thoth to "record this in [Filename]".

## 4. Usage

Start a session and ask:
*   "Plan my day" (Triggers `morning-boot` skill)
*   "Update the project alpha status" (Uses Smart Merge)
*   "Who are the stakeholders for Project X?" (Uses Index-First Navigation)
