#!/bin/bash

# Convert all .md files from pages/ into .html files and add header, title and footer
find ./pages -iname "*.md" -type f -exec sh -c \
   'pandoc --ascii "${0}" -o "./$(basename ${0%.md}.tmp.html)" && \
   cat ./templates/layout/header.html ./$(basename ${0%.md}.tmp.html) ./templates/layout/footer.html > ./templates/pages/$(basename ${0%.md}.html) && \
   sed -i "s/TITLE/$(basename ${0%.md}) - NapNac/g" ./templates/pages/$(basename ${0%.md}.html) && \
   rm ./$(basename ${0%.md}.tmp.html)' {} \;
