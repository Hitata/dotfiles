#!/usr/bin/env python3
"""Extract article from URL or normalize local Markdown/text → clean Markdown on stdout.

First line of output is an HTML comment with `slug` and `title` for downstream use.
"""
import os
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

import trafilatura


def slugify(title: str, fallback: str = "article") -> str:
    s = (title or fallback).lower().strip()
    s = re.sub(r"[^a-z0-9]+", "-", s)
    s = s.strip("-")[:60]
    return s or fallback


def from_url(url: str) -> tuple[str, str, str]:
    html = trafilatura.fetch_url(url)
    if not html:
        sys.exit(f"fetch failed: {url}")
    md = trafilatura.extract(
        html,
        output_format="markdown",
        with_metadata=True,
        include_links=True,
        include_images=False,
        include_tables=True,
        favor_recall=True,
    )
    if not md:
        sys.exit(f"extract failed: {url}")
    meta = trafilatura.extract_metadata(html)
    title = (meta.title if meta and meta.title else urlparse(url).path.rsplit("/", 1)[-1]) or "article"
    slug = slugify(title, urlparse(url).netloc.replace(".", "-"))
    return slug, title, md.strip()


def from_file(path: str) -> tuple[str, str, str]:
    p = Path(path).expanduser().resolve()
    text = p.read_text(encoding="utf-8")
    # Try to lift the first H1 as title; else use filename
    m = re.search(r"^#\s+(.+?)\s*$", text, re.MULTILINE)
    title = m.group(1) if m else p.stem
    slug = slugify(title, p.stem)
    return slug, title, text.strip()


def main() -> None:
    if len(sys.argv) != 2:
        sys.exit("usage: extract.py <url-or-file>")
    arg = sys.argv[1]
    if arg.startswith(("http://", "https://")):
        slug, title, body = from_url(arg)
    elif os.path.exists(arg):
        slug, title, body = from_file(arg)
    else:
        sys.exit(f"not a URL and not a file: {arg}")
    # Header comment carries metadata; safe inside Markdown
    print(f"<!-- slug: {slug} | title: {title} -->")
    print(body)


if __name__ == "__main__":
    main()
