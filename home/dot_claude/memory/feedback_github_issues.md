---
name: GitHub issue conventions — clickable links, proactive changelog comments
description: Reference issues as owner/repo#N so they render clickably, and log decisions as comments on the relevant issue without waiting to be asked
type: feedback
---

Two rules when working with GitHub issues:

1. **Link format.** When mentioning an issue number in text output, use the full `Hitata/<repo>#N` form (e.g., `Hitata/second-mind#41`), not just `#41`. The full form renders as a clickable link he can click through immediately; bare `#41` does not.

2. **Proactive changelog comments.** When a decision or architectural choice is made during conversation that relates to an existing issue, log it as a comment on that issue — don't wait to be asked. When updating an issue *body*, also post a comment explaining what changed and why.

**Why:** Issue bodies capture the current truth; comments capture how thinking evolved. Without the comment trail, future-him has no context for why things changed. He also wants to jump straight to the issue when he sees a reference.

**How to apply:**
- Every issue mention in conversation output → `owner/repo#N` format.
- After every issue body edit → `gh issue comment` summarizing the change and reason.
- When a scope/architecture decision comes up and it maps to an issue → comment on the issue with the decision + reasoning. If no issue exists and the decision is significant, flag it so he can decide whether to create one.
