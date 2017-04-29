import glob


ARTICLE_DIR = 'content/articles'
CORE_PAGES_DIR = 'content/core_pages'

ARTICLE_TEMPLATE = 'article.html'
CORE_PAGES_TEMPLATE = 'default.html'


def get_files_path(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


def get_all_files_path():
    files_path = get_files_path(CORE_PAGES_DIR, 'md')
    files_path += get_files_path(ARTICLE_DIR, 'md')
    return files_path


def get_template_path(file_path):
    if CORE_PAGES_DIR in file_path:
        return CORE_PAGES_TEMPLATE
    elif ARTICLE_DIR in file_path:
        return ARTICLE_TEMPLATE
    else:
        raise ValueError
