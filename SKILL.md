---
name: git-memory
description: Persistent memory storage system using file-based storage with Git versioning. Use when setting up agent memory persistence, configuring Git-based memory storage, or managing structured memory files (MEMORY.md for long-term memories and memory/YYYY-MM-DD.md for daily session logs). Triggers on discussions about agent memory storage, Git backup for memories, or file-based memory organization.
---

# Git Memory

## Overview

This skill sets up a persistent, version-controlled memory system for agents using:
- **MEMORY.md**: Long-term curated memories that persist across sessions
- **memory/*.md**: Daily session logs for temporal tracking
- **Git versioning**: Automatic commits for history and backup

## When to Use

Use this skill when:
- Setting up memory persistence for a new agent
- Configuring Git-based backup for agent memories
- Managing structured memory file organization
- Migrating from ephemeral to persistent memory

## Quick Start

### 1. Initialize Memory Structure

```bash
# Create memory directory structure
mkdir -p ~/.openclaw/workspace/memory

# Create MEMORY.md (long-term memory)
cat > ~/.openclaw/workspace/MEMORY.md << 'EOF'
# MEMORY.md - Long-term Memory

This file contains curated, important memories that should persist across sessions.

## Core Identity
- Assistant Name: Sammy
- Creature: AI assistant with a free spirit
- Emoji: 🐾

## User Preferences (Master)
- Name: Master
- Timezone: Asia/Shanghai (GMT+8)
- Language: Bilingual (Chinese/English)

## Key Decisions
- Memory storage: File-based with Git versioning
- Sync: Private repository for security

## Active Projects
<!-- Add ongoing projects here -->

## Notes to Self
<!-- Things I should remember -->
EOF

# Create initial daily log
cat > ~/.openclaw/workspace/memory/$(date +%Y-%m-%d).md << 'EOF'
# $(date +%Y-%m-%d) - Session Log

## Summary
Initial setup of memory system with Git-based storage.

## Key Events
1. Initialized memory structure
2. Created MEMORY.md and daily log

## Decisions Made
- Storage: Filesystem + Git
- Repository: Private for security

## Next Steps
- Initialize Git repository
- Set up auto-commit
EOF
```

### 2. Initialize Git Repository

```bash
cd ~/.openclaw/workspace

# Initialize Git
git init

# Add memory files
git add MEMORY.md memory/

# Initial commit
git commit -m "Initial memory setup: file-based storage with Git versioning"
```

### 3. Set Up Auto-Commit

Create `HEARTBEAT.md` to enable periodic auto-commits:

```bash
cat > ~/.openclaw/workspace/HEARTBEAT.md << 'EOF'
# HEARTBEAT.md - Periodic Tasks

## Auto-Commit Memory Changes

**Frequency:** Every ~30 minutes during active sessions
**Action:** Check for uncommitted memory changes and auto-commit

### Manual Commands Reference

```bash
# Check status
cd ~/.openclaw/workspace && git status

# Manual commit
cd ~/.openclaw/workspace && git add MEMORY.md memory/ && git commit -m "Update memory: $(date '+%Y-%m-%d %H:%M')"

# View history
cd ~/.openclaw/workspace && git log --oneline
```
EOF
```

## Memory File Structure

### MEMORY.md (Long-term Memory)

- **Purpose**: Curated, important memories that persist across sessions
- **Content**: Core identity, user preferences, key decisions, active projects
- **Lifetime**: Permanent (unless explicitly archived)

### memory/YYYY-MM-DD.md (Daily Logs)

- **Purpose**: Raw session logs for temporal tracking
- **Content**: Daily events, decisions, conversation snippets
- **Lifetime**: Rotating (e.g., keep last 30 days locally, archive older)

## Git Workflow

### Automatic (via HEARTBEAT.md)
- Periodic checks for uncommitted changes
- Auto-commit with timestamp message
- Optional: push to remote

### Manual Commands
```bash
# Check status
git status

# Add and commit
git add MEMORY.md memory/
git commit -m "Manual memory update"

# Push to remote (if configured)
git push origin main
```

## Remote Backup (Optional)

To sync to GitHub/GitLab private repository:

```bash
# Create private repo on GitHub, then:
git remote add origin https://github.com/username/memory-backup.git
git branch -M main
git push -u origin main
```

## Best Practices

1. **Commit Granularity**: Commit after significant memory updates, not every tiny change
2. **Message Clarity**: Use descriptive commit messages (e.g., "Add project X to active projects")
3. **Regular Review**: Periodically review and prune MEMORY.md to keep it relevant
4. **Privacy First**: Keep repository private; memories may contain personal information
5. **Backup Strategy**: For critical memories, consider pushing to remote regularly

## Troubleshooting

### Git Not Initialized
```bash
cd ~/.openclaw/workspace && git init
```

### Forgot to Commit
No problem - changes are still there. Just commit now:
```bash
git add MEMORY.md memory/
git commit -m "Catch up commit"
```

### Merge Conflicts (rare for single-user)
```bash
git status
# Manually resolve conflicts, then:
git add .
git commit -m "Resolve merge conflict"
```

## Resources

- **scripts/**: Utility scripts for memory management
  - `auto_commit.sh`: Automated commit script
  - `memory_stats.sh`: Display memory statistics
