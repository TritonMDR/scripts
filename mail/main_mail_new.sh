
function main_mail () {

        while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
                echo -e " \n ######## MENU GESTION - MAIL ######## "
                echo -e " 0) Utilisateurs (Créer un utilisateur, Supprimer un utilisateur, Afficher la liste des utilisateurs) \n 1) Host (Modifier le relayhost, Afficher le relayhost) \n 2) Envoyer un mail usurpé \n "
                read -p " Votre choix (Q ou q pour quitter) : " action

                if [ $action = 0 ]; then
                        echo -e " 0) Créer un utilisateur \n 1) Supprimer un utilisateur \n 2) Afficher la liste des utilisateurs \n "
                        read -p " Votre choix (Q ou q pour quitter) : " action

                        if [ $action = 0 ]; then
                                mail_create_user
                        elif [ $action = 1 ]; then
                                mail_delete_user
                        elif [ $action = 2 ]; then
                                mail_show_users
                        fi
                elif [ $action = 1 ]; then
                        echo -e " 0) Modifier le relayhost \n 1) Afficher le relayhost \n "
                        read -p " Votre choix (Q ou q pour quitter) : " action

                        if [ $action = 0 ]; then
                                mail_modify_host
                        elif [ $action = 1 ]; then
                                mail_show_host
                        fi
                elif [ $action = 2 ]; then
                        mail_send
                fi

                if [ $action = 'Q' ] || [ $action = 'q' ]; then
                        exit
                fi
        done
}
