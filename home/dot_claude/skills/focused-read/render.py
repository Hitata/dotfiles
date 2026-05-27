#!/usr/bin/env python3
"""Render <slug>.highlight.md + <slug>.plain.md → self-contained HTML viewer.

Toggle Plain ↔ Highlight via a single class on <body>. Font-size knob.
Reports highlight density (% words bolded) and span count to stdout.
"""
import re
import sys
from pathlib import Path

import markdown as md_lib

READS = Path.home() / "second-mind" / "reads"

HTML_TEMPLATE = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
  :root {{
    --bg: #fafaf7;
    --fg: #1d1d1b;
    --muted: #6b6b66;
    --mark: #f3d77a;      /* warm highlight */
    --mark-fg: #1d1d1b;
    --rule: #e5e3dc;
    --accent: #b54a1f;
    --bar: #ffffffd9;
    --code-bg: #efece4;
  }}
  @media (prefers-color-scheme: dark) {{
    :root {{
      --bg: #14141a;
      --fg: #e8e6dd;
      --muted: #8a8780;
      --mark: #5c4a1c;
      --mark-fg: #fff6d2;
      --rule: #2a2a32;
      --accent: #ff9b6a;
      --bar: #1c1c24d9;
      --code-bg: #1f1f27;
    }}
  }}
  * {{ box-sizing: border-box; }}
  html, body {{ margin: 0; padding: 0; background: var(--bg); color: var(--fg); }}
  body {{
    font-family: -apple-system, "SF Pro Text", Inter, "Segoe UI", system-ui, sans-serif;
    font-size: var(--font-size, 19px);
    line-height: 1.7;
    -webkit-font-smoothing: antialiased;
  }}
  .bar {{
    position: sticky; top: 0; z-index: 50;
    backdrop-filter: blur(14px); -webkit-backdrop-filter: blur(14px);
    background: var(--bar);
    border-bottom: 1px solid var(--rule);
    padding: 10px 24px;
    display: flex; align-items: center; gap: 14px; flex-wrap: wrap;
  }}
  .bar h1 {{
    font-size: 13px; font-weight: 600; margin: 0; color: var(--muted);
    text-transform: uppercase; letter-spacing: 0.06em;
    flex: 1 1 auto; min-width: 0;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
  }}
  .bar .stat {{ color: var(--muted); font-size: 12px; font-variant-numeric: tabular-nums; }}
  .toggle {{
    display: inline-flex; align-items: center; gap: 6px;
    padding: 6px 12px; border-radius: 999px;
    border: 1px solid var(--rule); background: transparent;
    color: var(--fg); cursor: pointer; font: inherit; font-size: 13px;
    transition: background 120ms;
  }}
  .toggle:hover {{ background: var(--rule); }}
  .toggle.on {{ background: var(--accent); color: white; border-color: var(--accent); }}
  .toggle.on:hover {{ filter: brightness(1.05); }}
  .size {{ display: inline-flex; gap: 4px; }}
  .size button {{
    width: 28px; height: 28px; padding: 0; border-radius: 8px;
    border: 1px solid var(--rule); background: transparent; cursor: pointer;
    color: var(--fg); font: inherit; font-size: 13px;
  }}
  .size button:hover {{ background: var(--rule); }}
  main {{
    max-width: 720px; margin: 0 auto; padding: 48px 24px 96px;
  }}
  main h1 {{ font-size: 1.9em; line-height: 1.2; margin: 0 0 0.6em; }}
  main h2 {{ font-size: 1.35em; margin: 1.8em 0 0.6em; }}
  main h3 {{ font-size: 1.1em; margin: 1.4em 0 0.5em; }}
  main p, main li {{ margin: 0 0 1.05em; }}
  main a {{ color: var(--accent); text-decoration: underline; text-underline-offset: 3px; }}
  main blockquote {{
    margin: 1.2em 0; padding: 0.4em 1em; border-left: 3px solid var(--accent);
    color: var(--muted);
  }}
  main code {{
    background: var(--code-bg); padding: 0.12em 0.4em; border-radius: 4px;
    font-size: 0.92em;
  }}
  main pre {{
    background: var(--code-bg); padding: 14px 18px; border-radius: 8px;
    overflow-x: auto; line-height: 1.5;
  }}
  main pre code {{ background: transparent; padding: 0; font-size: 0.88em; }}
  main hr {{ border: none; border-top: 1px solid var(--rule); margin: 2.4em 0; }}
  main table {{ border-collapse: collapse; margin: 1.2em 0; }}
  main th, main td {{ border: 1px solid var(--rule); padding: 6px 10px; text-align: left; }}
  /* Highlight rendering */
  mark {{
    background: var(--mark); color: var(--mark-fg);
    padding: 0.04em 0.18em; border-radius: 3px;
    box-decoration-break: clone; -webkit-box-decoration-break: clone;
  }}
  body.plain mark {{
    background: transparent; color: inherit; padding: 0;
  }}
