#!/bin/bash

                ###########################################################
                ######              [ FONCTION USER ]                ######
                ######   MariaDB - Gestion des utilisateurs MySQL    ######
                ###########################################################

function add_user() {

    mysql --user="root" --password="pedagogieintech" --execute="CREATE USER '$1'@'localhost';"
    if [ $? -eq 0 ]; then
        echo "l'utilisateur $1 a été ajouter succès"
        mysql --user="root" --password="pedagogieintech" --execute="SET PASSWORD FOR $1@localhost = PASSWORD('$2')"
        if [ $? -eq 0 ]; then
            echo "le mot de pass $2 a été affecté à l'utilisateur $1"
        else
            echo "Une erreur c'est produite, le mot de passe $2 n'a pas été affecté à l'utilisateur $1"
        fi
    else
        echo "Une erreur c'est produite, l'utilisateur $1 n'a pas été ajouter"
    fi
}


function delete_user() {

    if [ $1 = "root" ]; then
        echo "l'utilisateur root ne peut être supprimé"
        exit
    else
        mysql --user="root" --password="pedagogieintech" --execute="DROP USER '$1'@'localhost';"
        if [ $? -eq 0 ]; then
            echo "l'utilisateur $1 a été supprimé avec succès"
        else
            echo "Une erreur c'est produite, l'utilisateur $1 n'a pas été supprimé"
        fi
    fi
}


function update_user() {

    if [ $action = 0 ]; then
    # ACTION = EDIT name
        mysql --user="root" --password="pedagogieintech" --execute="RENAME USER '$2'@'localhost' TO '$3'@'localhost';"
        if [ $? -eq 0 ]; then
            echo "l'utilisateur $2 a été renommé en $3"
        else
            echo "Une erreur c'est produite, l'utilisateur $2 n'a pas été renommé en $3"
        fi
    elif [ $action = 1 ]; then
    # ACTION = EDIT password
        mysql --user="root" --password="pedagogieintech" --execute="SET PASSWORD FOR $2@localhost = PASSWORD('$3')"
        if [ $? -eq 0 ]; then
            echo "le nouveau mot de passe $2 a été affecté à l'utilisateur $3"
        else
            echo "Une erreur c'est produite, le mot de passe $2 n'a pas été affecté à l'utilisateur $3"
        fi
    elif [ $action = 2 ]; then
    # ACTION = EDIT name & password
        show_user
        
        mysql --user="root" --password="pedagogieintech" --execute="RENAME USER '$2'@'localhost' TO '$3'@'localhost';"
        if [ $? -eq 0 ]; then
            echo "l'utilisateur $2 a été renommé en $3"
            mysql --user="root" --password="pedagogieintech" --execute="SET PASSWORD FOR $3@localhost = PASSWORD('$4')"
            if [ $? -eq 0 ]; then
                echo "le nouveau mot de passe $4 a été affecté à l'utilisateur $3"
            else
                echo "Une erreur c'est produite, le mot de passe $4 n'a pas été affecté à l'utilisateur $3"
            fi
        else
            echo "Une erreur c'est produite, l'utilisateur $2 n'a pas été renommé en $3"
        fi
    fi
}


function rename_user() {

    mysql --user="root" --password="pedagogieintech" --execute="RENAME USER '$1'@'localhost' TO '$2'@'localhost';"
    if [ $? -eq 0 ]; then
        echo "l'utilisateur $1 a été renommé en $2"
    else
        echo "Une erreur c'est produite, l'utilisateur $1 n'a pas été renommé en $2"
    fi
}


function show_user() {
    mysql --user="root" --password="pedagogieintech" --execute="SELECT user FROM mysql.user;"
}


function show_privilege() {
    mysql --user="root" --password="pedagogieintech" --execute="SHOW GRANTS FOR '$1'@'localhost';"
}