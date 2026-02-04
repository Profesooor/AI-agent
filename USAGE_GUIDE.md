# AI Agent System - Usage Guide

Complete guide for using the world-class AI agent system built on Claude Code.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Using the Master Orchestrator](#using-the-master-orchestrator)
3. [Individual Agent Usage](#individual-agent-usage)
4. [Managing State and Progress](#managing-state-and-progress)
5. [Learning from Projects](#learning-from-projects)
6. [Optimization Strategies](#optimization-strategies)
7. [Troubleshooting](#troubleshooting)

## Getting Started

### Initial Setup

```bash
# Navigate to project directory
cd /path/to/your/project

# Run initialization script
./.claude/scripts/init-project.sh

# Start Claude Code
claude
```

### Your First Project

Describe your project in natural language:

```
"Build a REST API for a blog platform with:
- User authentication (JWT)
- CRUD operations for posts
- Comments system
- PostgreSQL database
- FastAPI backend
- React frontend with TypeScript"
```

The orchestrator will automatically guide you through all phases.

## Using the Master Orchestrator

### Starting Development

The orchestrator automatically coordinates all agents. Simply describe what you want:

```bash
# Full application
"Build a task management app with real-time updates"

# New feature
"Add user profile editing with image upload"

# Bug fix
"Fix the race condition in order processing"

# Optimization
"Optimize database queries for better performance"
```

### Monitoring Progress

The orchestrator provides real-time updates:

```
┌─────────────────────────────────────────┐
│  Phase: Implementation (3/6)            │
│  Progress: ████████░░░░░░░░░ 45%      │
│                                          │
│  Active:                                 │
│  🔵 backend-developer (task-12)         │
│  🟢 test-engineer (background)          │
│                                          │
│  Quality:                                │
│  ✓ Test Coverage: 85%                   │
│  ✓ Code Review: 9.2/10                  │
│  ✓ Security: 0 issues                   │
└─────────────────────────────────────────┘
```

### Checking Status

At any time, ask for status:

```
"What's the current status?"
"Show me pending tasks"
"What issues are blocking progress?"
```

## Individual Agent Usage

### Requirements Analysis

```bash
# Invoke requirements analyst
"Invoke requirements-analyst to clarify the payment processing requirements"
```

The agent will:
1. Ask clarifying questions
2. Document functional requirements
3. Document non-functional requirements
4. Define success criteria
5. Create .claude/knowledge/REQUIREMENTS.md

### Architecture Design

```bash
# Invoke architect
"Invoke architect to design the microservices architecture"
```

The agent will:
1. Review requirements
2. Research best practices
3. Design component architecture
4. Define data models and APIs
5. Document decisions with rationale
6. Create .claude/knowledge/ARCHITECTURE.md

### Implementation

```bash
# Backend development
"Invoke backend-developer to implement user authentication API"

# Frontend development
"Invoke frontend-developer to create login page"

# Database work
"Invoke database-engineer to optimize user queries"

# DevOps
"Invoke devops-engineer to set up CI/CD pipeline"
```

### Quality Assurance

```bash
# Code review
"Invoke code-reviewer to review recent changes"

# Security audit
"Invoke security-auditor to check for vulnerabilities"

# Testing
"Invoke test-engineer to generate tests for auth module"

# Performance
"Invoke performance-optimizer to analyze API response times"
```

### Documentation

```bash
# API documentation
"Invoke technical-writer to document the REST API"

# Code documentation
"Invoke code-documenter to add docstrings to user.py"
```

## Managing State and Progress

### State Files

All project state is stored in `.claude/state/`:

**progress.json** - Current project status
```json
{
  "phase": "implementation",
  "completed_tasks": ["task-001", "task-002"],
  "in_progress": ["task-003"],
  "pending": ["task-004", "task-005"],
  "issues": []
}
```

**decisions.json** - Architecture Decision Records
```json
{
  "adr-001": {
    "title": "Use PostgreSQL instead of MongoDB",
    "date": "2026-02-04",
    "status": "accepted",
    "context": "Need ACID transactions",
    "decision": "PostgreSQL with JSONB",
    "consequences": "Strong consistency, schema migrations required"
  }
}
```

**performance.json** - Token usage and costs
```json
{
  "agents_used": {
    "backend-developer": {
      "invocations": 5,
      "tokens": 120000,
      "model": "sonnet"
    }
  },
  "total_tokens": 450000,
  "estimated_cost": 7.85
}
```

### Resuming After Break

State is automatically preserved:

```bash
# Start Claude Code in same directory
claude

# Ask for status
"What's the current project status?"

# Continue work
"Continue implementation"
```

The orchestrator will:
1. Read state files
2. Report current phase and progress
3. Resume from where it left off

### Generating Reports

```bash
# Generate daily report
./.claude/scripts/generate-report.sh

# View report
cat .claude/reports/daily-report-2026-02-04.md
```

### Backing Up State

```bash
# Create backup
./.claude/scripts/backup-state.sh

# Backups stored in .claude/backups/
# Automatically keeps last 10 backups
```

## Learning from Projects

### Pattern Recognition

The system automatically learns from successful implementations:

```json
{
  "pattern-jwt-auth": {
    "name": "JWT Authentication with FastAPI",
    "task_type": "authentication",
    "agent_used": "backend-developer",
    "approach": "Use fastapi-jwt-auth library with refresh tokens",
    "token_usage": 42000,
    "success_rate": 0.95,
    "projects_used": 8
  }
}
```

### Viewing Learned Patterns

```bash
# View all patterns
cat .claude/learning/patterns.json | python3 -m json.tool

# Search for specific pattern
grep -r "authentication" .claude/learning/patterns.json
```

### Using Patterns

When starting similar tasks, the orchestrator automatically:
1. Searches pattern database
2. Suggests proven approaches
3. Warns about known pitfalls

Example:
```
"Implement user authentication"

> Found pattern 'JWT-Authentication-FastAPI' used successfully
> in 8 previous projects. Using proven approach...
```

### Managing Pitfalls

Known issues are stored in `.claude/learning/pitfalls.json`:

```json
{
  "pitfall-websocket-scale": {
    "name": "WebSocket scaling without load testing",
    "description": "WebSocket implementation failed under load",
    "solution": "Always run load tests before production",
    "occurrences": 3,
    "severity": "high"
  }
}
```

## Optimization Strategies

### Token Usage Optimization

**Selective Context Loading**
```bash
# Instead of reading entire codebase
# Load only relevant files for current task
```

**Summarization for Large Files**
```bash
# For files > 500 lines
# Agent creates summary stored in .claude/summaries/
# References summary instead of full file
```

**Background Execution**
```bash
# Independent tasks run in parallel
"Implement user API and product API"
# → Launches 2 agents in background simultaneously
```

### Model Selection

The orchestrator automatically selects optimal models:

| Task | Selected Model | Reasoning |
|------|---------------|-----------|
| Architecture design | Opus | Critical decisions |
| Security audit | Opus | Cannot miss vulnerabilities |
| Implementation | Sonnet | Balance cost and capability |
| Code exploration | Haiku | Fast and cheap |

### Cost Management

Monitor costs in real-time:

```bash
# Check current usage
cat .claude/state/performance.json

# Estimated cost shown in dashboard
"Show token usage and costs"
```

Expected costs (typical project):
- Small feature: $1-5
- Medium application: $25-30
- Large system: $50-100

Compare to human developer ($2,000-4,000):
**Savings: 98-99%**

## Troubleshooting

### Agent Fails to Start

**Problem**: Agent invocation fails

**Solution**:
```bash
# Check agent definition exists
ls .claude/agents/

# Verify YAML frontmatter is valid
# Ensure required fields: name, description, tools, model
```

### Context Limit Exceeded

**Problem**: "Context limit exceeded" error

**Solution**:
1. Manual compaction suggested at strategic points
2. Use background execution for independent tasks
3. Summarize large files

### State Files Corrupted

**Problem**: Invalid JSON in state files

**Solution**:
```bash
# Restore from backup
cp .claude/backups/backup-TIMESTAMP/state/*.json .claude/state/

# Or reinitialize
./.claude/scripts/init-project.sh
```

### Agent Not Following Instructions

**Problem**: Agent produces unexpected results

**Solution**:
1. Check agent definition in `.claude/agents/`
2. Verify instructions are clear and specific
3. Review if correct agent was selected
4. Check if skills are properly loaded

### High Token Usage

**Problem**: Token usage exceeds budget

**Solution**:
1. Use Haiku for simple tasks
2. Enable background execution
3. Load fewer files at once
4. Use summarization for large files
5. Trigger manual compaction

### Tasks Not Completing

**Problem**: Tasks stuck in "in_progress"

**Solution**:
```bash
# Check for blockers
cat .claude/state/progress.json | grep -A 5 "issues"

# Review task dependencies
cat .claude/state/TASKS.json | grep depends_on

# Manually update if needed
# Edit .claude/state/progress.json
```

## Advanced Usage

### Custom Agent Creation

Create new specialized agents:

```bash
# Create agent definition
vim .claude/agents/my-custom-agent.md
```

```yaml
---
name: my-custom-agent
description: Brief description of agent specialty
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet
permissionMode: acceptEdits
skills:
  - relevant-skill-1
  - relevant-skill-2
---

Agent instructions and guidelines here...
```

### Custom Skills

Create workflow skills:

```bash
# Create skill
vim .claude/skills/my-workflow.md
```

```yaml
---
name: my-workflow
description: Custom workflow for specific task pattern
---

Workflow instructions here...
```

### Integration with CI/CD

```bash
# Run tests automatically
./.claude/scripts/run-tests.sh

# Generate reports in CI
./.claude/scripts/generate-report.sh

# Backup learning database
./.claude/scripts/backup-state.sh
```

## Best Practices

1. **Always Initialize**: Run init-project.sh for new projects
2. **Clear Requirements**: Provide specific project descriptions
3. **Monitor Progress**: Check status regularly
4. **Review Decisions**: Check .claude/knowledge/DECISIONS.md
5. **Backup Regularly**: Run backup-state.sh before major changes
6. **Learn from History**: Review patterns.json for proven approaches
7. **Use Right Agent**: Let orchestrator choose, or specify when needed
8. **Parallel When Possible**: Let orchestrator run independent tasks in parallel
9. **Track Costs**: Monitor performance.json for token usage
10. **Document Decisions**: All architectural decisions in DECISIONS.md

## Quick Reference

### Commands

```bash
# Initialize
./.claude/scripts/init-project.sh

# Generate report
./.claude/scripts/generate-report.sh

# Backup state
./.claude/scripts/backup-state.sh

# Check status
cat .claude/state/progress.json

# View patterns
cat .claude/learning/patterns.json

# List agents
ls .claude/agents/
```

### Agent Invocations

```bash
# Requirements
"Invoke requirements-analyst to [task]"

# Architecture
"Invoke architect to [task]"

# Implementation
"Invoke backend-developer to [task]"
"Invoke frontend-developer to [task]"
"Invoke database-engineer to [task]"

# Quality
"Invoke code-reviewer to [task]"
"Invoke security-auditor to [task]"
"Invoke test-engineer to [task]"

# Documentation
"Invoke technical-writer to [task]"
```

### Status Queries

```bash
"What's the current status?"
"Show pending tasks"
"What issues are blocking?"
"Show token usage"
"Generate progress report"
```

## Getting Help

- Check `.claude/README.md` for architecture overview
- Review agent definitions in `.claude/agents/`
- Examine skill workflows in `.claude/skills/`
- Inspect state files in `.claude/state/`
- Review learning database in `.claude/learning/`

---

**Remember**: The AI agent system is designed to handle complete project lifecycles with minimal guidance. Trust the orchestrator, monitor progress, and let specialized agents do what they do best.
