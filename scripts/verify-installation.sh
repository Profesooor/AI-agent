#!/bin/bash
# Verify AI agent system installation

PROJECT_ROOT=$(pwd)
CLAUDE_DIR="$PROJECT_ROOT/.claude"

echo "Verifying AI Agent System Installation..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success=0
fail=0

# Check directories
echo "Checking directories..."
for dir in agents knowledge state learning scripts skills; do
    if [ -d "$CLAUDE_DIR/$dir" ]; then
        echo -e "${GREEN}✓${NC} $CLAUDE_DIR/$dir"
        ((success++))
    else
        echo -e "${RED}✗${NC} $CLAUDE_DIR/$dir (missing)"
        ((fail++))
    fi
done
echo ""

# Check agent files
echo "Checking agent definitions..."
agents=(
    "requirements-analyst"
    "architect"
    "task-planner"
    "technology-researcher"
    "backend-developer"
    "frontend-developer"
    "database-engineer"
    "devops-engineer"
    "code-reviewer"
    "security-auditor"
    "test-engineer"
    "performance-optimizer"
    "technical-writer"
    "code-documenter"
)

for agent in "${agents[@]}"; do
    if [ -f "$CLAUDE_DIR/agents/${agent}.md" ]; then
        echo -e "${GREEN}✓${NC} ${agent}.md"
        ((success++))
    else
        echo -e "${RED}✗${NC} ${agent}.md (missing)"
        ((fail++))
    fi
done
echo ""

# Check skills
echo "Checking skills..."
skills=(
    "master-orchestrator"
    "context-optimizer"
    "pattern-learner"
    "performance-monitor"
)

for skill in "${skills[@]}"; do
    if [ -f "$CLAUDE_DIR/skills/${skill}.md" ]; then
        echo -e "${GREEN}✓${NC} ${skill}.md"
        ((success++))
    else
        echo -e "${RED}✗${NC} ${skill}.md (missing)"
        ((fail++))
    fi
done
echo ""

# Check state files
echo "Checking state files..."
state_files=("progress.json" "decisions.json" "performance.json")

for file in "${state_files[@]}"; do
    if [ -f "$CLAUDE_DIR/state/$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
        ((success++))
    else
        echo -e "${RED}✗${NC} $file (missing)"
        ((fail++))
    fi
done
echo ""

# Check learning files
echo "Checking learning database..."
learning_files=("patterns.json" "pitfalls.json" "agent-performance.json")

for file in "${learning_files[@]}"; do
    if [ -f "$CLAUDE_DIR/learning/$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
        ((success++))
    else
        echo -e "${RED}✗${NC} $file (missing)"
        ((fail++))
    fi
done
echo ""

# Check scripts
echo "Checking scripts..."
scripts=("init-project.sh" "generate-report.sh" "backup-state.sh")

for script in "${scripts[@]}"; do
    if [ -f "$CLAUDE_DIR/scripts/$script" ]; then
        if [ -x "$CLAUDE_DIR/scripts/$script" ]; then
            echo -e "${GREEN}✓${NC} $script (executable)"
            ((success++))
        else
            echo -e "${YELLOW}⚠${NC} $script (not executable)"
            ((fail++))
        fi
    else
        echo -e "${RED}✗${NC} $script (missing)"
        ((fail++))
    fi
done
echo ""

# Check documentation
echo "Checking documentation..."
docs=("README.md" "USAGE_GUIDE.md" "IMPLEMENTATION_SUMMARY.md")

for doc in "${docs[@]}"; do
    if [ -f "$CLAUDE_DIR/$doc" ]; then
        echo -e "${GREEN}✓${NC} $doc"
        ((success++))
    else
        echo -e "${RED}✗${NC} $doc (missing)"
        ((fail++))
    fi
done
echo ""

# Validate JSON files
echo "Validating JSON files..."
if command -v python3 &> /dev/null; then
    for json_file in "$CLAUDE_DIR/state/"*.json "$CLAUDE_DIR/learning/"*.json; do
        if [ -f "$json_file" ]; then
            if python3 -m json.tool "$json_file" > /dev/null 2>&1; then
                echo -e "${GREEN}✓${NC} $(basename $json_file) (valid JSON)"
                ((success++))
            else
                echo -e "${RED}✗${NC} $(basename $json_file) (invalid JSON)"
                ((fail++))
            fi
        fi
    done
else
    echo -e "${YELLOW}⚠${NC} Python3 not found, skipping JSON validation"
fi
echo ""

# Summary
echo "========================================"
echo "Installation Verification Complete"
echo "========================================"
echo -e "Success: ${GREEN}$success${NC}"
echo -e "Failed:  ${RED}$fail${NC}"
echo ""

if [ $fail -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "The AI Agent System is ready to use."
    echo ""
    echo "Quick Start:"
    echo "1. Start Claude Code in this directory"
    echo "2. Describe your project or feature"
    echo "3. Let the orchestrator coordinate specialized agents"
    echo ""
    echo "Documentation:"
    echo "- Architecture: .claude/README.md"
    echo "- Usage Guide: .claude/USAGE_GUIDE.md"
    echo "- Implementation: .claude/IMPLEMENTATION_SUMMARY.md"
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo ""
    echo "Run the initialization script to fix missing files:"
    echo "  ./.claude/scripts/init-project.sh"
    exit 1
fi
