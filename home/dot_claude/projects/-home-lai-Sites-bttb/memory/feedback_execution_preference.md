---
name: Always use subagent execution with Sonnet
description: User prefers subagent-driven development with Sonnet model, never ask for execution choice
type: feedback
originSessionId: 2dacac48-7094-4ebe-8f2f-186495a62d6d
---
Always use subagent-driven development (not inline execution) when implementing plans. Use Sonnet model for subagents. Never ask which execution approach — just proceed with subagent-driven + Sonnet.

**Why:** User doesn't want to be asked repetitive process questions.

**How to apply:** After writing a plan, immediately invoke superpowers:subagent-driven-development and dispatch subagents with model: "sonnet".
