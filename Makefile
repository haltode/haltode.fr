BUILD_DIR   = build
WEBSITE_DIR = ../haltode.fr-website

all: build collectstatic runserver

build:
	python3 $(BUILD_DIR)/build.py

collectstatic:
	cp -TR css $(WEBSITE_DIR)/css
	cp -TR js $(WEBSITE_DIR)/js
	cp -TR img $(WEBSITE_DIR)/img

runserver:
	cd $(WEBSITE_DIR) && python3 -m http.server 8000

clean:
	find $(WEBSITE_DIR) -name '*.html' -delete

.PHONY: clean build
