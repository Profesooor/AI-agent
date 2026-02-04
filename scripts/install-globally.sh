#!/bin/bash
# Install Claude Agent System globally for use across all projects

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Global installation directory
GLOBAL_DIR="$HOME/.claude-agents"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Claude Agent System - Global Installation              ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if already installed
if [ -d "$GLOBAL_DIR" ]; then
    echo -e "${YELLOW}⚠ Global installation already exists at $GLOBAL_DIR${NC}"
    read -p "Do you want to update it? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo "Updating existing installation..."
    rm -rf "$GLOBAL_DIR"
fi

# Create global directory
echo -e "${GREEN}→${NC} Creating global directory at $GLOBAL_DIR"
mkdir -p "$GLOBAL_DIR"

# Copy all agent system files
echo -e "${GREEN}→${NC} Copying agent system files..."
cp -r "$SOURCE_DIR/agents" "$GLOBAL_DIR/"
cp -r "$SOURCE_DIR/skills" "$GLOBAL_DIR/"
cp -r "$SOURCE_DIR/scripts" "$GLOBAL_DIR/"
cp "$SOURCE_DIR/README.md" "$GLOBAL_DIR/"
cp "$SOURCE_DIR/USAGE_GUIDE.md" "$GLOBAL_DIR/"
cp "$SOURCE_DIR/LICENSE" "$GLOBAL_DIR/"

# Create global templates
echo -e "${GREEN}→${NC} Creating templates..."
mkdir -p "$GLOBAL_DIR/templates"

# Create knowledge template
cat > "$GLOBAL_DIR/templates/ARCHITECTURE.md" <<'EOF'
# System Architecture

*This file will be populated by the architect agent*
EOF

cat > "$GLOBAL_DIR/templates/REQUIREMENTS.md" <<'EOF'
# Project Requirements

*This file will be populated by the requirements-analyst agent*
EOF

cat > "$GLOBAL_DIR/templates/CONVENTIONS.md" <<'EOF'
# Code Conventions & Best Practices

*This file will be populated during research phase*
EOF

cat > "$GLOBAL_DIR/templates/DECISIONS.md" <<'EOF'
# Architecture Decision Records (ADR)

*Architecture decisions will be documented here*
EOF

# Create project initialization script
cat > "$GLOBAL_DIR/scripts/init-project-from-global.sh" <<'INITSCRIPT'
#!/bin/bash
# Initialize a project to use global Claude Agent System

set -e

PROJECT_DIR="${1:-.}"
GLOBAL_DIR="$HOME/.claude-agents"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Initializing project with global Claude Agent System...${NC}"
echo ""

# Check if global installation exists
if [ ! -d "$GLOBAL_DIR" ]; then
    echo "Error: Global installation not found at $GLOBAL_DIR"
    echo "Please run: install-globally.sh first"
    exit 1
fi

# Create project .claude directory
CLAUDE_DIR="$PROJECT_DIR/.claude"
mkdir -p "$CLAUDE_DIR"

# Create symlinks to global agents and skills
echo -e "${GREEN}→${NC} Creating symlinks to global agents..."
ln -sf "$GLOBAL_DIR/agents" "$CLAUDE_DIR/agents"

echo -e "${GREEN}→${NC} Creating symlinks to global skills..."
ln -sf "$GLOBAL_DIR/skills" "$CLAUDE_DIR/skills"

echo -e "${GREEN}→${NC} Creating symlinks to global scripts..."
ln -sf "$GLOBAL_DIR/scripts" "$CLAUDE_DIR/scripts"

# Create project-specific directories
echo -e "${GREEN}→${NC} Creating project-specific directories..."
mkdir -p "$CLAUDE_DIR/knowledge"
mkdir -p "$CLAUDE_DIR/state"
mkdir -p "$CLAUDE_DIR/learning"

# Copy templates to project
cp "$GLOBAL_DIR/templates/"*.md "$CLAUDE_DIR/knowledge/" 2>/dev/null || true

