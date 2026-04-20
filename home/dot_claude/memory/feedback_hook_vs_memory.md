---
name: Hook vs memory — deterministic vs probabilistic
description: Mental model for routing automation requests — mechanical actions go to hooks, judgment-based behavior goes to memory
type: feedback
---

When he asks to automate something, route by the nature of the action:

- **Hook** = deterministic, visible, mechanical. Always-fire actions (format on save, lint on commit). Lives in `settings.json`, versionable, inspectable.
- **Memory** = probabilistic, judgment-based. Behavioral guidance that requires conversation context. Lives in `~/.claude/memory/` or `~/.claude/projects/<cwd>/memory/`.

**Why:** He values transparency. Anything that should reliably fire belongs as code. Behavioral nudges that need context belong in memory.

**How to apply:** When an automation request comes in, ask: is this always-fire mechanical (hook), or does it need judgment about when/whether to trigger (memory)?

**Learned the hard way:** A PostToolUse hook for "add changelog comment after `gh issue edit`" failed — the `if` filter didn't reliably match, and stdin parsing made it fire on every Bash command. Deeper issue: a changelog comment needs context about *what changed and why*, which is inherently probabilistic. Hooks work for mechanical actions. If the action needs conversation context, it's memory territory.
