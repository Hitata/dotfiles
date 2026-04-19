---
name: How lai wants astrology content written
description: Depth of explanation, interactive visualizations, Vietnamese terminology, and diacritic hygiene
type: feedback
originSessionId: 2dacac48-7094-4ebe-8f2f-186495a62d6d
---
When building or writing astrology content, show derivations and keep Vietnamese terms in Vietnamese.

**Why:** lai is using the app as a study tool for himself and his clients. Content that just gives a verdict (not the *why*) is a missed teaching opportunity. He also flagged mojibake diacritics and English placeholders as bugs — UX copy must be natural Vietnamese.

**How to apply:**
- For astrology mechanics (Cục derivation, palace placement, Mệnh Chủ assignment, etc.), **show the formula + example**, not just the mapping. Example: "Cục = Canh + Thìn = Kim Tứ Cục; Tử Vi = Kim Tứ Cục + ngày 27 = Mùi" should be explained, not stated.
- In `/learn` pages, expect requests for **interactive visualizations** — drag-and-drop palace placement, square/circle toggles, color-coded Ngũ Hành sub-components. When adding a new chapter, anticipate that an interactive visual will follow.
- Keep Vietnamese astrology terms in Vietnamese in body copy (Mệnh, Thân, Tuần, Triệt, Tứ Hóa, chính tinh, phụ tinh, cách cục). English is fine for UI chrome and code identifiers.
- Placeholders and UX copy in natural Vietnamese (e.g., "bạn có muốn hỏi gì thêm ko?" not "Type your question").
- Watch for broken Vietnamese diacritics (`Th\u1ea7n S\u1ed1 H\u1ecdc` instead of "Thần Số Học") — if one page shows mojibake, sweep the whole section.
