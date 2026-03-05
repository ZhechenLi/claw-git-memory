#!/bin/bash
# auto_commit.sh - Automatically commit memory changes if any exist

set -e

WORKSPACE_DIR="${1:-$HOME/.openclaw/workspace}"
cd "$WORKSPACE_DIR"

# Check if there are changes to memory files
if ! git diff --quiet MEMORY.md memory/ 2>/dev/null && \
   ! git diff --cached --quiet MEMORY.md memory/ 2>/dev/null; then
    
    echo "No memory changes to commit"
    exit 0
fi

# Add memory files
git add MEMORY.md memory/ 2>/dev/null || true

# Check if there are staged changes
if git diff --cached --quiet; then
    echo "No memory changes to commit"
    exit 0
fi

# Commit with timestamp
COMMIT_MSG="Auto-commit: memory update $(date '+%Y-%m-%d %H:%M')"
git commit -m "$COMMIT_MSG"

echo "Committed: $COMMIT_MSG"

# Optional: Push to remote if configured
if git remote get-url origin >/dev/null 2>&1; then
    git push origin main 2>/dev/null || git push origin master 2>/dev/null || true
    echo "Pushed to remote"
fi
