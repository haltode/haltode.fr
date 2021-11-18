#!/usr/bin/env python3

import argparse
import logging
import pathlib
import sys

from builder import Builder


def main():
    logging.basicConfig(format="%(levelname)s - %(message)s", level=logging.INFO)
    parser = argparse.ArgumentParser(description="Build HTML pages from RST sources")
    parser.add_argument(
        "--build-dir",
        required=True,
        type=pathlib.Path,
        help="build directory where HTML files will be stored",
    )
    parser.add_argument("pages", nargs="*", type=pathlib.Path, help="list of RST pages to render")
    args = parser.parse_args()

    if not args.build_dir.is_dir():
        sys.exit(f"Error: '{args.build_dir}' is not a valid build directory")

    builder = Builder(args.pages, args.build_dir)
    builder.run()


if __name__ == "__main__":
    main()
