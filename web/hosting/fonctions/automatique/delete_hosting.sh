
### Suppression Compte MYSQL ###
./web/bdd/fonctions/automatique/delete_user.sh $1
if [ $? -eq 0 ]; then
### Suppression BDD ###
    echo " Le 'compte MYSQL' $1 a été supprimé"
    ./web/bdd/fonctions/automatique/delete_bdd.sh $1
    if [ $? -eq 0 ]; then
        echo " La 'Base de donnée' $1 a été supprimé"
        ### FQDN ###
        ./dns/fonctions/automatique/delete_fqdn_user.sh $1
        echo " Le 'FQDN' : $2.triton.itinet.fr de l'utilisateur $1 a été supprimé"
        ### WEB ###
        ### Suppression VHOST ###
        # ./web/vhost/fonctions/automatique/delete_vhost_user.sh $1
        ### Supression SITE ###
        rm -r /var/www/html/$1 &>/dev/null
        rm /etc/nginx/sites-available/$1 &>/dev/null
        rm -r /etc/nginx/sites-enabled/$1 &>/dev/null
        rm -r /home/$1

        if [ $? -eq 0 ]; then
            echo " L'utilisateur $1 a été correctement supprimé"
        else
            echo " L'utilisateur $1 n'a pas été correctement supprimé, veuillez réessayer"
        fi 
    else
        echo " Une erreur est survenue lors de la suppression de la 'Base de donnée' : $1"
    fi
else
    echo " Une erreur est survenue lors de la suppression du 'compte MYSQL' : $1"
fi