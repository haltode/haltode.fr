import logging
import os
import traceback
from dataclasses import dataclass
from enum import Enum
from pathlib import Path
from typing import List

import jinja2
from page import Page

jinja_env = jinja2.Environment(loader=jinja2.FileSystemLoader("templates"))
# To get rid of useless empty lines in the html output
jinja_env.trim_blocks = True
jinja_env.lstrip_blocks = True


class RenderStatus(Enum):
    FAILED = 0
    RENDERED = 1
    SKIPPED = 2


@dataclass
class Builder:
    """Core class to build and render all the input pages."""

    page_paths: List[Path]
    build_dir: Path

    def run(self) -> None:
        nb_failed = 0
        nb_rendered = 0
        nb_skipped = 0
        for path in self.page_paths:
            try:
                status = self.render(path)
                if status == RenderStatus.RENDERED:
                    logging.info(f"Rendered '{path}'")
                    nb_rendered += 1
                elif status == RenderStatus.SKIPPED:
                    nb_skipped += 1
            except Exception:
                logging.error(f"Could not render '{path}':\n{traceback.format_exc()}")
                nb_failed += 1
        logging.info(
            f"Total number of pages rendered: {nb_rendered} "
            f"({nb_skipped} skipped and {nb_failed} failed)"
        )

    def render(self, path: Path) -> RenderStatus:
        page = Page(path)
        output_path = Path(self.build_dir, page.metadata["path"])
        if (output_path.exists() and
            os.path.getmtime(output_path) > os.path.getmtime(page.source_file)):
            # Skip the page if the source file has not changed since last
            # rendering. We cannot really encode this information in the
            # Makefile dependencies because the output path is not the same as
            # input path and must be parsed in the metadata.
            return RenderStatus.SKIPPED

        template = jinja_env.get_template(page.metadata["template"] + ".html")
        context = {
            "html_content": page.to_html(),
            "metadata": page.metadata,
        }
        output = template.render(context)

        # Make sure subdirectories are created if needed
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, "w+") as f:
            f.write(output)
        return RenderStatus.RENDERED
