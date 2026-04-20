# Claude Code → Telegram notifications

Hook setup that pings a Telegram bot when Claude Code tasks finish or tools
fail. Bot token lives outside version control at `~/.config/telegram-bot-token`.

## Pieces

| Piece | Location |
|---|---|
| Bot token | `~/.config/telegram-bot-token` (gitignored) |
| Chat ID | Hardcoded in `notify-telegram` |
| Notifier script | `~/.local/bin/notify-telegram` |
| Hook wiring | `~/.claude/settings.json` → `hooks` |

## Notifier script

`~/.local/bin/notify-telegram`:

```bash
#!/bin/bash
TOKEN=$(cat ~/.config/telegram-bot-token)
CHAT_ID="5657771153"
MESSAGE="$1"

[ -z "$MESSAGE" ] && { echo "Usage: notify-telegram 'message'"; exit 1; }

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=${MESSAGE}" > /dev/null
```

Make it executable: `chmod +x ~/.local/bin/notify-telegram`.

## Hooks

All three are stanzas under `hooks` in `~/.claude/settings.json`. They pipe the
hook's JSON payload through `jq` to build a message and hand it to
`notify-telegram`. Errors are swallowed so a broken bot never blocks Claude.

### TaskCompleted — task name + project

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

### PostToolUseFailure — tool error

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

### StopFailure — session error

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

## Manual send

```bash
notify-telegram "your message"
```

## Managing from inside Claude Code

`/hooks` — view, toggle, or edit hooks. Changes persist across sessions.
