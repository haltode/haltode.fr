CURRENT_DIR = $(shell pwd)
SCRIPT_DIR  = $(CURRENT_DIR)/scripts
WEBSITE_DIR = $(CURRENT_DIR)/website

run: build run_scripts
quick_run: quick_build run_scripts

build:
	python $(SCRIPT_DIR)/build/build.py
quick_build:
	python $(SCRIPT_DIR)/build/build.py `git ls-files --modified | grep md`

run_scripts:
	$(SCRIPT_DIR)/custom_md_block.sh
	$(SCRIPT_DIR)/test_server.sh
	$(SCRIPT_DIR)/update_server.sh

clean:
	find $(WEBSITE_DIR) -name '*.html' -delete
