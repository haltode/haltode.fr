import os
import re


custom_blocks = [
    # [[secret="title"]]
    {
        "pattern": "<p>\[\[secret=\"([0-9a-zA-Z_.]+)\"\]\]</p>",
        "replacement": (
            "<a href=\"javascript:toggle_visibility('\\1');\">\\1 "
            "<i id=\"toggle_arrow_\\1\" class=\"fa fa-angle-down\" "
            "aria-hidden=\"true\"></i></a>"
            "\n<div id=\"\\1\" style=\"display: none;\">"
        )
    },
    # [[/secret]]
    {
        "pattern": "<p>\[\[/secret\]\]</p>",
        "replacement": "</div>"
    }
]


def add_custom_blocks(self):
    for block in custom_blocks:
        self.html = re.sub(block["pattern"], block["replacement"], self.html)


def format_metadata(self):
    for key, value in self.metadata.items():
        self.metadata[key.lower()] = ''.join(value)

    location = self.metadata['path']
    basename = os.path.basename(self.file_path)
    self.metadata['path'] = os.path.join(location, basename).replace('.md', '.html')


def delete_empty_toc(self):
    if '<li>' not in self.toc:
        self.toc = ""
