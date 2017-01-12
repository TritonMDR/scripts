sudo mysql --user="root" --password="pedagogieintech" --execute="CREATE DATABASE $1;"
    if [ $? -eq 0 ]; then
        echo -e "\n La bdd '$1' a été crée avec succès"
        sudo mysql --user="root" --password="pedagogieintech" --execute="GRANT ALL PRIVILEGES ON $1.* TO $1@localhost;" &>/dev/null
        if [ $? -eq 0 ]; then
            echo " Privilège ajouté à l'utilisateur $1 sur la bdd $1 avec succès"
            sudo mysql --user="root" --password="pedagogieintech" --execute="FLUSH PRIVILEGES;" &>/dev/null
            if [ $? -eq 0 ]; then
                echo " Mis à jours des privilèges pour l'utilisateur '$1' réussi "
                sudo mysql --user="root" --password="pedagogieintech" --execute="GRANT ALL PRIVILEGES ON $1.* TO phpmyadmin@localhost;" &>/dev/null
                if [ $? -eq 0 ]; then
                    echo " Ajout des droits 'administrateur' pour la bdd '$1'"
                   sudo mysql --user="root" --password="pedagogieintech" --execute="FLUSH PRIVILEGES;" &>/dev/null
                    if [ $? -eq 0 ]; then
                        echo " Mis à jours des privilèges pour l'administrateur réussi"
                    fi
                fi
            fi
        else
            echo " Une erreur est survenue ajout privilège"
        fi
    else
        echo " Une erreur c'est produite, la bdd $1 n'a pas été crée"
    fi