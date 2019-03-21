import glob
import os

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
print("Done:", nb_pages_rendered, "pages rendered.")
