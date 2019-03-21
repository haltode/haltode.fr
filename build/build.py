import glob
import os
import shutil

import config
import page


def get_files(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


print("Building website...")

nb_pages_rendered = 0
for file_path in get_files(config.CONTENT_DIR, 'rst'):
    page.render(file_path)
    nb_pages_rendered += 1
print(nb_pages_rendered, "pages rendered.")

nb_html_pages = 0
for html_page in get_files(config.CONTENT_DIR, 'html'):
    destination = os.path.join(config.WEBSITE_DIR, os.path.basename(html_page))
    shutil.copyfile(html_page, destination)
    nb_html_pages += 1
print(nb_html_pages, "html pages copied.")
