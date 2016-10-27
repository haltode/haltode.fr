import glob
import jinja2
import markdown
import os

# Python-Markdown third party extension
import figureAltCaption


ARTICLES_DIR = 'articles'
TEMPLATES_DIR = 'templates'
WEBSITE_DIR = 'website'

jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(TEMPLATES_DIR))
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True
default_template = jinja_env.get_template('default.html')


def render_page(template, path, **metadata):
    template = jinja_env.get_template(template)
    page = template.render(**metadata)

    file_path = os.path.join(WEBSITE_DIR, path)
    with open(file_path, 'w+') as f:
        f.write(page)


def render_core_pages():
    render_page(template='erreur_404.html', path='erreur_404.html', title='Erreur 404')
    render_page(template='erreur_50x.html', path='erreur_50x.html', title='Erreur')


def render_articles():
    article_template = jinja_env.get_template('article.html')
    # Get the path of all the articles in Markdown
    articles = glob.iglob(ARTICLES_DIR + '/**/*.md', recursive=True)

    for article in articles:
        md = markdown.Markdown(extensions={
            'markdown.extensions.extra',
            'markdown.extensions.meta',
            'markdown.extensions.smarty',
            'markdown.extensions.toc',
            # Third party extension
            'figureAltCaption'
        })

        # Transform the article as a unique string
        content_lines = []
        with open(article, 'r') as f:
            for line in f:
                content_lines.append(line)
        content = ''.join(content_lines)

        # Parse the article
        html = md.convert(content)
        metadata = md.Meta

        # The metadata values are lists but we want strings
        for key, value in metadata.items():
            metadata[key] = ''.join(value)

        # Extract the metadata
        path = os.path.join(metadata['path'], os.path.basename(article))
        path = path.replace('.md', '.html')
        title = metadata['title']
        published = metadata['published']
        modified = metadata['modified']

        render_page(template=article_template, path=path, html_content=html,
                    title=title, published=published, modified=modified)


def clean():
    pages = glob.iglob(WEBSITE_DIR + '/**/*.html', recursive=True)
    for page in pages:
        os.remove(page)


print("Cleaning...")
clean()

print("Rendering core pages...")
render_core_pages()

print("Rendering articles...")
render_articles()

print("Done!")
