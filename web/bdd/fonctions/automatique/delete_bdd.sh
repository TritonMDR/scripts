if [ "$1" = "information_schema" ] || [ "$1" = "performance_schema" ] || [ "$1" = "mysql" ]; then
        echo " La base de donnée : $1 ne peut être supprimé"
    else
        mysql --user="root" --password="pedagogieintech" --execute="DROP DATABASE $1;" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e " \n La base de donnée $1 a été supprimé avec succès"
        else
            echo " Une erreur c'est produite, la base de donnée $1 n'a pas été supprimé"
        fi
    fi