# Global Installation Guide

Install the Claude Agent System globally to use it across all your projects.

## Why Global Installation?

- **No Duplication**: Agents and skills stored once, used everywhere
- **Easy Updates**: Update once, all projects benefit
- **Per-Project State**: Each project maintains its own knowledge, state, and learning
- **CLI Access**: Simple `claude-agents` command from anywhere

## Installation

### Quick Install

```bash
# Clone from GitHub
git clone https://github.com/Profesooor/AI-agent.git /tmp/AI-agent

# Run global installer
cd /tmp/AI-agent
./scripts/install-globally.sh

# Clean up
rm -rf /tmp/AI-agent
```

### What Gets Installed

**Global Location**: `~/.claude-agents/`

```
~/.claude-agents/
├── agents/          # 16 specialized agents (shared)
├── skills/          # 4 orchestration skills (shared)
├── scripts/         # Automation scripts (shared)
├── templates/       # Project templates
├── README.md        # Documentation
└── claude-agents    # CLI command
```

**Per-Project**: `.claude/` in each project

```
project/.claude/
├── agents/       → ~/.claude-agents/agents (symlink)
├── skills/       → ~/.claude-agents/skills (symlink)
├── scripts/      → ~/.claude-agents/scripts (symlink)
├── knowledge/    # Project-specific (architecture, requirements)
├── state/        # Project-specific (progress, decisions)
└── learning/     # Project-specific (patterns, pitfalls)
```

## Usage

### Initialize Any Project

```bash
cd your-project
claude-agents init
```

This creates `.claude/` directory with:
- Symlinks to global agents/skills
- Empty knowledge, state, and learning directories
- Initialized JSON files

### Use in Claude Code

```bash
claude

# Then use agents naturally:
"Use the requirements-analyst agent to clarify requirements"
"Use the architect agent to design the system"
"Use the backend-developer agent to implement the API"
```

## CLI Commands

### `claude-agents init [directory]`

Initialize a project (default: current directory)

```bash
# Initialize current directory
claude-agents init

# Initialize specific directory
claude-agents init ~/projects/my-app
```

### `claude-agents list-agents`

List all available agents

```bash
claude-agents list-agents
```

Output:
```
Available agents:
  - requirements-analyst
  - architect
  - task-planner
  - backend-developer
  - frontend-developer
  - database-engineer
  - devops-engineer
  - code-reviewer
  - security-auditor
  - test-engineer
  - performance-optimizer
  - technical-writer
  - code-documenter
  - technology-researcher
```

### `claude-agents list-skills`

List all available skills

```bash
claude-agents list-skills
```

Output:
```
Available skills:
  - master-orchestrator
  - context-optimizer
  - pattern-learner
  - performance-monitor
```

### `claude-agents info`

Show installation information

```bash
claude-agents info
```

### `claude-agents docs`

Open documentation

```bash
claude-agents docs
```

## Multi-Project Workflow

### Example: Multiple Projects

```bash
# Project 1: API Backend
cd ~/work/api-backend
claude-agents init
claude
> "Build a REST API with JWT authentication"

# Project 2: Frontend
cd ~/work/frontend
claude-agents init
claude
> "Build a React frontend with authentication"

# Project 3: Mobile App
cd ~/personal/mobile-app
claude-agents init
claude
> "Build a React Native mobile app"
```

Each project:
- Uses the same 16 agents (via symlinks)
- Maintains separate architecture docs
- Tracks its own progress
- Learns project-specific patterns

### Shared Learning (Optional)

If you want projects to share learning patterns:

```bash
# In project 1
ln -sf ~/.claude-agents-shared-learning ~/.claude/learning

# In project 2
ln -sf ~/.claude-agents-shared-learning ~/.claude/learning
```

Now both projects learn from each other's successes.

## Updating Global Installation

### Update from GitHub

```bash
cd ~/.claude-agents
git pull origin main
```

All projects instantly get updated agents!

### Manual Update

