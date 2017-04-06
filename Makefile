CURRENT_DIR = $(shell pwd)
WEBSITE_DIR = $(CURRENT_DIR)/website


run:
	python scripts/build.py
	scripts/test_server.sh

clean:
	find $(WEBSITE_DIR) -name '*.html' -delete
