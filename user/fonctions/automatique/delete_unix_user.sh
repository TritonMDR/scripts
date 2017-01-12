### ARGUMENTS ###
# $1 = name (nom utilisateur) | $2 = fqdn

### Suppression Compte unix ###
killall -KILL -u $1
deluser $1
if [ $? -eq 0 ]; then
### Suppression Compte mail ###
    echo " Le compte utilisateur '$1' a été supprimé"
    ./mail/fonctions/automatique/delete_user.sh $1
    if [ $? -eq 0 ]; then
    ### Suppression Compte MYSQL ###
        echo " Le compte mail '$1' a été supprimé"
        ./web/bdd/fonctions/automatique/delete_user.sh $1
        if [ $? -eq 0 ]; then
        ### Suppression BDD ###
            echo " Le compte MYSQL '$1' a été supprimé"
            ./web/bdd/fonctions/automatique/delete_bdd.sh $1
            if [ $? -eq 0 ]; then
                echo " La Base de donnée '$1' a été supprimé"
                ### FQDN ###
                ./dns/fonctions/automatique/delete_fqdn_user.sh $1
                echo " Le FQDN : $2.triton.itinet.fr de l'utilisateur '$1' a été supprimé"
                ### WEB ###
                ### Supression SITE ###
                rm -r /var/www/html/$1 &>/dev/null
                rm /etc/nginx/sites-available/$1 &>/dev/null
                rm -r /etc/nginx/sites-enabled/$1 &>/dev/null
                rm -r /home/$1

                if [ $? -eq 0 ]; then
                    echo " L'utilisateur '$1' a été correctement supprimé"
                else
                    echo " L'utilisateur '$1' n'a pas été correctement supprimé, veuillez réessayer"
                fi 
            else
                echo " Une erreur est survenue lors de la suppression de la Base de donnée : '$1'"
            fi
        else
            echo " Une erreur est survenue lors de la suppression du compte MYSQL : '$1'"
        fi
    else
        echo " Une erreur est survenue lors de la suppression du compte mail : '$1'"
    fi
else
    echo " Une erreur est survenue lors de la suppression de l'utilisateur '$1'"
fi