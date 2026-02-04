#!/bin/bash
# Initialize project structure for orchestrator

PROJECT_ROOT=$(pwd)
CLAUDE_DIR="$PROJECT_ROOT/.claude"

echo "Initializing project structure..."

# Create directories
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/knowledge"
mkdir -p "$CLAUDE_DIR/state"
mkdir -p "$CLAUDE_DIR/learning"
mkdir -p "$CLAUDE_DIR/scripts"
mkdir -p "$CLAUDE_DIR/skills"

# Initialize state files
cat > "$CLAUDE_DIR/state/progress.json" <<EOF
{
  "phase": "planning",
  "completed_tasks": [],
  "in_progress": [],
  "pending": [],
  "issues": [],
  "session_id": "$(uuidgen)",
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

# Initialize knowledge files
cat > "$CLAUDE_DIR/knowledge/ARCHITECTURE.md" <<EOF
# System Architecture

*This file will be populated by the architect agent*
EOF

cat > "$CLAUDE_DIR/knowledge/REQUIREMENTS.md" <<EOF
# Project Requirements

*This file will be populated by the requirements-analyst agent*
EOF

cat > "$CLAUDE_DIR/knowledge/CONVENTIONS.md" <<EOF
# Code Conventions & Best Practices

*This file will be populated during research phase*
EOF

cat > "$CLAUDE_DIR/knowledge/DECISIONS.md" <<EOF
# Architecture Decision Records (ADR)

*Architecture decisions will be documented here*
EOF

# Initialize learning database (if not exists)
if [ ! -f "$CLAUDE_DIR/learning/patterns.json" ]; then
    cat > "$CLAUDE_DIR/learning/patterns.json" <<EOF
{}
EOF
fi

if [ ! -f "$CLAUDE_DIR/learning/pitfalls.json" ]; then
    cat > "$CLAUDE_DIR/learning/pitfalls.json" <<EOF
{}
EOF
fi

if [ ! -f "$CLAUDE_DIR/learning/agent-performance.json" ]; then
    cat > "$CLAUDE_DIR/learning/agent-performance.json" <<EOF
{}
EOF
fi

echo "✓ Project structure initialized at $CLAUDE_DIR"
echo ""
echo "Next steps:"
echo "1. Describe your project to start requirements analysis"
echo "2. The orchestrator will guide you through each phase"
