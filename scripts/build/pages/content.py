import os


def format_metadata(self):
    for key, value in self.metadata.items():
        self.metadata[key.lower()] = ''.join(value)

    location = self.metadata['path']
    basename = os.path.basename(self.file_path)
    self.metadata['path'] = os.path.join(location, basename).replace('.md', '.html')


def delete_empty_toc(self):
    if '<li>' not in self.toc:
        self.toc = ""
