#!/bin/bash

# Generate inline css
echo "<style>" > src/static/css/layout.css.html
cat src/static/css/layout.css >> src/static/css/layout.css.html
echo "</style>" >> src/static/css/layout.css.html

# Convert all .md files from pages/ into .html files
# 1. Get location for the future converted .html file
# 2. Convert the .md file to .tmp.html file
# 3. Create the .html, containing header + .tmp.html + footer
# 4. Remove .tmp.html file
# 5. Get the title
# 6. Insert the title
# 7. Insert inline css
# 8. Insert summary
# 9. Move the .html to its actual location in src/
find pages -iname "*.md" -type f -exec sh -c \
  'location=`sed -n "3p" ${0}` && \
   sed "3d" ${0} | pandoc --ascii -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/layout/header.html $(basename ${0%.md}.tmp.html) src/layout/footer.html > src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html) && \
   title=`sed -n "1p" ${0}` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   sed -i "/CSS/r src/static/css/layout.css.html" src/$(basename ${0%.md}.html) && \
   if grep -q "<em>Modifi&#233; le" src/$(basename ${0%.md}.html); then
      sed -i "/<em>Modifi&#233; le/a <ul id=\"summary\">" src/$(basename ${0%.md}.html)
   else
      sed -i "/<h1 id=/a <ul id=\"summary\">" src/$(basename ${0%.md}.html)
   fi
   sed -i "/<ul id=\"summary\">/a </ul>" src/$(basename ${0%.md}.html) && \
   if grep -q "<h2 " src/$(basename ${0%.md}.html); then
      grep "<h1 " src/$(basename ${0%.md}.html) > summary.tmp &&
      grep "<h2 " src/$(basename ${0%.md}.html) >> summary.tmp &&
      title=`head -n 1 summary.tmp` &&
      title=${title#*>} &&
      title=${title%<*} &&
      sed -i "1s/.*/<li><a href=\"\">$title<\/a><\/li>/" summary.tmp &&
      sed -i "s/<h2 id=\"/<li><a href=\"#/g" summary.tmp &&
      sed -i "s/<\/h.>/<\/a><\/li>/g" summary.tmp &&
      sed -i "/<ul id=\"summary\">/r./summary.tmp" src/$(basename ${0%.md}.html) &&
      rm summary.tmp
   fi
   mv -v src/$(basename ${0%.md}.html) src/$location' {} \;


