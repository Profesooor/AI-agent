#!/bin/bash
# Backup learning database and state files

PROJECT_ROOT=$(pwd)
CLAUDE_DIR="$PROJECT_ROOT/.claude"
BACKUP_DIR="$CLAUDE_DIR/backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="$BACKUP_DIR/backup-$TIMESTAMP"

mkdir -p "$BACKUP_PATH"

echo "Creating backup at $BACKUP_PATH..."

# Backup state files
if [ -d "$CLAUDE_DIR/state" ]; then
    cp -r "$CLAUDE_DIR/state" "$BACKUP_PATH/"
    echo "✓ Backed up state files"
fi

# Backup learning database
if [ -d "$CLAUDE_DIR/learning" ]; then
    cp -r "$CLAUDE_DIR/learning" "$BACKUP_PATH/"
    echo "✓ Backed up learning database"
fi

# Backup knowledge files
if [ -d "$CLAUDE_DIR/knowledge" ]; then
    cp -r "$CLAUDE_DIR/knowledge" "$BACKUP_PATH/"
    echo "✓ Backed up knowledge files"
fi

# Create backup manifest
cat > "$BACKUP_PATH/manifest.txt" <<EOF
Backup created: $TIMESTAMP
Project: $(basename "$PROJECT_ROOT")
Contents:
- State files (progress, decisions, performance)
- Learning database (patterns, pitfalls, agent-performance)
- Knowledge files (architecture, requirements, conventions)
EOF

echo "✓ Backup complete: $BACKUP_PATH"

# Keep only last 10 backups
cd "$BACKUP_DIR"
ls -t | tail -n +11 | xargs -I {} rm -rf {}
echo "✓ Cleaned up old backups (keeping 10 most recent)"
