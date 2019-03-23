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

        meta_path = file_path.replace('.rst', '.meta')
        with open(meta_path, 'r') as f:
            self.metadata = yaml.load(f, Loader=yaml.FullLoader)

        self.fix_pandoc_code_blocks()
        self.add_custom_directives()

    def fix_pandoc_code_blocks(self):
        # https://github.com/jgm/pandoc/issues/3858
        self.html = re.sub(
            "<pre class=\"sourceCode ([0-9a-zA-Z]+)\"><code>",
            "<pre><code class=\"\\1\">",
            self.html
        )

    def add_custom_directives(self):
        directives = [
            # [[secret="title"]]
            {
                "old": "<p>\[\[secret=&quot;([0-9a-zA-Z_.]+)&quot;\]\]</p>",
                "new": "<details>\n<summary>\\1</summary>"
            },
            # [[/secret]]
            {
                "old": "<p>\[\[/secret\]\]</p>",
                "new": "</details>"
            }
        ]

        for d in directives:
            self.html = re.sub(d["old"], d["new"], self.html)
