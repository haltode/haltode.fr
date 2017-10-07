#!/bin/bash

read -n 1 -r -p "Testing server? [Y/n] "
echo
if [[ $REPLY == "Y" || $REPLY == "y" || $REPLY == "" ]]
then
   printf "Press any key to stop testing the server.\n\n"
   cd ../haltode.fr-website
   python3 -m http.server 8000 &
   read -n 1 -s -p ""
   kill $(pgrep -f "python3 -m http.server 8000")
   echo
fi
