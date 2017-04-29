import os
import jinja2


TEMPLATE_DIR = 'content/templates'
WEBSITE_DIR = 'website'

jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(TEMPLATE_DIR))
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True


def render(self):
    self.parse_markdown()

    output_params = {
        'html_content': self.html,
        'metadata': self.metadata,
        'toc': self.toc
    }
    template = jinja_env.get_template(self.template_path)
    output = template.render(output_params)

    output_path = os.path.join(WEBSITE_DIR, self.metadata['path'])
    with open(output_path, 'w+') as f:
        f.write(output)
