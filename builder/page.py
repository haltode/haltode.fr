import re
from pathlib import Path
from typing import Any, Dict

import pypandoc
import yaml


def fix_pandoc_code_blocks(html: str) -> str:
    """Temporary workaround https://github.com/jgm/pandoc/issues/3858"""

    return re.sub(
        "<pre class=\"([0-9a-zA-Z]+)\"><code>",
        "<pre><code class=\"\\1\">",
        html
    )


def add_custom_directives(html: str) -> str:
    """Helper to add custom RST directives into rendered HTML."""

    directives = [
        # [[secret="title"]]
        {
            "old": "<p>\[\[secret=\"([0-9a-zA-Z_.]+)\"\]\]</p>",
            "new": "<details>\n<summary>\\1</summary>",
        },
        # [[/secret]]
        {
            "old": "<p>\[\[/secret\]\]</p>",
            "new": "</details>"
        },
    ]

    for d in directives:
        html = re.sub(d["old"], d["new"], html)
    return html


class Page:
    """A single input page to render."""

    source_file: Path
    metadata: Dict[str, Any]

    def __init__(self, page_path: Path) -> None:
        self.source_file = page_path
        with open(page_path.with_suffix(".meta"), "r") as f:
            self.metadata = yaml.safe_load(f)

    def to_html(self) -> str:
        html = pypandoc.convert_file(
            source_file=str(self.source_file),
            to="html",
            extra_args=["--mathjax", "--no-highlight", "--base-header-level=2"],
        )
        html = fix_pandoc_code_blocks(html)
        html = add_custom_directives(html)
        return html
