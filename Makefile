CURRENT_DIR = $(shell pwd)
SCRIPT_DIR  = $(CURRENT_DIR)/scripts
WEBSITE_DIR = $(CURRENT_DIR)/website

run:
	python $(SCRIPT_DIR)/build.py
	$(SCRIPT_DIR)/test_server.sh

quickrun:
	python $(SCRIPT_DIR)/build.py `git ls-files --modified | grep md`
	$(SCRIPT_DIR)/test_server.sh

clean:
	find $(WEBSITE_DIR) -name '*.html' -delete
