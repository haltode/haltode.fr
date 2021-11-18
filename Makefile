CONTENT_DIR = content
WEBSITE_DIR = html

PAGES = $(shell find $(CONTENT_DIR) -name '*.rst')

.PHONY: all build collectstatic runserver clean

all: build

build:
	@mkdir -p $(WEBSITE_DIR)
	@./builder/main.py --build-dir $(WEBSITE_DIR) $(PAGES)

collectstatic:
	cp -TR css $(WEBSITE_DIR)/css
	cp -TR img $(WEBSITE_DIR)/img
	cp -TR static $(WEBSITE_DIR)/upload

runserver:
	cd $(WEBSITE_DIR) && python3 -m http.server 8000

clean:
	$(RM) -r $(WEBSITE_DIR)
