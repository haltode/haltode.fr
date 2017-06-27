import os
import jinja2

import config
import content


jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader(config.TEMPLATE_DIR))
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True


class Page(object):

    def __init__(self, file_path, template_path):
        self.file_path = file_path
        self.template_path = template_path
        self.content = content.Content()

    def render(self):
        self.content.parse(self.file_path)

        output_params = {
            'html_content': self.content.html,
            'metadata': self.content.metadata,
            'toc': self.content.toc
        }
        template = jinja_env.get_template(self.template_path)
        output = template.render(output_params)

        output_path = os.path.join(config.WEBSITE_DIR, self.content.metadata['path'])
        with open(output_path, 'w+') as f:
            f.write(output)
