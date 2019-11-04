import glob
import os
import sys

import config
import page


def get_files(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


if len(sys.argv) != 2:
    sys.exit("Usage: build.py [WEBSITE_DIR]")

website_dir = sys.argv[1]
print("Building website...")

nb_pages_rendered = 0
for file_path in get_files(config.CONTENT_DIR, 'rst'):
    page.render(file_path, website_dir)
    nb_pages_rendered += 1
print("Done:", nb_pages_rendered, "pages rendered.")
