#!/bin/bash

# Sources
source require.sh

while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do

    echo -e " \n ######## MENU PRINCIPAL ######## "
    echo -e " 0) Gestion général (DNS, MAIL, WEB) \n 1) Automatisation (Création d'un compte utilisateur unix, Cloner un site) \n "
    read -p " Votre choix (Q ou q pour quitter) : " action
    
    if [ $action = 0 ]; then
        echo -e " \n ######## MENU - Gestion Général ######## "
        echo -e " 0) DNS (Gestion FQDN) \n 1) MAIL (Utilisateurs, Relayhost) \n 2) WEB (Gestion de base de donnée, Cloner un site, Gestion des Vhost) \n "
        read -p " Votre choix (Q ou q pour quitter) : " action

        if [ $action = 0 ]; then
            main_dns
       elif [ $action = 1 ]; then
           main_mail
        elif [ $action = 2 ]; then
            main_web
        fi
    elif [ $action = 1 ]; then
        echo -e " \n ######## MENU - Automatisation ######## "
        echo -e " 0) Utilisateurs \n 1) Phishing WEB \n 2) Hébergement web \n 3) Usurpation mail \n "
        read -p " Votre choix (Q ou q pour quitter) : " action

        if [ $action = 0 ]; then
        ### Utilisateurs ###
            ./user/fonctions/automatique/main_user.sh
        elif [ $action = 1 ]; then
        ### Phishing WEB ###
            echo -e " 0) Cloner un site \n 1) Supprimer un site cloné \n "
            read -p " Votre choix (Q ou q pour quitter) : " action

            if [ $action = 0 ]; then
                ./web/auto_clone.sh
            elif [ $action = 1 ]; then
                ./web/delete_clone.sh
            fi
        elif [ $action = 2 ]; then
        ### Hébergement web ###
            echo -e " 0) Créer un espace d'hébergement \n 1) Supprimer un espace d'hébergement \n "
            read -p " Votre choix (Q ou q pour quitter) : " action

            read -p " Entrez le nom de l'utilisateur : " name
            if [ $action = 0 ]; then
                read -p " Entrez un mot de passe : " passwd
                ./web/hosting/fonctions/automatique/add_hosting.sh $name $passwd
            elif [ $action = 1 ]; then
                ./web/hosting/fonctions/automatique/delete_hosting.sh $name
            fi
        elif [ $action = 3 ]; then
        ### Usurpation mail ###
            mail_send
        fi
    fi

    if [ $action = 'Q' ] || [ $action = 'q' ]; then
            exit
    fi
done