# Initialize state files
cat > "$CLAUDE_DIR/state/progress.json" <<EOF
{
  "phase": "planning",
  "completed_tasks": [],
  "in_progress": [],
  "pending": [],
  "issues": [],
  "session_id": "$(uuidgen 2>/dev/null || date +%s)",
  "started_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

cat > "$CLAUDE_DIR/state/decisions.json" <<EOF
{}
EOF

cat > "$CLAUDE_DIR/state/performance.json" <<EOF
{
  "agents_used": {},
  "total_tokens": 0,
  "estimated_cost": 0
}
EOF

# Initialize learning database
cat > "$CLAUDE_DIR/learning/patterns.json" <<EOF
{}
EOF

cat > "$CLAUDE_DIR/learning/pitfalls.json" <<EOF
{}
EOF

cat > "$CLAUDE_DIR/learning/agent-performance.json" <<EOF
{}
EOF

# Create project README reference
cat > "$CLAUDE_DIR/README.md" <<EOF
# Claude Agent System (Project Instance)

This project uses the globally installed Claude Agent System.

## Global Installation Location
$GLOBAL_DIR

## Project-Specific Files
- \`knowledge/\` - Project architecture and requirements
- \`state/\` - Session state and progress
- \`learning/\` - Project-specific learning patterns

## Shared Files (symlinked)
- \`agents/\` → Global agents
- \`skills/\` → Global skills
- \`scripts/\` → Global scripts

## Usage

Start Claude Code in this directory and use the agents:

\`\`\`
"Use the requirements-analyst agent to clarify requirements"
"Use the architect agent to design the system"
"Use the backend-developer agent to implement the API"
\`\`\`

## Documentation

- Usage Guide: $GLOBAL_DIR/USAGE_GUIDE.md
- Full README: $GLOBAL_DIR/README.md
EOF

echo ""
echo -e "${GREEN}✓ Project initialized successfully!${NC}"
echo ""
echo "Project structure:"
echo "  $CLAUDE_DIR/"
echo "  ├── agents/       → $GLOBAL_DIR/agents (symlink)"
echo "  ├── skills/       → $GLOBAL_DIR/skills (symlink)"
echo "  ├── scripts/      → $GLOBAL_DIR/scripts (symlink)"
echo "  ├── knowledge/    (project-specific)"
echo "  ├── state/        (project-specific)"
echo "  └── learning/     (project-specific)"
echo ""
echo "Start using with: claude"
INITSCRIPT

chmod +x "$GLOBAL_DIR/scripts/init-project-from-global.sh"

# Create global command wrapper
echo -e "${GREEN}→${NC} Creating global command..."
cat > "$GLOBAL_DIR/claude-agents" <<'WRAPPER'
#!/bin/bash
# Global command wrapper for Claude Agent System

GLOBAL_DIR="$HOME/.claude-agents"

case "$1" in
    init)
        # Initialize current directory
        "$GLOBAL_DIR/scripts/init-project-from-global.sh" "${2:-.}"
        ;;
    update)
        # Update global installation
        echo "Pulling latest changes from GitHub..."
        cd "$GLOBAL_DIR"
        git pull origin main 2>/dev/null || echo "Not a git repository. Manual update required."
        ;;
    list-agents)
        # List available agents
        echo "Available agents:"
        ls -1 "$GLOBAL_DIR/agents" | sed 's/.md$//' | sed 's/^/  - /'
        ;;
    list-skills)
        # List available skills
        echo "Available skills:"
        ls -1 "$GLOBAL_DIR/skills" | sed 's/.md$//' | sed 's/^/  - /'
        ;;
    info)
        # Show installation info
        echo "Claude Agent System - Global Installation"
        echo ""
        echo "Location: $GLOBAL_DIR"
        echo "Agents: $(ls -1 "$GLOBAL_DIR/agents" | wc -l)"
        echo "Skills: $(ls -1 "$GLOBAL_DIR/skills" | wc -l)"
        echo ""
        echo "Usage:"
        echo "  claude-agents init [dir]      Initialize project"
        echo "  claude-agents list-agents     List all agents"
        echo "  claude-agents list-skills     List all skills"
        echo "  claude-agents info            Show this info"
        echo "  claude-agents docs            Open documentation"
        ;;
    docs)
        # Open documentation
        if command -v open &> /dev/null; then
            open "$GLOBAL_DIR/README.md"
        else
            less "$GLOBAL_DIR/README.md"
        fi
        ;;
    *)
        echo "Claude Agent System - Global Installation"
        echo ""
        echo "Usage:"
        echo "  claude-agents init [dir]      Initialize project with agent system"
        echo "  claude-agents list-agents     List all available agents"
        echo "  claude-agents list-skills     List all available skills"
        echo "  claude-agents info            Show installation information"
        echo "  claude-agents docs            Open documentation"
        echo ""
        echo "Example:"
        echo "  cd my-project"
        echo "  claude-agents init"
        echo "  claude"
        ;;
esac
WRAPPER

chmod +x "$GLOBAL_DIR/claude-agents"

# Add to PATH suggestion
echo ""
echo -e "${GREEN}✓ Global installation complete!${NC}"
echo ""
echo "Installation location: $GLOBAL_DIR"
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}Next Steps:${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "1. Add to your PATH (choose one):"
echo ""
echo "   For bash (~/.bashrc or ~/.bash_profile):"
echo "   echo 'export PATH=\"\$HOME/.claude-agents:\$PATH\"' >> ~/.bashrc"
echo "   source ~/.bashrc"
echo ""
echo "   For zsh (~/.zshrc):"
echo "   echo 'export PATH=\"\$HOME/.claude-agents:\$PATH\"' >> ~/.zshrc"
echo "   source ~/.zshrc"
echo ""
echo "2. Initialize any project:"
echo "   cd your-project"
echo "   claude-agents init"
echo ""
echo "3. Start using:"
echo "   claude"
echo ""
echo "Commands:"
echo "  claude-agents init            Initialize current directory"
echo "  claude-agents list-agents     List all agents"
echo "  claude-agents list-skills     List all skills"
echo "  claude-agents info            Show installation info"
echo ""
echo -e "${GREEN}✓ Ready to use across all your projects!${NC}"
