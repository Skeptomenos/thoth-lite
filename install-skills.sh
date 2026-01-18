#!/bin/bash
#
# install-skills.sh - Install thoth-lite skills to a knowledge base
#
# Usage: ./install-skills.sh /path/to/your/kb
#

set -e

SKILLS_REPO="https://github.com/Skeptomenos/skills.git"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: $0 <knowledge-base-path>"
    echo ""
    echo "Installs thoth-lite AGENTS.md and all skills to the specified knowledge base."
    echo ""
    echo "Example:"
    echo "  $0 ~/my-kb"
    exit 1
}

log() {
    echo -e "${GREEN}[thoth-lite]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[thoth-lite]${NC} $1"
}

error() {
    echo -e "${RED}[thoth-lite]${NC} $1"
    exit 1
}

# Check arguments
if [ -z "$1" ]; then
    usage
fi

KB_PATH="$1"

# Validate path
if [ ! -d "$KB_PATH" ]; then
    error "Directory does not exist: $KB_PATH"
fi

log "Installing thoth-lite to: $KB_PATH"

# Copy AGENTS.md
if [ -f "$KB_PATH/AGENTS.md" ]; then
    warn "AGENTS.md already exists, backing up to AGENTS.md.backup"
    cp "$KB_PATH/AGENTS.md" "$KB_PATH/AGENTS.md.backup"
fi
cp "$SCRIPT_DIR/AGENTS.md" "$KB_PATH/AGENTS.md"
log "Installed AGENTS.md"

# Install skills
SKILL_DIR="$KB_PATH/.opencode/skill"

if [ -d "$SKILL_DIR" ]; then
    warn "Existing skills found, removing old skills..."
    rm -rf "$SKILL_DIR"
fi

mkdir -p "$SKILL_DIR"

log "Cloning skills repository..."
TMP_DIR=$(mktemp -d)
git clone --quiet "$SKILLS_REPO" "$TMP_DIR/skills-repo"

log "Installing skills..."
cp -r "$TMP_DIR/skills-repo/skills/"* "$SKILL_DIR/"

# Remove template folder (not a skill)
rm -rf "$SKILL_DIR/_templates"

# Count installed skills
SKILL_COUNT=$(ls -d "$SKILL_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')

# Cleanup
rm -rf "$TMP_DIR"

log "Installed $SKILL_COUNT skills:"
ls -1 "$SKILL_DIR" | sed 's/^/  - /'

# Create basic KB structure if missing
if [ ! -f "$KB_PATH/_index.md" ]; then
    log "Creating basic knowledge base structure..."
    
    cat > "$KB_PATH/_index.md" << 'EOF'
# Knowledge Base

| Domain | Path | Description |
|--------|------|-------------|
| Work | work/_index.md | Professional projects and operations |
| Life | life/_index.md | Personal organization |
| Kernel | kernel/_index.md | System configuration and memory |
EOF

    mkdir -p "$KB_PATH/work" "$KB_PATH/life" "$KB_PATH/kernel"
    
    cat > "$KB_PATH/work/_index.md" << 'EOF'
# Work

| Name | File | Status | Summary |
|------|------|--------|---------|
EOF

    cat > "$KB_PATH/life/_index.md" << 'EOF'
# Life

| Name | File | Status | Summary |
|------|------|--------|---------|
EOF

    cat > "$KB_PATH/kernel/_index.md" << 'EOF'
# Kernel

| Name | File | Description |
|------|------|-------------|
EOF

    log "Created basic KB structure"
fi

echo ""
log "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. cd $KB_PATH"
echo "  2. Start OpenCode and begin using thoth-lite"
echo ""
echo "Try these commands:"
echo "  - 'plan my day' (morning-boot)"
echo "  - 'dump: quick thought about project X'"
echo "  - '/gardener check' (KB health)"
