#!/bin/bash

# Generate inline css
echo "<style>" > src/static/css/layout.css.html
cat src/static/css/layout.css >> src/static/css/layout.css.html
echo "</style>" >> src/static/css/layout.css.html

# Convert all .md files from pages/ into .html files and add header, title and footer
find pages -iname "*.md" -type f -exec sh -c \
  'location=`sed -n "3p" ${0}` && \
   sed "3d" ${0} | pandoc --ascii -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/layout/header.html $(basename ${0%.md}.tmp.html) src/layout/footer.html > src/$(basename ${0%.md}.html) && \
   title=`sed -n "1p" ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   sed -i "/CSS/r src/static/css/layout.css.html" src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html) && \
   mv -v src/$(basename ${0%.md}.html) src/$location' {} \;

mv -v src/{projets,accueil,articles,a_propos}.html src/
