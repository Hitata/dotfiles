---
name: focused-read
description: ADHD-friendly article reader. Use whenever the user pastes a URL alone, says "read this", "focused read", "help me read", "adhd read", or wants a long article reformatted with key entities and load-bearing phrases highlighted for easier scanning. Fetches the article, has Claude apply *signaling-principle* emphasis (named entities, numbers, dates, and the single most informative noun phrase per paragraph — capped at ~12% of words), and opens a self-contained HTML viewer with a toggle so the user can compare Plain vs Highlighted side by side. Also saves a Markdown copy under ~/second-mind/reads/ for Obsidian.
---

# focused-read

Reading-assist skill that produces an HTML viewer with a "Highlight ON/OFF" toggle plus a Markdown copy for Obsidian. Design is based on the *signaling principle* (Schneider et al. 2018 meta-analysis, g+ = 0.53 for retention) — NOT Bionic Reading (decisively refuted in 2024–2025 by Snell, Spear, Beelders, Možina).

## When to use

- User pastes a URL with no other context
- User says: "read this", "focused read", "adhd read", "help me read", "make this readable", "highlight this article"
- User wants an Obsidian-friendly highlighted version of long-form text

## What NOT to do

- Do NOT bold the first half of each word (Bionic Reading) — refuted
- Do NOT alter the article's wording — only wrap existing words in `**...**`
- Do NOT bold function words alone (articles, prepositions, auxiliaries) — they belong unbolded
- Do NOT exceed ~12% of total words bolded (over-signaling kills the retention effect)
- Do NOT skip negation, modals, or quantifiers (`not`, `no`, `never`, `must`, `should`, `all`, `none`) — these are function-word-ish but content-bearing

## Workflow

1. **Extract.** Run `~/.claude/skills/focused-read/extract.py <url_or_textfile>`. It prints clean Markdown to stdout, plus the slug + title as the first comment line (`<!-- slug: foo, title: Bar -->`).

2. **Save plain copy.** Write the extracted Markdown to `~/second-mind/reads/<slug>.plain.md`.

3. **Produce highlighted version.** Re-emit the *same* Markdown, wrapping selected spans in `**...**`. Selection rules:
   - All named entities (people, organizations, places, products, technical terms)
   - All numbers, dates, percentages, measurements
   - For each paragraph: the single noun phrase that carries the paragraph's main claim
   - Preserve negation / modal / quantifier words inside or adjacent to those phrases
   - Density target: 8–15% of total words. If you exceed 15%, prune to entities + numbers only
   - Do not double-bold (don't wrap a span already inside another `**...**`)
   - Do not alter punctuation, capitalization, or word order
   - Markdown structure (headings, lists, links, code blocks) stays exactly as-is
   Save to `~/second-mind/reads/<slug>.highlight.md`.

4. **Render HTML.** Run `~/.claude/skills/focused-read/render.py <slug>`. Produces `~/second-mind/reads/<slug>.html` — a self-contained file with Plain ↔ Highlight toggle, font-size knob, and dark/light auto.

5. **Open.** Run `xdg-open ~/second-mind/reads/<slug>.html` (or `open` on macOS).

6. **Report.** Tell the user the title, the path, and how many spans got highlighted (rough count of `**` pairs in the highlight file). Do not paste the article back.

## Input variants

- **URL:** `extract.py https://example.com/article`
- **Raw text from conversation:** write user's text to `/tmp/focused-read-input.md`, then `extract.py /tmp/focused-read-input.md` (it auto-detects local files and just normalizes).
- **Already-Markdown text:** same as raw text — extract.py is idempotent on Markdown.

## Iteration roadmap

Iteration 1 (current): plain ↔ highlight toggle. Claude does the NLP pass.

Iteration 2 (when asked): local spaCy NER pipeline (no Claude call), dim mode for function words, density slider, Obsidian plugin export.
