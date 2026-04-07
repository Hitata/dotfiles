# Claude Code → Telegram Notifications

Setup for automatic Telegram notifications when Claude Code tasks complete or errors occur.

## Configuration

### 1. Bot Token & Chat ID
- **Bot Token**: Stored in `~/.config/telegram-bot-token`
- **Chat ID**: `5657771153`

### 2. Notification Script
Location: `~/.local/bin/notify-telegram`

```bash
#!/bin/bash
TOKEN=$(cat ~/.config/telegram-bot-token)
CHAT_ID="5657771153"
MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
  echo "Usage: notify-telegram 'Your message'"
  exit 1
fi

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=${MESSAGE}" > /dev/null

echo "Notification sent to Telegram"
```

### 3. Hooks Configuration
Configured in `~/.claude/settings.json` under the `hooks` section:

#### TaskCompleted Hook
Sends a notification when a task completes with:
- Task name/subject
- Project folder name

```json
"TaskCompleted": [
  {
    "hooks": [
      {
        "type": "command",
        "command": "jq -r '\"Task completed\\n📋 \" + (.task_name // .subject // \"Task\") + \"\\n📁 \" + ((.cwd // \"unknown\") | split(\"/\") | .[-1])' | { read -r msg; notify-telegram \"$msg\"; } 2>/dev/null || true"
      }
    ]
  }
]
```

**Example notification:**
```
Task completed
📋 Fix authentication bug
📁 dotfiles
```

#### PostToolUseFailure Hook
Sends a notification when a tool (Bash, Read, Edit, etc.) fails with an error.

```json
"PostToolUseFailure": [
  {
    "hooks": [
      {
        "type": "command",
        "command": "jq -r '.tool_response.error // .tool_response // \"Tool failed\"' | { read -r err; notify-telegram \"Error: $err\"; } 2>/dev/null || true"
      }
    ]
  }
]
```

#### StopFailure Hook
Sends a notification when a session encounters a critical error.

```json
"StopFailure": [
  {
    "hooks": [
      {
        "type": "command",
        "command": "jq -r '.error // \"Session error\"' | { read -r err; notify-telegram \"Error: $err\"; } 2>/dev/null || true"
      }
    ]
  }
]
```

## Manual Usage

Send a notification from the command line:
```bash
notify-telegram "Your message here"
```

## Security Notes

- Bot token is stored in `~/.config/telegram-bot-token` (not in version control)
- Chat ID is private
- Token is read from file each time (not hardcoded in scripts)

## Managing Hooks

To view or edit hooks in Claude Code:
- Use `/hooks` command in Claude Code
- Hooks can be disabled/enabled individually
- Configuration persists across sessions

## Testing

All three hooks have been tested and are working:
- ✓ TaskCompleted notification
- ✓ PostToolUseFailure notification
- ✓ StopFailure notification
