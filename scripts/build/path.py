import glob


ARTICLE_DIR = 'content/articles'
MAIN_PAGES_DIR = 'content/main_pages'

ARTICLE_TEMPLATE = 'article.html'
MAIN_PAGES_TEMPLATE = 'base.html'


def get_files(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


def get_all_files():
    files_path = get_files(MAIN_PAGES_DIR, 'md')
    files_path += get_files(ARTICLE_DIR, 'md')
    return files_path


def get_template(file_path):
    if MAIN_PAGES_DIR in file_path:
        return MAIN_PAGES_TEMPLATE
    elif ARTICLE_DIR in file_path:
        return ARTICLE_TEMPLATE
    else:
        raise ValueError
