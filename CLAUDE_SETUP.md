# Claude Code setup

Claude Code config is chezmoi-managed under `home/dot_claude/` → `~/.claude/`.
This includes `CLAUDE.md` (global instructions), `settings.json`, subagents,
slash commands, and memory.

## Status line (token usage)

```bash
npx ccstatusline@latest
```

## Skills

Installed via `npx skills add <source>`. Current sources:

- `vercel-labs/agent-skills` — React / Next.js / Vercel patterns

Find a skill by topic:

```
/find-skills
```

## Notable skills in rotation

| Skill | Use |
|---|---|
| `superpowers:brainstorm` | Open-ended problem framing |
| `superpowers:subagent-driven-development` | Dispatch subagents for parallel work |
| `ui-ux-pro-max` | UI/UX critique + design passes |
| `code-review:code-review` | Structured review of a diff or PR |

## Telegram notifications

See [CLAUDE_TELEGRAM.md](CLAUDE_TELEGRAM.md) for the hook setup that pings
Telegram on task completion and tool failures.

## Memory

Two-tier memory (global + project-scoped) under `~/.claude/memory/` and
`~/.claude/projects/<cwd>/memory/`. See `home/dot_claude/CLAUDE.md` for the
operating rules.
