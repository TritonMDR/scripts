echo -e " \n ######## MENU - Automatisation -> CRéer un utilisateur ######## "
echo -e " 0) Créer un utilisateur unix (comptes liés : sftp, owncloud, mail, mysql users) \n 1) Supprimer un utilisateur (actions liées : sftp, owncloud, mail, mysql users) \n "
read -p " Votre choix (Q ou q pour quitter) : " action

if [ $action = 0 ]; then
### Création d'un utilisateur ###
    read -p " Entrez le nom de l'utilisateur : " name
    read -p " Entrez le mot de passe pour l'utilisateur $name : " passwd 
    read -p " Entrez le type d'utilisateur ( 0) Lite | 1) Pro ) : " user_type
    read -p " Souhaitez vous créer un compte mail ? (oui ou non) : " answer_mail

    if [ $user_type = 0 ]; then
    ### Lite ###
        if [ $answer_mail = "non" ]; then
            answer_mail="FALSE"
            answer_cloud="FALSE"
            ./user/fonctions/automatique/add_unix_user.sh $name $passwd $user_type $answer_cloud $answer_mail
        elif [ $answer_mail = "oui" ]; then
            answer_cloud="FALSE"
            ./user/fonctions/automatique/add_unix_user.sh $name $passwd $user_type $answer_cloud $answer_mail
        fi
    elif [ $user_type = 1 ]; then
        ### Pro ###
        read -p " Souhaitez vous posséder votre propre site web ? (oui ou non) : " answer_cloud
        if [ $answer_cloud = "oui" ] && [ $answer_mail = "oui" ]; then
            echo -e " \n ######## Configuration FQDN ######## \n"
            read -p ' Quel nom de domaine souhaitez vous utiliser ? ' fqdn

            ./user/fonctions/automatique/add_unix_user.sh $name $passwd $user_type $answer_cloud $answer_mail $fqdn
        elif [ $answer_cloud = "non" ] && [ $answer_mail = "oui" ]; then
            answer_cloud="FALSE"
            ./user/fonctions/automatique/add_unix_user.sh $name $passwd $user_type $answer_cloud $answer_mail
        elif [ $answer_cloud = "oui" ] && [ $answer_mail = "non" ]; then
            echo -e " \n ######## Configuration FQDN ######## \n"
            read -p ' Quel nom de domaine souhaitez vous utiliser ? ' fqdn

            answer_mail="FALSE"
            ./user/fonctions/automatique/add_unix_user.sh $name $passwd $user_type $answer_cloud $answer_mail $fqdn
        elif [ $answer_cloud = "non" ] && [ $answer_mail = "non" ]; then
            answer_mail="FALSE"
            answer_cloud="FALSE"
            ./user/fonctions/automatique/add_unix_user.sh $name $passwd $user_type $answer_cloud $answer_mail
        fi
    fi
elif [ $action = 1 ]; then
    ### Suppression d'un utilisateur ###
    read -p " Entrez le nom de l'utilisateur : " name

    ./user/fonctions/automatique/delete_unix_user.sh $name
fi