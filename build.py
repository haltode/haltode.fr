import jinja2
import os


TEMPLATES_DIR = 'templates'
WEBSITE_DIR   = 'website'

jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(TEMPLATES_DIR))

default_template = jinja_env.get_template('default.html')


def render_page(template, title, path):
    file_path = os.path.join(WEBSITE_DIR, path)

    template = jinja_env.get_template(template)
    page = template.render(title=title)

    with open(file_path, 'wb') as f:
        f.write(page.encode('utf-8'))


def render_core_pages():
    render_page(template='accueil.html', title='Bienvenue !', path='accueil.html')
    render_page(template='liste_articles.html', title='Articles', path='articles.html')
    render_page(template='projets.html', title='Projets', path='projets.html')
    render_page(template='a_propos.html', title='A propos', path='a_propos.html')

    render_page(template='erreur_404.html', title='Erreur 404', path='erreur_404.html')
    render_page(template='erreur_50x.html', title='Erreur', path='erreur_50x.html')


def render_articles():
    pass


print("Rendering core pages...")
render_core_pages()

print("Rendering articles...")
render_articles()

print("Done!")
