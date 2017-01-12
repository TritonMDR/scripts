if [ $1 = "root" ]; then
        echo "l'utilisateur root ne peut être supprimé"
        exit
    else
        mysql --user="root" --password="pedagogieintech" --execute="DROP USER '$1'@'localhost';" &>/dev/null
        if [ $? -eq 0 ]; then
            echo "l'utilisateur $1 a été supprimé avec succès"
        else
            echo "Une erreur c'est produite, l'utilisateur $1 n'a pas été supprimé"
        fi
    fi