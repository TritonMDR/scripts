#!/bin/bash

                ########################################################
                ######         [ VHOST - Script principal ]       ######
                ######           Gestion des Virtual Host         ######
                ######         Auteur : A. Traoré, B. Zmuda       ######
                ########################################################

function main_vhost () {

     while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
        echo -e " 0) Créer un Vhost \n 1) Supprimer un Vhost \ 2) Afficher la liste des Vhost \n"
        read -p " Votre choix (Q ou q pour quitter) : " action

        if [ $action = 0 ]; then
            add_vhost
        elif [ $action = 1 ]; then
            delete_vhost
        elif [ $action = 2 ]; then
            show_vhost
        fi

        if [ $action = 'Q' ] || [ $action = 'q' ]; then
            exit
        fi
    done
}
