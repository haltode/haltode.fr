#!/bin/bash

# Generate inline css
echo "<style>" > src/static/css/layout.css.html
cat src/static/css/layout.css >> src/static/css/layout.css.html
echo "</style>" >> src/static/css/layout.css.html

# Pre-generate tag system to move converted files to their categories
rm categories.sh
touch categories.sh
chmod +x categories.sh

# Convert all .md files from pages/ into .html files and add header, title and footer
find pages -iname "*.md" -type f -exec sh -c \
  'location=`sed -n "3p" ${0}` && \
   echo "mv src/$(basename ${0%.md}.html) src/$location" >> categories.sh && \
   sed "3d" ${0} | pandoc --ascii -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/layout/header.html $(basename ${0%.md}.tmp.html) src/layout/footer.html > src/$(basename ${0%.md}.html) && \
   title=`sed -n "1p" ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   sed -i "/CSS/r src/static/css/layout.css.html" src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html)' {} \;

# Move all converted files to their categories
./categories.sh

   
