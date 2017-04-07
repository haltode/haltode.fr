import glob
import jinja2
import markdown
import os

from markdown.extensions.toc import TocExtension
# Python-Markdown third party extension
import figureAltCaption


ARTICLE_DIR = 'content/articles'
PAGE_DIR = 'content/pages'
TEMPLATE_DIR = 'content/templates'
WEBSITE_DIR = 'website'

ARTICLE_TEMPLATE = 'article.html'
PAGE_TEMPLATE = 'default.html'

jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(TEMPLATE_DIR))
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True


def get_path_files(directory, extension):
    return glob.iglob(directory + '/**/*.' + extension, recursive=True)


def final_render(template, html, metadata, **extras):
    template = jinja_env.get_template(template)
    output = template.render({'html_content': html, 'metadata': metadata, **extras})

    path = os.path.join(WEBSITE_DIR, metadata['path'])
    with open(path, 'w+') as f:
        f.write(output)


def read_markdown(path):
    with open(path, 'r') as f:
        content = f.read()

    # Parse the content
    md = markdown.Markdown(extensions={
        'markdown.extensions.extra',
        'markdown.extensions.meta',
        TocExtension(marker=''),
        # Third party extension
        'figureAltCaption'
        })
    html = md.convert(content)
    metadata = md.Meta
    toc = md.toc

    # The metadata values are lists but we want strings
    for key, value in metadata.items():
        key = key.lower()
        metadata[key] = ''.join(value)
    # Format the metadata
    metadata['path'] = os.path.join(metadata['path'], os.path.basename(path))
    metadata['path'] = metadata['path'].replace('.md', '.html')

    # Test if the toc is empty
    if 'li' not in toc:
        toc = ''

    return html, metadata, toc


def basic_rendering(template, directory, render_toc):
    file_template = jinja_env.get_template(template)
    files = get_path_files(directory, 'md')
    for f in files:
        html, metadata, toc = read_markdown(f)
        if render_toc:
            final_render(template, html, metadata, toc=toc)
        else:
            final_render(template, html, metadata)


def render_pages():
    basic_rendering(PAGE_TEMPLATE, PAGE_DIR, render_toc=False)


def render_articles():
    basic_rendering(ARTICLE_TEMPLATE, ARTICLE_DIR, render_toc=True)


print("Rendering pages...")
render_pages()
print("Rendering articles...")
render_articles()
print("Done!")
