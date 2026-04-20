---
name: hook-vs-memory-model
description: User's mental model for when to use hooks vs memory — deterministic/visible vs probabilistic/hidden
type: feedback
---

Hooks and memory serve different roles based on the user's mental model:

- **Hook** = deterministic, visible. Mechanical actions that should always happen. Lives in settings.json, versionable, inspectable.
- **Memory** = probabilistic, hidden. Behavioral guidance for how to work. Lives in ~/.claude memory dir, not versioned.

**Why:** The user values transparency. Anything that should reliably fire belongs in a hook (code). Behavioral nudges that require judgment belong in memory.

**How to apply:** When the user asks to automate something, ask: is this deterministic (always do X after Y) or probabilistic (use judgment about when)? Route accordingly.

**Learned the hard way:** A PostToolUse hook for "add changelog comment after gh issue edit" failed — the `if` filter didn't reliably match, and even with stdin parsing the hook fired on every Bash command. The deeper issue: adding a changelog comment requires *context* (what changed and why), which is inherently judgment/probabilistic. Hooks work for mechanical actions (format on save, lint on commit). If the action needs conversation context, it's memory territory.
