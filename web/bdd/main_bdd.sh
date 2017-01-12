#!/bin/bash

            ########################################################
            ######       [ MariaDB - Script principal ]       ######
            ######      Gestion des fonctionnalités MySQL     ######
            ######            Auteur : A. Traoré              ######
            ########################################################

function main_bdd () {

    while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
        echo -e " \n ######## MENU Gestion - Générale -> WEB -> BDD ######## "
        echo -e " 0) Utilisateurs (Créer, Supprimer, Modifier, Renommer, Afficher tous les utilisateurs, Afficher les privilèges d'un utilisateur) \n 1) Base de données (Créer, Supprimer, Modifier les droits d'accès d'une base, Afficher les bases de données, Afficher les droits d'une base) \n " 
        read -p " Votre choix (Q ou q pour quitter) : " action
        if [ $action = 0 ]; then
                                ################## USER ##################
            echo -e " \n ######## MENU Gestion - Générale -> WEB -> BDD -> Utilisateurs ######## "
            echo -e " \n 0) Créer un utilisateur \n 1) Supprimer un utilisateur \n 2) Modifier un utilisateur \n 3) Renommer un utilisateur \n 4) Afficher la liste des utilisateurs \n 5) Afficher les privilèges d'un utilisateur \n " 
            read -p " Votre choix (Q ou q pour quitter) : " action
            if [ $action = 0 ]; then
                ## ADD USER ##
                read -p " Nom de l'utilisateur : " name
                read -p " Mot de passe de l'utilisateur : " passwd

                add_user $name $passwd
            elif [ $action = 1 ]; then
                ## DELETE USER ##
                show_user
                read -p " Nom de l'utilisateur à supprimer : " name

                delete_user $name
            elif [ $action = 2 ]; then
                ## UPDATE USER ##
                echo -e " \n 0) Modifier le nom d'un utilisateur \n 1) Modifier le mot de passe d'un utilisateur \n 2) Modifier le nom et le mot de passe d'un utilisateur \n " 
                read -p " Votre choix (Q ou q pour quitter) : " action

                if [ $action = 0 ]; then
                    read -p " Nom de l'utilisateur à modifier : " past_name
                    read -p " Nouveau nom : " new_name

                    update_user $action $past_name $new_name
                elif [ $action = 1 ]; then
                    show_user
                    read -p " Nom de l'utilisateur : " name 
                    read -p " Nouveau mot de passe : " new_passwd

                    update_user $action $name $new_passwd
                elif [ $action = 2 ]; then
                    show_user

                    read -p " Nom de l'utilisateur à modifier : " past_name 
                    read -p " Nouveau nom : " new_name

                    read -p " Nouveau mot de passe : " new_passwd

                    update_user $action $past_name $new_name $new_passwd
                fi
            elif [ $action = 3 ]; then
                ## RENAME USER ##
                show_user

                read -p " Nom de l'utilisateur à modifier : " past_name
                read -p " Nouveau nom : " new_name
                
                rename_user $past_name $new_name
            elif [ $action = 4 ]; then
                ## SHOW USER ##
                show_user
            elif [ $action = 5 ]; then
                ## SHOW USER ##
                show_user
                read -p " Nom de l'utilisateur dont vous souhaitez afficher les droits : " name

                show_privilege $name
            fi
        elif [ $action = 1 ]; then
                                ################## DATABASE ##################
            echo -e " \n ######## MENU Gestion - Générale -> WEB -> BDD -> Base de donnée ######## "
            echo -e " \n 0) Créer une base de donnée \n 1) Supprimer une base de donnée \n 2) Modifier les droits d'accès d'une base de donnée \n 3) Afficher les bases de données \n 4) Afficher les droits d'une base de donnée \n " 
            read -p " Votre choix (Q ou q pour quitter) : " action
            if [ $action = 0 ]; then
                ## ADD DATABASE ##
                read -p " Nom pour la bdd : " name
                add_bdd $name
            elif [ $action = 1 ]; then
                ## DELETE DATABASE ##
                read -p " Entrez le nom de la bdd à supprimer : " bdd
                delete_bdd $bdd
            elif [ $action = 2 ]; then
                ## UPDATE DATABASE PRIVILEGE ##
                echo -e " \n 0) ALL (Autoriser l'accès complet à une base de données spécifique) \n 1) CREATE (Autoriser un utilisateur à créer des bases de données et des tables) \n 2) DELETE (Autoriser un utilisateur à supprimer des lignes d'une table) \n 3) DROP (Permettre à un utilisateur de supprimer des bases de données et des tables) \n 4) EXECUTE (Autoriser un utilisateur à exécuter des routines stockés) \n 5) GRANT OPTION (Permettre à un utilisateur d'accorder ou de supprimer les privilèges d'un autre utilisateur) \n 6) INSERT (Autoriser un utilisateur à insérer des lignes d'une table) \n 7) SELECT (Permettre à un utilisateur de sélectionner des données dans une base de données) \n 8) SHOW DATABASES (Autoriser un utilisateur à afficher une liste de toutes les bases de données) \n 9) UPDATE (Autoriser un utilisateur à mettre des lignes dans une table) "
                read -p " Votre ou vos choix (attention, vous devez taper le droit) : " privilege
                read -p " Nom de l'utilisateur : " user
                read -p " Nom de la base de donnée : " db_name

                update_bdd_privilege $privilege $user $db_name
            elif [ $action = 3 ]; then
                ## SHOW DATABASE ##
                show_bdd
            elif [ $action = 4 ]; then
                ## SHOW DATABASE PRIVILEGE ##
                echo "LANCER FONCTION SHOW DATABASE PRIVILEGE"
            fi
        fi

        if [ $action = 'Q' ] || [ $action = 'q' ]; then
            exit
        fi
    done
}
