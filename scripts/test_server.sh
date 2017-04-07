read -p "Testing server? [Y/n]" -n 1 -r
echo
if [[ $REPLY == "Y" || $REPLY == "y" || $REPLY == "" ]]
then
   cd website
   python -m http.server 8000
fi
