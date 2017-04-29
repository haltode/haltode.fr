import markdown

from markdown.extensions.toc import TocExtension
import figureAltCaption


def parse_markdown(self):
    with open(self.file_path, 'r') as f:
        content = f.read()

    self.convert_markdown(content)

    self.format_metadata()
    self.delete_empty_toc()


def convert_markdown(self, content):
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
