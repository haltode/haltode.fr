#!/bin/bash

# Generate inline css
echo "<style>" > src/static/css/layout.css.html
cat src/static/css/layout.css >> src/static/css/layout.css.html
echo "</style>" >> src/static/css/layout.css.html

# Convert all .md files from pages/ into .html files
# 1. Insert inline source code directly into the article
# 2. Get location for the future converted .html file
# 3. Convert the .md file to .tmp.html file
#    Create the .html, containing header + .tmp.html + footer
# 4. Get and insert the title
# 5. Insert inline css
# 6. Transform the title into a link
# 7. Insert summary
# 8. Move the .html to its actual location in src/
find pages -iname "*.md" -type f -exec sh -c \
  'cp ${0} copy.md && \

   while grep -q "\[INSERT\]" copy.md; do
		line_number=`grep -n -m 1 "\[INSERT\]" copy.md | cut -d: -f 1` &&
		line_number=$((line_number + 1)) &&

		filename=`sed "$line_number q;d" copy.md` &&
		extension="${filename##*.}" &&

      lenght=`cat $(dirname ${0})/$filename | wc -l` &&
      if [ $lenght -gt 20 ]; then
         sed -i "$line_number s/.*/\\\`\\\`\\\`\n<\/div>/" copy.md &&
         line_number=$((line_number - 1)) &&
         sed -i "$line_number s/.*/<a href=\"javascript:toggle_visibility('\''$filename'\'');\">$filename<\/a><div id=\"$filename\" style=\"display: none;\">\n\\\`\\\`\\\`$extension/" copy.md &&
         line_number=$((line_number + 1))
      else
         sed -i "$line_number s/.*/\\\`\\\`\\\`/" copy.md &&
         line_number=$((line_number - 1)) &&
         sed -i "$line_number s/.*/\\\`\\\`\\\`$extension/" copy.md
      fi

      sed -i "$line_number r $(dirname ${0})/$filename" copy.md
   done

	location=`sed -n "3p" copy.md` && \

   sed "3d" copy.md | pandoc --ascii -o "$(basename ${0%.md}.tmp.html)" && \
   cat src/templates/header.html $(basename ${0%.md}.tmp.html) src/templates/footer.html > src/$(basename ${0%.md}.html) && \
   rm $(basename ${0%.md}.tmp.html) && \

   title=`sed -n "1p" copy.md` && \
   sed -i "s/TITLE/$title - NapNac/g" src/$(basename ${0%.md}.html) && \
   rm copy.md && \

   sed -i "/CSS/r src/static/css/layout.css.html" src/$(basename ${0%.md}.html) && \

   sed -i "s/<h1 id=/<a href=\"\"><h1 id=/" src/$(basename ${0%.md}.html) && \
   sed -i "s/<\/h1>/<\/h1><\/a>/" src/$(basename ${0%.md}.html) && \

   if grep -q "<em>Modifi&#233; le" src/$(basename ${0%.md}.html); then
      sed -i "/<em>Modifi&#233; le/a <ul id=\"summary\">" src/$(basename ${0%.md}.html)
   else
      sed -i "/<h1 id=/a <ul id=\"summary\">" src/$(basename ${0%.md}.html)
   fi
   sed -i "/<ul id=\"summary\">/a </ul>" src/$(basename ${0%.md}.html) && \
   if grep -q "<h2 " src/$(basename ${0%.md}.html); then
      grep "<h2 " src/$(basename ${0%.md}.html) > summary.tmp &&
      sed -i "s/<h2 id=\"/<li><a href=\"#/g" summary.tmp &&
      sed -i "s/<\/h.>/<\/a><\/li>/g" summary.tmp &&
      sed -i "/<ul id=\"summary\">/r./summary.tmp" src/$(basename ${0%.md}.html) &&
      rm summary.tmp
   fi

   mv -v src/$(basename ${0%.md}.html) src/$location' {} \;
