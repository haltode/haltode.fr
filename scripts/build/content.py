import markdown
import os
import re

from markdown.extensions.toc import TocExtension
import figureAltCaption


class Content(object):

    def __init__(self):
        self.html = ''
        self.metadata = {}
        self.toc = ''

    def parse(self, file_path):
        with open(file_path, 'r') as f:
            content = f.read()

        extensions = {
            'markdown.extensions.extra',
            'markdown.extensions.meta',
            TocExtension(marker='', anchorlink=True, toc_depth=2),
            'figureAltCaption'
        }
        md = markdown.Markdown(extensions)
        self.html = md.convert(content)
        self.metadata = md.Meta
        self.toc = md.toc

        self.format_metadata()
        self.update_file_path(file_path)
        self.add_custom_blocks()
        self.delete_empty_toc()

    def format_metadata(self):
        for key, value in self.metadata.items():
            self.metadata[key.lower()] = ''.join(value)

    def update_file_path(self, file_path):
        location = self.metadata['path']
        basename = os.path.basename(file_path)
        self.metadata['path'] = os.path.join(location, basename).replace('.md', '.html')

    def add_custom_blocks(self):
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

        for block in custom_blocks:
            self.html = re.sub(block["pattern"], block["replacement"], self.html)

    def delete_empty_toc(self):
        if '<li>' not in self.toc:
            self.toc = ""
