import os
import pypandoc
import re
import yaml


class Content:
    def __init__(self):
        self.html = ''
        self.metadata = {}

    def parse(self, file_path):
        self.html = pypandoc.convert_file(
            source_file=file_path, to='html',
            extra_args=['--mathjax', '--no-highlight', '--base-header-level=2']
        )

        meta_path = os.path.join(os.path.dirname(file_path), 'metadata.yaml')
        with open(meta_path, 'r') as f:
            self.metadata = yaml.load(f, Loader=yaml.FullLoader)

        self.fix_pandoc_code_blocks()
        self.add_custom_blocks()

    def fix_pandoc_code_blocks(self):
        # https://github.com/jgm/pandoc/issues/3858
        self.html = re.sub(
            "<pre class=\"sourceCode ([0-9a-zA-Z]+)\"><code>",
            "<pre><code class=\"\\1\">",
            self.html
        )

    def add_custom_blocks(self):
        custom_blocks = [
            # [[secret="title"]]
            {
                "old": "<p>\[\[secret=&quot;([0-9a-zA-Z_.]+)&quot;\]\]</p>",
                "new": (
                    "<a href=\"javascript:toggle_visibility('\\1');\">\\1 "
                    "<i id=\"toggle_arrow_\\1\" class=\"fa fa-angle-down\" "
                    "aria-hidden=\"true\"></i></a>"
                    "\n<div id=\"\\1\" style=\"display: none;\">"
                )
            },
            # [[/secret]]
            {
                "old": "<p>\[\[/secret\]\]</p>",
                "new": "</div>"
            }
        ]

        for b in custom_blocks:
            self.html = re.sub(b["old"], b["new"], self.html)
