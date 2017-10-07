CURRENT_DIR = $(shell pwd)
SCRIPT_DIR  = $(CURRENT_DIR)/scripts
WEBSITE_DIR = $(CURRENT_DIR)/../haltode.fr-website

run: build run_scripts
quick_run: quick_build run_scripts

build:
	python3 $(SCRIPT_DIR)/build/build.py
quick_build:
	python3 $(SCRIPT_DIR)/build/build.py `git ls-files --modified | grep md`

run_scripts:
	$(SCRIPT_DIR)/test_server.sh

clean:
	find $(WEBSITE_DIR) -name '*.html' -delete
