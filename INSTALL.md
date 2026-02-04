# Installation Guide

Complete installation instructions for the Claude Code Agent System.

## Quick Install (Recommended)

### For New Projects

```bash
# Navigate to your project root
cd your-project

# Clone into .claude directory
git clone https://github.com/yourusername/claude-agent-system.git .claude

# Initialize the system
./.claude/scripts/init-project.sh

# Verify installation
./.claude/scripts/verify-installation.sh
```

### For Existing Projects with .claude Directory

```bash
# Navigate to your project root
cd your-project

# Backup existing .claude directory (if needed)
mv .claude .claude.backup

# Clone the agent system
git clone https://github.com/yourusername/claude-agent-system.git .claude

# Initialize
./.claude/scripts/init-project.sh

# Verify
./.claude/scripts/verify-installation.sh
```

## Manual Installation

If you prefer manual installation or need to customize:

### Step 1: Create Directory Structure

```bash
cd your-project
mkdir -p .claude/{agents,skills,knowledge,state,learning,scripts}
```

### Step 2: Download Files

**Option A: Clone and Copy**
```bash
git clone https://github.com/yourusername/claude-agent-system.git /tmp/claude-agent-system
cp -r /tmp/claude-agent-system/agents/* .claude/agents/
cp -r /tmp/claude-agent-system/skills/* .claude/skills/
cp -r /tmp/claude-agent-system/scripts/* .claude/scripts/
cp /tmp/claude-agent-system/README.md .claude/
cp /tmp/claude-agent-system/USAGE_GUIDE.md .claude/
rm -rf /tmp/claude-agent-system
```

**Option B: Download Zip**
1. Download from GitHub releases
2. Extract to temporary location
3. Copy contents to `.claude/`

### Step 3: Make Scripts Executable

```bash
chmod +x .claude/scripts/*.sh
```

### Step 4: Initialize

```bash
./.claude/scripts/init-project.sh
```

### Step 5: Verify

```bash
./.claude/scripts/verify-installation.sh
```

## Installation Verification

After installation, you should see:

```
✅ VERIFICATION STATUS

All 42 Checks Passed:
├─ 6 Directories created
├─ 16 Agent definitions
├─ 4 Skills
├─ 3 State files (valid JSON)
├─ 3 Learning database files (valid JSON)
├─ 4 Automation scripts (executable)
└─ 3 Documentation files

System Status: ✓ Production Ready
```

## Troubleshooting

### Problem: Permission Denied on Scripts

**Solution:**
```bash
chmod +x .claude/scripts/*.sh
```

### Problem: Python Not Found (for JSON validation)

**Solution:**
Install Python 3.8+:
```bash
# macOS
brew install python3

# Ubuntu/Debian
sudo apt-get install python3

# Windows
# Download from python.org
```

### Problem: Directory Already Exists

**Solution:**
```bash
# Backup existing directory
mv .claude .claude.backup.$(date +%Y%m%d)

# Then proceed with installation
```

### Problem: Git Not Available

**Solution:**
Download zip file from GitHub releases and extract manually.

## Platform-Specific Notes

### macOS

Works out of the box. Ensure you have:
- Bash (pre-installed)
- Python 3 (install via Homebrew if needed)

### Linux

Works out of the box. Most distributions include:
- Bash (pre-installed)
- Python 3 (install via package manager if needed)

### Windows

Requires WSL (Windows Subsystem for Linux):

1. Install WSL: `wsl --install`
2. Open WSL terminal
3. Follow Linux installation instructions

## Post-Installation

### Test the System

Start Claude Code and try:

```bash
claude

# In the conversation:
"Use the requirements-analyst agent to help me understand what I need for a task management app"
```

### First Project

```bash
"Build a simple REST API with user authentication"
```

The system will guide you through the entire process.

## Updating

### Update to Latest Version

```bash
cd .claude
git pull origin main

# Verify update
./.claude/scripts/verify-installation.sh
```

### Preserve Your Learning Database

The learning database (`.claude/learning/`) contains patterns learned from your projects. To preserve it during updates:

```bash
# Backup learning database
./.claude/scripts/backup-state.sh

# Update
cd .claude
git pull origin main

# Restore learning database
cp backups/backup-TIMESTAMP/learning/*.json learning/
```

## Uninstallation

To remove the agent system:

```bash
# Backup learning database first (optional)
./.claude/scripts/backup-state.sh

# Remove the directory
rm -rf .claude
```

## Integration with Existing Claude Code Setup

If you already have custom agents or skills:

### Merge Approach

```bash
# Clone to temporary location
git clone https://github.com/yourusername/claude-agent-system.git /tmp/claude-agents

# Merge agents (keeps existing ones)
cp /tmp/claude-agents/agents/* .claude/agents/

# Merge skills (keeps existing ones)
cp /tmp/claude-agents/skills/* .claude/skills/

# Copy scripts
cp /tmp/claude-agents/scripts/* .claude/scripts/

# Make executable
chmod +x .claude/scripts/*.sh

# Initialize (creates state/learning if missing)
./.claude/scripts/init-project.sh
```

## Next Steps

After successful installation:

1. Read the [Usage Guide](.claude/USAGE_GUIDE.md)
2. Review the [Architecture Overview](.claude/README.md)
3. Try a simple example project
4. Explore agent capabilities
5. Start building!

## Support

If you encounter issues:

1. Check [Troubleshooting](#troubleshooting) section
2. Run verification script: `./.claude/scripts/verify-installation.sh`
3. Check GitHub Issues
4. Open a new issue with verification output

---

**Ready to build world-class software!** 🚀
