# Contributing to Claude Code Agent System

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## Ways to Contribute

1. **Add New Agents** - Create specialized agents for specific domains
2. **Improve Agent Prompts** - Enhance existing agent instructions
3. **Add Skills** - Create new workflow orchestration skills
4. **Fix Bugs** - Report and fix issues
5. **Improve Documentation** - Clarify usage and examples
6. **Share Patterns** - Contribute successful implementation patterns

## Getting Started

### Fork and Clone

```bash
# Fork the repository on GitHub

# Clone your fork
git clone https://github.com/YOUR_USERNAME/claude-agent-system.git
cd claude-agent-system

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL_OWNER/claude-agent-system.git
```

### Development Setup

```bash
# Install in test project
mkdir -p test-project/.claude
cp -r * test-project/.claude/
cd test-project

# Initialize
./.claude/scripts/init-project.sh

# Verify
./.claude/scripts/verify-installation.sh
```

## Creating New Agents

### Agent Template

Create a new file in `agents/` directory:

```yaml
---
name: your-agent-name
description: Brief description (used for auto-selection). Use proactively when [condition].
tools: Read, Write, Edit, Bash, Grep, Glob  # Tools this agent needs
model: sonnet  # or opus (critical decisions), haiku (simple tasks)
permissionMode: acceptEdits  # or default (read-only)
skills:
  - relevant-skill-1  # Skills to preload
  - relevant-skill-2
---

You are a [role] specializing in [domain].

When [triggering condition]:
1. [Step 1]
2. [Step 2]
3. [Step 3]

[Additional instructions and guidelines]

Quality checklist:
- ✓ [Requirement 1]
- ✓ [Requirement 2]
- ✓ [Requirement 3]

Always [important behavior].
```

### Agent Best Practices

1. **Clear Description** - Used by orchestrator to auto-select agent
2. **Specific Role** - Define narrow, focused responsibility
3. **Actionable Instructions** - Step-by-step guidance
4. **Quality Standards** - Include checklist for consistency
5. **Tool Selection** - Only request tools actually needed
6. **Model Selection**:
   - Use `opus` for critical decisions (architecture, security)
   - Use `sonnet` for most implementation work
   - Use `haiku` for simple tasks (exploration, basic docs)

### Example: Creating a Mobile Developer Agent

```yaml
---
name: mobile-developer
description: Mobile app development specialist for iOS and Android. Use for mobile UI, native features, app deployment.
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet
permissionMode: acceptEdits
skills:
  - coding-standards
---

You are a senior mobile developer specializing in iOS and Android development.

When implementing mobile features:
1. Determine platform (iOS/Android/cross-platform)
2. Follow platform-specific design guidelines
3. Implement with production-quality code
4. Handle platform permissions properly
5. Write platform-specific tests
6. Ensure offline functionality where appropriate

Mobile development checklist:
- ✓ Follows platform design guidelines (HIG/Material Design)
- ✓ Proper permission handling
- ✓ Offline functionality considered
- ✓ Battery and memory optimization
- ✓ Platform-specific tests included
- ✓ App store guidelines followed

Always consider mobile-specific constraints (battery, network, screen size).
```

## Creating New Skills

### Skill Template

Create a new file in `skills/` directory:

```yaml
---
name: your-skill-name
description: Brief description of workflow
---

You are a [role] managing [workflow].

## Workflow Steps

### Phase 1: [Name]
1. [Action 1]
2. [Action 2]

### Phase 2: [Name]
1. [Action 1]
2. [Action 2]

## Example Usage

[Example of how to use this skill]

## Notes

[Important considerations]
```

## Testing Contributions

### Test Your Agent

```bash
# Start Claude Code in test project
claude

# Test agent invocation
"Use the YOUR-AGENT agent to [task]"

# Verify behavior
# - Does it invoke correctly?
# - Does it use appropriate tools?
# - Does it produce quality output?
```

### Test Integration

```bash
# Test with orchestrator
"Build a [project type] that uses this new agent's specialty"

# Verify auto-selection
# - Does orchestrator choose this agent appropriately?
# - Does it work well with other agents?
```

## Pull Request Process

### Before Submitting

1. **Test Thoroughly** - Verify agent works as expected
2. **Update Documentation** - Add to README if needed
3. **Follow Style** - Match existing agent format
4. **Add Examples** - Show usage in USAGE_GUIDE.md

### Commit Messages

Use clear, descriptive commit messages:

```
Add mobile-developer agent for iOS/Android

- Implements mobile-specific development patterns
- Includes platform permission handling
- Adds mobile testing guidelines
- Updates USAGE_GUIDE with mobile examples
```

### Creating Pull Request

1. Push to your fork:
```bash
git checkout -b feature/mobile-developer
git add agents/mobile-developer.md
git commit -m "Add mobile-developer agent"
git push origin feature/mobile-developer
```

2. Create PR on GitHub:
   - Clear title describing the change
   - Description of what and why
   - Examples of usage
   - Test results

### PR Review Process

- Maintainers will review within 3-5 days
- Address any feedback
- Once approved, will be merged

## Code of Conduct

### Our Pledge

We pledge to make participation in this project a harassment-free experience for everyone.

### Our Standards

**Positive behavior:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community

**Unacceptable behavior:**
- Trolling, insulting/derogatory comments
- Public or private harassment
- Publishing others' private information
- Other conduct which could reasonably be considered inappropriate

### Enforcement

Instances of unacceptable behavior may be reported to project maintainers. All complaints will be reviewed and investigated.

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- GitHub contributors page

## Questions?

- Open a GitHub Discussion for general questions
- Open an Issue for bugs or feature requests
- Tag maintainers for urgent matters

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to Claude Code Agent System!** 🙏
