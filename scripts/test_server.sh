read -n 1 -r -p "Testing server? [Y/n] "
echo
if [[ $REPLY == "Y" || $REPLY == "y" || $REPLY == "" ]]
then
   printf "Press any key to stop testing the server\n\n"
   cd website
   python -m http.server 8000 &
   read -n 1 -s -p ""
   kill $(pgrep -f "python -m http.server 8000")

   printf "\n"
fi
