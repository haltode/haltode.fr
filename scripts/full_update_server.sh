read -n 1 -r -p "Updating server? [Y/n] "
echo
if [[ $REPLY == "Y" || $REPLY == "y" || $REPLY == "" ]]
then
   server="pi@192.168.1.28"

   printf "Updating server files...\n"
   rsync -ru --delete website/* $server:/home/pi/napnac/napnac.fr
   scp -q server.conf $server:/home/pi/napnac/

   printf "Updating symbolic links...\n"
   ssh $server sudo ln -fs /home/pi/napnac/server.conf /etc/nginx/sites-available/napnac.fr
   ssh $server sudo ln -fs /home/pi/napnac/server.conf /etc/nginx/sites-enabled/napnac.fr
   ssh $server sudo ln -fs /home/pi/napnac/napnac.fr/error_404.html /usr/share/nginx/html/error_404.html
   ssh $server sudo ln -fs /home/pi/napnac/napnac.fr/error_50x.html /usr/share/nginx/html/error_50x.html

   printf "Restarting nginx...\n"
   ssh $server sudo systemctl restart nginx.service

   printf "Done!\n"
fi
