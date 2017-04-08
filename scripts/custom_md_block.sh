################
# Secret block #
################
# Hide/show elements

# Input:
# [[secret="title"]]
#
# the secret text
#
# [[/secret]]

# Output:
# <a href="javascript:toggle_visibility('title');">title <i id="toggle_arrow_title" class="fa fa-angle-down" aria-hidden="true"></i></a>
# <div id="title" style="display: none;">
# <p>the secret text</p>
# </div>

find website -name '*.html' \
   -exec sed -i "s/<p>\[\[secret=\"\(.*\)\"\]\]<\/p>/<a href=\"javascript:toggle_visibility\(\'\1\'\);\">\1 <i id=\"toggle_arrow_\1\" class=\"fa fa-angle-down\" aria-hidden=\"true\"><\/i><\/a>\n<div id=\"\1\" style=\"display: none;\">/g" {} \; \
   -exec sed -i "s/<p>\[\[\/secret\]\]<\/p>/<\/div>/g" {} \;
