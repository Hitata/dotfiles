---
name: bttb project shape — multi-system Vietnamese astrology app
description: Product direction, audiences, hosting, and architectural decisions that aren't recoverable from code
type: project
originSessionId: 2dacac48-7094-4ebe-8f2f-186495a62d6d
---
bttb is a multi-system Vietnamese astrology app covering Tử Vi, Bát Tự, I Ching / Kinh Dịch, Numerology, and Human Design — each with its own `/learn` sub-tree modeled after a textbook (chapter 1, 2, 3...).

**Why:** This shape emerged from how lai teaches and practices — he treats each system as a distinct study track, with consultation archives, interactive chart tools, and learn chapters built side by side.

**How to apply:**
- Production domain: `darsana.trungth.com`, tunneled via Cloudflare Tunnel. If the site is unreachable, first suspect the tunnel, then cache.
- Two audiences — (1) **admin (lai)** sees full reading list + client profiles + token generation; (2) **clients/friends** access token-gated chat sessions. The readings list is deliberately admin-only ("I don't want other people to be able to see"). Keep this split when adding new features.
- Planned client-chat feature: 10 questions per token, spins up a local Claude Code CLI per request that loads the client's saved reading + thread history. Built on top of Claude Max subscription — prefer Sonnet/Haiku over Opus for that loop to stay in budget.
- Database: **Supabase production only**. No local DB — lai explicitly asked for local DB removal. Use Supabase CLI for migrations.
- Design system: Ngũ Hành (5-element) colors live in global CSS variables so the palette can be tuned site-wide. All consultation pages must follow the site design system.
