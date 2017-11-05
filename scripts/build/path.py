import glob

import config


def get_files(directory, extension):
    files_path = glob.iglob(directory + '/**/*.' + extension, recursive=True)
    return list(files_path)


def get_all_files():
    files_path = get_files(config.ARTICLE_DIR, 'md')
    files_path += get_files(config.ALGO_TRAINING_DIR, 'md')
    return files_path


def get_main_pages():
    return get_files(config.MAIN_PAGES_DIR, 'html')


def get_template(file_path):
    if config.ARTICLE_DIR in file_path:
        return config.ARTICLE_TEMPLATE
    elif config.ALGO_TRAINING_DIR in file_path:
        return config.ALGO_TRAINING_TEMPLATE
    else:
        raise ValueError
