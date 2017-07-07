read -n 1 -r -p "Updating server? [Y/n] "
echo
if [[ $REPLY == "Y" || $REPLY == "y" || $REPLY == "" ]]
then
   git subtree push --prefix website origin gh-pages
   printf "Done!\n"
fi
