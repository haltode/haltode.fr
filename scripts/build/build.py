import os
import shutil
import sys

import config
import pages
import path


if len(sys.argv) > 1:
    files_to_render = sys.argv[1:]
else:
    files_to_render = path.get_all_files()

print("Rendering pages...")

nb_pages_rendered = 0
for file_path in files_to_render:
    try:
        template_path = path.get_template(file_path)
    except ValueError:
        print("Error: Unrecognized file path:", file_path)
        continue

    page = pages.Page(file_path, template_path)
    page.render()
    nb_pages_rendered = nb_pages_rendered + 1

print("Done:", nb_pages_rendered, "pages rendered.")

print("Adding main pages...")

main_pages = path.get_main_pages()
for main_page in main_pages:
    destination = os.path.join(config.WEBSITE_DIR, os.path.basename(main_page))
    shutil.copyfile(main_page, destination)

print("Done.")
