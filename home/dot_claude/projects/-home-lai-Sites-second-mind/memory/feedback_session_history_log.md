---
name: Session history log
description: Refined timeline of what happened across all Second Mind sessions — decisions, builds, pivots
type: project
---

### Session 1 — Mar 28 | Project setup
- Moved Python standards to skill, created README, merged PR #3

### Session 2 — Mar 28 | Status check
- Phase 0 NOT STARTED. Code exists but no data.

### Session 3 — Apr 4 | Export pipeline build
- Evernote converter (pure Python, 12 tests). Notion converter (markdown + CSV, 24 tests).

### Session 4 — Apr 4 | Research intake
- Karpathy #32, Apple Notes #34, ChatGPT #10, Obsidian-Mind #36

### Session 5 — Apr 4 | Real exports
- Ran converters on real data. Added dedup, fixed subdirectory walking.

### Session 6 — Apr 4 | Three Bodies
- Mapped framework onto Second Mind. Built ThreeBodies.jsx frontend page.

### Session 7 — Apr 4 | Git cleanup
- Excluded exports/ from git (100MB limit hit)

### Session 8 — Apr 4-6 | Verification + architecture
- 873 Evernote + 9,790 Notion = ~10,689 files, ~740K words, ~5.5 MB
- Two-database decision (private.db + public.db)
- Hook vs skill vs memory vs CLAUDE.md philosophy
- Failed changelog hook → reverted

### Session 9 — Apr 5-6 | Obsidian validation
- Files pass format check. Date preservation problem on Linux.

### Session 10 — Apr 6-7 | Core needs + communication (current)
- 4 core needs identified (#37-#40): Memory, Learning, Singularity, Mundane+Companion
- Karpathy LLM Knowledge Bases research (#41) — may replace RAG
- qwe-qwe patterns (#42) — meta-tools, hybrid search, Telegram bot
- Readability standard (#43) — TL;DR first, progressive depth
- Communication block (#45) — how we talk to each other

**Why:** This log helps future sessions pick up where we left off without re-reading raw conversations.
**How to apply:** Check this before asking "what were we working on?" — the answer is here.