</style>
</head>
<body class="highlight">
<div class="bar">
  <h1>{title}</h1>
  <span class="stat">{density}% highlighted · {spans} spans · {words} words</span>
  <button class="toggle on" id="t" onclick="toggle()">Highlight</button>
  <div class="size">
    <button onclick="bump(-1)">A−</button>
    <button onclick="bump(+1)">A+</button>
  </div>
</div>
<main>
{body}
</main>
<script>
  function toggle() {{
    const b = document.body, t = document.getElementById('t');
    if (b.classList.contains('plain')) {{ b.classList.remove('plain'); t.classList.add('on'); t.textContent='Highlight'; }}
    else {{ b.classList.add('plain'); t.classList.remove('on'); t.textContent='Plain'; }}
  }}
  function bump(d) {{
    const root = document.documentElement;
    const cur = parseFloat(getComputedStyle(document.body).fontSize);
    root.style.setProperty('--font-size', (cur + d) + 'px');
    localStorage.setItem('focused-read-size', cur + d);
  }}
  const saved = localStorage.getItem('focused-read-size');
  if (saved) document.documentElement.style.setProperty('--font-size', saved + 'px');
</script>
</body>
</html>
"""


def strip_meta_comment(text: str) -> tuple[str, str]:
    """Return (title, body_without_header)."""
    m = re.match(r"^<!--\s*slug:\s*([^|]+?)\s*\|\s*title:\s*(.+?)\s*-->\s*\n", text)
    if m:
        return m.group(2).strip(), text[m.end():]
    return "Article", text


def main() -> None:
    if len(sys.argv) != 2:
        sys.exit("usage: render.py <slug>")
    slug = sys.argv[1]
    hi_path = READS / f"{slug}.highlight.md"
    pl_path = READS / f"{slug}.plain.md"
    if not hi_path.exists():
        sys.exit(f"missing: {hi_path}")
    if not pl_path.exists():
        sys.exit(f"missing: {pl_path}")

    hi_raw = hi_path.read_text(encoding="utf-8")
    pl_raw = pl_path.read_text(encoding="utf-8")
    title, hi_body = strip_meta_comment(hi_raw)
    _, _ = strip_meta_comment(pl_raw)  # currently unused; reserved for future diff view

    # Density stats from highlight source (count words inside **...**)
    bolded_spans = re.findall(r"\*\*(.+?)\*\*", hi_body, flags=re.DOTALL)
    bolded_words = sum(len(re.findall(r"\w+", s)) for s in bolded_spans)
    total_words = len(re.findall(r"\w+", re.sub(r"\*\*(.+?)\*\*", r"\1", hi_body, flags=re.DOTALL)))
    density = round((bolded_words / total_words) * 100, 1) if total_words else 0.0

    # Render Markdown → HTML; rely on python-markdown's strong→<strong>, then
    # rewrite <strong> → <mark> so the CSS toggle controls highlighting.
    extensions = ["extra", "tables", "fenced_code", "sane_lists", "smarty"]
    html_body = md_lib.markdown(hi_body, extensions=extensions, output_format="html5")
    html_body = re.sub(r"<strong>(.*?)</strong>", r"<mark>\1</mark>", html_body, flags=re.DOTALL)

    out = HTML_TEMPLATE.format(
        title=title.replace("<", "&lt;").replace(">", "&gt;"),
        density=density,
        spans=len(bolded_spans),
        words=total_words,
        body=html_body,
    )
    out_path = READS / f"{slug}.html"
    out_path.write_text(out, encoding="utf-8")
    print(f"{out_path}\t{density}%\t{len(bolded_spans)} spans\t{total_words} words")


if __name__ == "__main__":
    main()
