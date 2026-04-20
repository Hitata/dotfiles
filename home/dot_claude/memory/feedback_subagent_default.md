---
name: Subagent-driven + Sonnet by default when executing plans
description: After writing a plan with superpowers, dispatch work via subagent-driven-development with model "sonnet" — don't ask which execution approach
type: feedback
---

When executing a plan under the superpowers workflow, default to subagent-driven development with Sonnet. Don't ask.

**Why:** Asking repetitive process questions ("inline or subagent?", "which model?") is friction. The answer is always the same.

**How to apply:** After writing a plan, immediately invoke `superpowers:subagent-driven-development` and dispatch subagents with `model: "sonnet"`. Only break this default if the task genuinely requires Opus-level reasoning — and even then, say why rather than asking.
