#!/bin/bash

# Generate inline css
echo "<style>" > src/static/css/layout.css.html
cat src/static/css/layout.css >> src/static/css/layout.css.html
echo "</style>" >> src/static/css/layout.css.html

# Convert all .md files from pages/ into .html files
# 1. Get location for the future converted .html file
# 2. Convert the .md file to .tmp.html file
# 3. Create the .html, containing header + .tmp.html + footer
# 4. Get the title
# 5. Insert the title
# 6. Insert inline css
# 7. Remove .tmp.html file
# 8. Move the .html to its actual location in src/
find pages -iname "*.md" -type f -exec sh -c \
  'location=`sed -n "3p" ${0}` && \
   sed "3d" ${0} | pandoc --ascii -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/layout/header.html $(basename ${0%.md}.tmp.html) src/layout/footer.html > src/$(basename ${0%.md}.html) && \
   title=`sed -n "1p" ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   sed -i "/CSS/r src/static/css/layout.css.html" src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html) && \
   mv -v src/$(basename ${0%.md}.html) src/$location' {} \;


