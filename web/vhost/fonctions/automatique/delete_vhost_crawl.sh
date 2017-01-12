rm /etc/nginx/sites-available/$1$2
rm /etc/nginx/sites-enabled/$1$2

if [ $? -eq 0 ]; then
    rm -i $1 -f
    if [ $? -eq 0 ]; then
        echo "Le lien symbolique a été supprimé avec succès"
    else
        echo "Une erreur c'est produite lors de la suppression du lien symbolique"
    fi
else
    echo "Une erreur c'est produite, le vhost pour le site $1$2.triton.itinet.fr n'a pas été supprimé"
fi
