import glob
import jinja2
import markdown
import os
import sys

from markdown.extensions.toc import TocExtension
import figureAltCaption


ARTICLE_DIR = 'content/articles'
CORE_PAGES_DIR = 'content/core_pages'
TEMPLATE_DIR = 'content/templates'
WEBSITE_DIR = 'website'

ARTICLE_TEMPLATE = 'article.html'
CORE_PAGES_TEMPLATE = 'default.html'

jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(TEMPLATE_DIR))
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True


class Page(object):

    def __init__(self, file_path, template_path):
        self.file_path = file_path
        self.template_path = template_path
        self.html = ''
        self.metadata = {}
        self.toc = ''

    def render(self):
        self.parse_markdown()

        output_params = {
            'html_content': self.html,
            'metadata': self.metadata,
            'toc': self.toc
        }
        template = jinja_env.get_template(self.template_path)
        output = template.render(output_params)

        output_path = os.path.join(WEBSITE_DIR, self.metadata['path'])
        with open(output_path, 'w+') as f:
            f.write(output)

    def parse_markdown(self):
        with open(self.file_path, 'r') as f:
            content = f.read()

        self.convert_markdown(content)

        self.format_metadata()
        if self.is_toc_empty():
            self.toc = ''

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

    def format_metadata(self):
        for key, value in self.metadata.items():
            self.metadata[key.lower()] = ''.join(value)

        location = self.metadata['path']
        basename = os.path.basename(self.file_path)
        self.metadata['path'] = os.path.join(location, basename).replace('.md', '.html')

    def is_toc_empty(self):
        if 'li' not in self.toc:
            return True
        else:
            return False


def get_files_path(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


def get_all_files_path():
    files_path = get_files_path(CORE_PAGES_DIR, 'md')
    files_path += get_files_path(ARTICLE_DIR, 'md')
    return files_path


if len(sys.argv) > 1:
    files_to_render = sys.argv[1:]
else:
    files_to_render = get_all_files_path()

print("Rendering pages...")

nb_pages_rendered = 0
for file_path in files_to_render:
    if CORE_PAGES_DIR in file_path:
        template_path = CORE_PAGES_TEMPLATE
    elif ARTICLE_DIR in file_path:
        template_path = ARTICLE_TEMPLATE
    else:
        print("Error: unknown file path:", file_path)
        continue

    page = Page(file_path, template_path)
    page.render()
    nb_pages_rendered = nb_pages_rendered + 1

print("Done:", nb_pages_rendered, "pages rendered.")
