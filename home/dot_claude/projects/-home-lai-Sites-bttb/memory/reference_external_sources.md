---
name: External sources and integrations lai points to repeatedly
description: URLs, services, and third-party sources that recur in bttb work
type: reference
originSessionId: 2dacac48-7094-4ebe-8f2f-186495a62d6d
---
- **lyso.vn** — primary Vietnamese Tử Vi reference site. lai scrapes consultation threads from there using Playwright CLI. Originally stored as markdown in `docs/tuvi-consultations/` (filename pattern `{username}_p{postid}.md`), now migrated into Supabase (fields: `source`, `consultant`, `date`, `tags`) and browsable at `/tu-vi/consultations`. Markdown files are git-ignored. Key URL: `https://lyso.vn/xem-tu-vi/tu-van-tu-vi-giai-phap-don-lanh-tranh-du-t2074/`.

- **huyencodieuly** — late Vietnamese Tử Vi master on lyso.vn. Basis for the `tuvi-reading-huyencodieuly` skill. When reading in his voice, default to "learn-while-reading" mode: show the *why* (cung + tượng + life translation) so lai can study the reasoning, not just receive a verdict. Hide the reasoning only if he explicitly asks for "chỉ kết luận" / "đọc gọn".

- **darsana.trungth.com** — production deployment; doubles as his preview during development via Cloudflare Tunnel.

- **Obsidian** — lai reads scraped consultation markdown locally in Obsidian. Keep Obsidian-friendly formatting for any markdown he'll consume directly.

- **Source folders**: `/tuvi/` and `docs/tuvi-consultations/` are Tử Vi textbook input. When he says "look at /tuvi folder", he means repo reference materials, **not** the `/tu-vi/` Next.js route.
