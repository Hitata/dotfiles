---
name: issue-changelog-comments
description: Always add changelog comment when updating GitHub issue body, and proactively log decisions from conversation to relevant issues
type: feedback
---

When a decision is made during conversation that relates to an existing GitHub issue, proactively log it as a comment on that issue — don't wait to be asked.

**Why:** The issue body is the current truth, but the comment trail is how thinking evolved. Without it, future-you has no context for why things changed. This was established after updating #6 (two-database architecture) without leaving a comment trail.

**How to apply:** 
1. When updating an issue body: always add a `gh issue comment` explaining what changed and why.
2. When a decision or architectural choice comes up in conversation: identify the relevant issue and comment on it with the decision + reasoning.
3. If no issue exists for the topic, mention it to the user — they may want one created.
