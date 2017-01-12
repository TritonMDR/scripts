#!/bin/bash

                ########################################################
                ######      [ CRAWLER - Script principal ]        ######
                ######   Gestion des fonctionnalités du crawler   ######
                ######              Auteur : B. Zmuda             ######
                ########################################################

# Sources                
source fonctions/crawler.sh

function main_crawler () {

     while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
        echo -e " 0) Cloner un site \n 1) Supprimer un site \n "
        read -p " Votre choix (Q ou q pour quitter) : " action

        if [ $action = 0 ]; then
        fi

        if [ $action = 'Q' ] || [ $action = 'q' ]; then
            exit
        fi
    done
}