#!/bin/bash
# memory_stats.sh - Display memory statistics

WORKSPACE_DIR="${1:-$HOME/.openclaw/workspace}"
cd "$WORKSPACE_DIR"

echo "📊 Memory Statistics"
echo "====================="
echo ""

# Memory files count
MEMORY_FILES=$(find memory -name "*.md" 2>/dev/null | wc -l)
MEMORY_SIZE=$(du -sh memory 2>/dev/null | cut -f1)
echo "Daily logs: $MEMORY_FILES files ($MEMORY_SIZE)"

# Long-term memory
if [ -f MEMORY.md ]; then
    MEMORY_LINES=$(wc -l < MEMORY.md)
    MEMORY_MD_SIZE=$(du -sh MEMORY.md | cut -f1)
    echo "Long-term memory: $MEMORY_LINES lines ($MEMORY_MD_SIZE)"
fi

echo ""

# Git status
if [ -d .git ]; then
    echo "📝 Git Status"
    COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    echo "Total commits: $COMMIT_COUNT"
    
    # Check for uncommitted changes
    if ! git diff --quiet MEMORY.md memory/ 2>/dev/null; then
        echo "⚠️  Uncommitted memory changes detected"
    else
        echo "✅ All memory changes committed"
    fi
    
    # Last commit
    LAST_COMMIT=$(git log -1 --format="%h - %s (%ar)" 2>/dev/null)
    if [ -n "$LAST_COMMIT" ]; then
        echo "Last commit: $LAST_COMMIT"
    fi
else
    echo "⚠️  Git not initialized"
fi

echo ""
echo "💾 Total Memory Size: $(du -sh . 2>/dev/null | cut -f1)"
