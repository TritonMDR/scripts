echo -e "\n DANS ADD CRAWLER : URL : $3 \n "
wget -p --convert-links --directory-prefix=/var/www/html/$2/ $3 &>/dev/null
if [ $? -eq 0 ]; then
    echo " Le site $3 a été cloné avec succès"
else
    echo " Une erreur est survenue lors du clonage du site $3"
    exit
fi