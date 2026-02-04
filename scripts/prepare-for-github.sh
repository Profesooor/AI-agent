#!/bin/bash
# Prepare the .claude directory for GitHub upload

CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$CLAUDE_DIR"

echo "Preparing Claude Agent System for GitHub..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if we're in the .claude directory
if [ ! -f "GITHUB_README.md" ]; then
    echo "Error: Must be run from .claude directory"
    exit 1
fi

# Clean up user-specific files (keep templates)
echo "Cleaning user-specific files..."
rm -f state/progress.json state/decisions.json state/performance.json state/TASKS.json
rm -f learning/patterns.json learning/pitfalls.json learning/agent-performance.json
rm -f knowledge/ARCHITECTURE.md knowledge/REQUIREMENTS.md knowledge/CONVENTIONS.md knowledge/DECISIONS.md
rm -rf reports/ backups/ summaries/
echo -e "${GREEN}✓${NC} Cleaned user-specific files"
echo ""

# Ensure .gitkeep files exist
echo "Ensuring directory structure..."
touch knowledge/.gitkeep state/.gitkeep learning/.gitkeep
echo -e "${GREEN}✓${NC} Directory structure preserved"
echo ""

# Copy GitHub README as main README
echo "Setting up README for GitHub..."
if [ -f "GITHUB_README.md" ]; then
    cp GITHUB_README.md README.md
    echo -e "${GREEN}✓${NC} GitHub README copied to README.md"
else
    echo -e "${YELLOW}⚠${NC} GITHUB_README.md not found"
fi
echo ""

# Verify all required files exist
echo "Verifying required files..."
required_files=(
    "README.md"
    "LICENSE"
    "INSTALL.md"
    "CONTRIBUTING.md"
    "USAGE_GUIDE.md"
    "IMPLEMENTATION_SUMMARY.md"
    ".gitignore"
)

missing=0
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${YELLOW}✗${NC} $file (missing)"
        ((missing++))
    fi
done
echo ""

# Verify agents
echo "Verifying agents..."
agent_count=$(find agents -name "*.md" 2>/dev/null | wc -l)
echo -e "${GREEN}✓${NC} Found $agent_count agents"
echo ""

# Verify skills
echo "Verifying skills..."
skill_count=$(find skills -name "*.md" 2>/dev/null | wc -l)
echo -e "${GREEN}✓${NC} Found $skill_count skills"
echo ""

# Verify scripts
echo "Verifying scripts..."
script_count=$(find scripts -name "*.sh" 2>/dev/null | wc -l)
echo -e "${GREEN}✓${NC} Found $script_count scripts"
echo ""

if [ $missing -eq 0 ]; then
    echo "=========================================="
    echo -e "${GREEN}✓ Ready for GitHub!${NC}"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo ""
    echo "1. Initialize git repository (if not already done):"
    echo "   cd .claude"
    echo "   git init"
    echo "   git add ."
    echo "   git commit -m 'Initial commit: Claude Code Agent System'"
    echo ""
    echo "2. Create GitHub repository:"
    echo "   - Go to github.com/new"
    echo "   - Name: claude-agent-system (or your preferred name)"
    echo "   - Description: World-class AI agent orchestration system for Claude Code"
    echo "   - Public or Private (recommend Public for sharing)"
    echo "   - Don't initialize with README (we have one)"
    echo ""
    echo "3. Push to GitHub:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/claude-agent-system.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo ""
    echo "4. Share with others:"
    echo "   - Installation: git clone https://github.com/YOUR_USERNAME/claude-agent-system.git .claude"
    echo "   - Users run: ./.claude/scripts/init-project.sh"
    echo ""
    echo "Optional: Add topics on GitHub:"
    echo "  claude-code, ai-agents, automation, development-tools, orchestration"
else
    echo "=========================================="
    echo -e "${YELLOW}⚠ Missing files detected${NC}"
    echo "=========================================="
    echo ""
    echo "Please ensure all required files are present before uploading to GitHub."
fi