```bash
# Clone latest version
git clone https://github.com/Profesooor/AI-agent.git /tmp/AI-agent

# Run installer (will update existing)
cd /tmp/AI-agent
./scripts/install-globally.sh
```

## Uninstalling

### Remove Global Installation

```bash
# Remove global directory
rm -rf ~/.claude-agents

# Remove from PATH (edit ~/.zshrc or ~/.bashrc)
# Remove line: export PATH="$HOME/.claude-agents:$PATH"
```

### Remove from Specific Project

```bash
cd your-project
rm -rf .claude
```

## Advantages

**vs Local Installation**:
- ✅ No duplication across projects
- ✅ Single update point
- ✅ Consistent agent behavior
- ✅ Shared documentation
- ✅ Easy to maintain

**vs No Installation**:
- ✅ Always available
- ✅ CLI convenience
- ✅ Per-project state
- ✅ Project isolation

## Troubleshooting

### Command Not Found

If `claude-agents` command not found:

```bash
# Add to PATH manually
export PATH="$HOME/.claude-agents:$PATH"

# Or restart terminal
```

### Symlinks Not Working

If symlinks don't work (rare):

```bash
# Use hard copies instead
cd your-project/.claude
rm agents skills scripts
cp -r ~/.claude-agents/agents .
cp -r ~/.claude-agents/skills .
cp -r ~/.claude-agents/scripts .
```

### Permission Issues

```bash
# Make scripts executable
chmod +x ~/.claude-agents/scripts/*.sh
chmod +x ~/.claude-agents/claude-agents
```

## Best Practices

1. **Global for Agents**: Keep agents/skills global for consistency
2. **Local for State**: Keep knowledge/state/learning project-specific
3. **Update Regularly**: Pull latest agents from GitHub periodically
4. **Share Learning**: Optionally share learning database across similar projects
5. **Backup Learning**: Projects learn valuable patterns - back them up

## Migration

### From Local to Global

If you have local installations:

```bash
# Backup project-specific data
cp -r .claude/knowledge ~/backup/project-knowledge
cp -r .claude/state ~/backup/project-state
cp -r .claude/learning ~/backup/project-learning

# Remove local installation
rm -rf .claude

# Initialize with global
claude-agents init

# Restore project data
cp -r ~/backup/project-knowledge .claude/knowledge
cp -r ~/backup/project-state .claude/state
cp -r ~/backup/project-learning .claude/learning
```

### From Global to Local

If you prefer local installation:

```bash
# Copy global to local
cp -r ~/.claude-agents/agents .claude/
cp -r ~/.claude-agents/skills .claude/
cp -r ~/.claude-agents/scripts .claude/

# Remove symlinks (now unnecessary)
```

## Examples

### Quick Start Template

```bash
#!/bin/bash
# Start new project with AI agents

PROJECT_NAME="$1"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize git
git init

# Initialize AI agents
claude-agents init

# Start building
claude
```

Save as `new-project.sh`, make executable, use:

```bash
./new-project.sh my-awesome-app
```

### CI/CD Integration

```yaml
# .github/workflows/build.yml
- name: Install Claude Agents
  run: |
    git clone https://github.com/Profesooor/AI-agent.git /tmp/agents
    cd /tmp/agents
    ./scripts/install-globally.sh

- name: Initialize project
  run: claude-agents init
```

## FAQ

**Q: Can I customize agents per-project?**
A: Yes, copy the agent to `.claude/agents/` and edit. Local version takes precedence.

**Q: Do all projects need internet?**
A: No, once installed globally, works offline.

**Q: What if I update an agent?**
A: Update in `~/.claude-agents/agents/`, all projects get it immediately.

**Q: Can I have multiple versions?**
A: Yes, use different global directories: `~/.claude-agents-v1/`, `~/.claude-agents-v2/`

**Q: How much disk space?**
A: ~2MB for global installation, ~10KB per project.

---

**Global installation provides the best experience for multi-project workflows!** 🚀
