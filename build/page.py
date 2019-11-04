import os
import jinja2

import config
import content


jinja_env = jinja2.Environment(
    loader=jinja2.FileSystemLoader(config.TEMPLATE_DIR)
)
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True


def render(file_path, website_dir):
    page = content.Content()
    page.parse(file_path)

    template = jinja_env.get_template(page.metadata['template'] + '.html')
    context = {
        'html_content': page.html,
        'metadata': page.metadata,
    }
    output = template.render(context)

    output_path = os.path.join(website_dir, page.metadata['path'])
    # Make sure the subdirectories exist before writing to the file
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, 'w+') as f:
        f.write(output)
