#!/bin/bash

function show_bdd() {
    mysql --user="root" --password="pedagogieintech" --execute="SHOW DATABASES;"
}

function add_bdd() {

    mysql --user="root" --password="pedagogieintech" --execute="CREATE DATABASE $1;"
    if [ $? -eq 0 ]; then
        echo -e "\n La bdd '$1' a été crée avec succès"

        mysql --user="root" --password="pedagogieintech" --execute="GRANT CREATE, DELETE, EXECUTE, INSERT, UPDATE, DROP ON $1.* TO $1@localhost;" &>/dev/null
        if [ $? -eq 0 ]; then
            echo " Privilège ajouté à '$1' avec succès"

            mysql --user="root" --password="pedagogieintech" --execute="FLUSH PRIVILEGES;" &>/dev/null
            if [ $? -eq 0 ]; then
                echo " Mis à jours des privilèges pour l'utilisateur '$1' réussi "

                mysql --user="root" --password="pedagogieintech" --execute="GRANT ALL PRIVILEGES ON $1.* TO root@localhost;" &>/dev/null
                if [ $? -eq 0 ]; then
                    echo " Ajout des droits 'administrateur' pour la bdd '$1'"

                    mysql --user="root" --password="pedagogieintech" --execute="FLUSH PRIVILEGES;" &>/dev/null
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
}

function delete_bdd() {

      if [ "$1" = "information_schema" ] || [ "$1" = "performance_schema" ] || [ "$1" = "mysql" ]; then
        echo " La base de donnée : $1 ne peut être supprimé"
    else
        mysql --user="root" --password="pedagogieintech" --execute="DROP DATABASE $1;" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e " \n La base de donnée $1 a été supprimé avec succès"
            show_bdd
        else
            echo " Une erreur c'est produite, la base de donnée $1 n'a pas été supprimé"
        fi
    fi
}

function update_bdd_privilege() {

    for arg in $@ 
    do
        tab+=($arg)
    done

    chaine0="GRANT "
    chaine1=" ON $db_name.* TO $user@localhost;"
    for ((i=0; i<${#tab[*]}; i++)); do
        value=${tab[$i]}
        if [ $i = 0 ] && [ "$value" != "$user" ] && [ "$value" != "$db_name" ]; then
            chaine0+="$value"
        elif [ "$value" != "$user" ] && [ "$value" != "$db_name" ]; then
            chaine0+=", $value"
        fi
    done
    
    chaine0+=$chaine1
    mysql --user="root" --password="pedagogieintech" --execute="$chaine0" &>/dev/null
    if [ $? -eq 0 ]; then
        echo " Mis à jours des privilèges pour l'utilisateur '$user' réussi "
    else
        echo " Une erreur c'est produite, les privilèges pour l'utilisateur '$user' n'ont pas été attribué à la bdd '$db_name'"
    fi
}
