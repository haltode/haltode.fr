import glob
import os
import shutil

import config
import pages


def get_files(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


def get_files_to_render():
    files_path = get_files(config.ARTICLE_DIR, 'rst')
    return files_path


def get_raw_html_files():
    return get_files(config.CONTENT_DIR, 'html')


def get_template(file_path):
    if config.ARTICLE_DIR in file_path:
        return config.ARTICLE_TEMPLATE
    else:
        raise ValueError


print("Building website...")

nb_pages_rendered = 0
for file_path in get_files_to_render():
    try:
        template_path = get_template(file_path)
    except ValueError:
        print("Error: Unrecognized file path:", file_path)
        continue

    page = pages.Page(file_path, template_path)
    page.render()
    nb_pages_rendered += 1
print(nb_pages_rendered, "pages rendered.")

nb_html_pages = 0
for html_page in get_raw_html_files():
    destination = os.path.join(config.WEBSITE_DIR, os.path.basename(html_page))
    shutil.copyfile(html_page, destination)
    nb_html_pages += 1
print(nb_html_pages, "html pages copied.")
