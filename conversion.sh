#!/bin/bash

# First, get rid of all old .html files
rm src/*.html

# Then, convert all .md files from pages/ into .html files and add header, title and footer
find pages -iname "*.md" -type f -exec sh -c \
   'pandoc --ascii "${0}" -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/layout/header.html $(basename ${0%.md}.tmp.html) src/layout/footer.html > src/$(basename ${0%.md}.html) && \
   title=`head -n 1 ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html)' {} \;
