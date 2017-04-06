read -p "Testing server? [Y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] | [ -z $REPLY ]
then
   cd website
   firefox -new-tab http://localhost:8000/
   python -m http.server 8000
fi
