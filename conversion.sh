#!/bin/bash

# First, get rid of all old .html files
rm -r ./templates/pages/
mkdir ./templates/pages/

# Then, convert all .md files from pages/ into .html files and add header, title and footer
find ./pages -iname "*.md" -type f -exec sh -c \
   'pandoc --ascii "${0}" -o "./$(basename ${0%.md}.tmp.html)" && \
   cat ./templates/layout/header.html ./$(basename ${0%.md}.tmp.html) ./templates/layout/footer.html > ./templates/pages/$(basename ${0%.md}.html) && \
   title=`head -n 1 ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" ./templates/pages/$(basename ${0%.md}.html) && \
   rm ./$(basename ${0%.md}.tmp.html)' {} \;
