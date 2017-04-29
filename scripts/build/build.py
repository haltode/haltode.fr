import sys

from pages import Page
from path import get_all_files_path, get_template_path


if len(sys.argv) > 1:
    files_to_render = sys.argv[1:]
else:
    files_to_render = get_all_files_path()

print("Rendering pages...")

nb_pages_rendered = 0
for file_path in files_to_render:
    try:
        template_path = get_template_path(file_path)
    except ValueError:
        print("Error: Unrecognized file path:", file_path)
        continue

    page = Page(file_path, template_path)
    page.render()
    nb_pages_rendered = nb_pages_rendered + 1

print("Done:", nb_pages_rendered, "pages rendered.")
