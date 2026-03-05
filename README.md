# Claw Git Memory

Persistent memory system for OpenClaw agents using Git-based file storage.

## What is this?

This skill sets up a persistent, version-controlled memory system for OpenClaw agents:
- **MEMORY.md** - Long-term curated memories that persist across sessions
- **memory/*.md** - Daily session logs for temporal tracking  
- **Git versioning** - Automatic commits for history and backup

## Quick Start

### Install

```bash
clawhub install claw-git-memory
```

### Initialize Memory System

```bash
# Create directory structure
mkdir -p ~/.openclaw/workspace/memory

# Create MEMORY.md
cat > ~/.openclaw/workspace/MEMORY.md << 'EOF'
# MEMORY.md - Long-term Memory

## Core Identity
- Assistant Name: [Your Name]
- Emoji: [Your Emoji]

## User Preferences
- Name: Master
- Timezone: Asia/Shanghai (GMT+8)

## Active Projects
<!-- Add ongoing projects here -->
EOF

# Create initial daily log
cat > ~/.openclaw/workspace/memory/$(date +%Y-%m-%d).md << 'EOF'
# $(date +%Y-%m-%d) - Session Log

## Summary
Initial setup of memory system.

## Key Events
1. Initialized memory structure

## Decisions Made
- Storage: Filesystem + Git
EOF
```

### Initialize Git

```bash
cd ~/.openclaw/workspace
git init
git add MEMORY.md memory/
git commit -m "Initial memory setup"
```

### Set Up Auto-Commit

Create `HEARTBEAT.md`:

```bash
cat > ~/.openclaw/workspace/HEARTBEAT.md << 'EOF'
# HEARTBEAT.md - Periodic Tasks

## Auto-Commit Memory Changes

**Frequency:** Every ~30 minutes during active sessions
**Action:** Check for uncommitted memory changes and auto-commit

### Manual Commands

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

## Usage

### Check Memory Statistics

```bash
bash skills/git-memory/scripts/memory_stats.sh
```

Output:
```
📊 Memory Statistics
=====================
Daily logs:        5 files (20K)
Long-term memory:  42 lines (4.0K)

📝 Git Status
Total commits: 12
✅ All memory changes committed
Last commit: abc1234 - Auto-commit: memory update (2 minutes ago)
```

### Manual Commit

```bash
bash skills/git-memory/scripts/auto_commit.sh
```

### Push to Remote (Optional)

```bash
cd ~/.openclaw/workspace
# Add remote first
git remote add origin https://github.com/yourusername/your-repo.git
# Push
git push -u origin main
```

## File Structure

```
~/.openclaw/workspace/
├── MEMORY.md              # Long-term curated memory
├── memory/
│   ├── 2026-03-05.md      # Daily session log
│   ├── 2026-03-04.md
│   └── ...
├── HEARTBEAT.md           # Periodic task configuration
└── .git/                  # Git repository
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

### Remote Not Configured
```bash
cd ~/.openclaw/workspace
git remote add origin https://github.com/yourusername/your-repo.git
```

### Permission Denied on Push
- Check your GitHub/GitLab credentials
- Ensure you have write access to the repository
- For HTTPS, you may need a personal access token

## Resources

- **SKILL.md**: Full technical documentation
- **scripts/auto_commit.sh**: Automated commit script
- **scripts/memory_stats.sh**: Memory statistics tool

## License

MIT