#!/bin/bash

# Get rid of all old .html files
rm src/*.html

# Generate inline css
echo "<style>" > src/static/css/layout.css.html
cat src/static/css/layout.css >> src/static/css/layout.css.html
echo "</style>" >> src/static/css/layout.css.html

# Convert all .md files from pages/ into .html files and add header, title and footer
find pages -iname "*.md" -type f -exec sh -c \
   'pandoc --ascii "${0}" -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/layout/header.html $(basename ${0%.md}.tmp.html) src/layout/footer.html > src/$(basename ${0%.md}.html) && \
   title=`head -n 1 ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   sed -i "/CSS/r src/static/css/layout.css.html" src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html)' {} \;
