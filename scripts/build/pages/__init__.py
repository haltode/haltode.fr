class Page(object):
    from pages.content import format_metadata, delete_empty_toc
    from pages.markdown import parse_markdown, convert_markdown
    from pages.render import render

    def __init__(self, file_path, template_path):
        self.file_path = file_path
        self.template_path = template_path
        self.html = ''
        self.metadata = {}
        self.toc = ''
