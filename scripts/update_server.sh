read -n 1 -r -p "Updating server? [Y/n] "
echo
if [[ $REPLY == "Y" || $REPLY == "y" || $REPLY == "" ]]
then
   rsync -ru --delete website/* pi@192.168.1.28:/home/pi/napnac/napnac.fr
   printf "Done!\n"
fi
