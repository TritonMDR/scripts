### ARGUMENTS ###
# $1 = name (nom utilisateur) | $2 = passwd (mdp user) | $3 = hebergement web | $4 = réponse user au compte mail | $5 = fqdn | $6 = bdd

echo -e " \n ############# Création de l'utilisateur '$1' en cours ... ############# \n"

sudo useradd -m -s /usr/bin/mysecureshell $1 &>/dev/null
if [ $? -eq 0 ]; then
    echo " L'utilisateur '$1' à été crée avec succès "
    sudo echo "$1:$2" | sudo chpasswd &>/dev/null
    if [ $? -eq 0 ]; then
        echo " Le mot de passe '$2' a été assigné à '$1' avec succès "
        echo -e " ############# Création de l'utilisateur '$1' terminé ############# \n"
        sudo mkdir /var/www/html/$1 &>/dev/null
        sudo chown -R www-data:www-data /var/www/html/$1 &>/dev/null

        if [ "$6" != "FALSE" ]; then
            echo -e " \n ############# Création des comptes MYSQL et BDD de l'utilisateur '$1' en cours ... ############# \n"
            ### Création d'un compte MYSQL ###
            sudo bash /home/triton/script_shell/web/bdd/fonctions/automatique/add_user.sh $1 $2
            ### Création d'une BDD ###
            sudo bash /home/triton/script_shell/web/bdd/fonctions/automatique/add_bdd.sh $1
            echo -e " \n ############# Création des comptes MYSQL et BDD de l'utilisateur '$1' terminé ... ############# \n \n Vous pouvez désormais accéder à votre BDD : db.triton.itinet.fr \n Nom de la BDD : '$1', vos identifiants : '$1' | Mot de passe : '$2' "
        fi

        ### Création comptes MAIL ###
        if [ "$4" != "FALSE" ]; then
            echo -e " \n ############# Création de l'utilisateur mail '$1' en cours ... ############# \n "
            sudo bash /home/triton/script_shell/mail/fonctions/automatique/add_user.sh $1 $2
            echo -e " \n ############# Création de l'utilisateur mail '$1' terminé ############# \n \n Vous pouvez désormais accéder à votre messagerie sécurisée : mail.triton.itinet.fr \n Vos identifiants : '$1'' ou $1@triton.itinet.fr | Mot de passe : '$2' \n "
        fi

        ### Création comptes WEB ###
        if [ "$3" != "FALSE" ]; then
            echo -e " \n ############# Création des comptes WEB de l'utilisateur '$1' en cours ... ############# \n "
            ### Création du répertoire de l'utilisateur dans /var/www/html/ ###
            sudo mkdir /var/www/html/$1/myhost &>/dev/null
            ### Création de la page d'accueil du site ###
	    sudo chown -R www-data:www-data /var/www/html/$1/myhost &>/dev/null
            sudo touch /var/www/html/$1/myhost/index.php
            sudo echo "<div align='center'><b>BIENVENUE SUR LE SITE DE : $1</b></div>" >> /var/www/html/$1/myhost/index.php
            ### Création d'un FQDN pour l'utilisateur ###
            sudo bash /home/triton/script_shell/dns/fonctions/automatique/add_fqdn_user.sh $5
            ### Création d'un VHOST ###
            sudo bash /home/triton/script_shell/web/vhost/fonctions/automatique/add_vhost_user.sh $1 $5
            sudo bash /home/triton/script_shell/web/vhost/fonctions/automatique/sed_user.sh $1
            ### Création d'un compte Owncloud ###

            ### Finalisation de l'installation ###
            sudo cd /home/benji
            sudo bash /home/benji/auto/maj_zone.sh
            sudo service nginx reload
            echo -e " \n ############# Création des comptes WEB de l'utilisateur '$1' terminé ... ############# \n Vous pouvez désormais accéder à votre site : $5.triton.itinet.fr \n Vos identifiants SFTP  : $1 | Mot de passe : $2 \n Vous pouvez désormais accéder à votre BDD : database.triton.itinet.fr \n Nom de la BDD : '$1', vos identifiants : '$1' | Mot de passe : '$2' "
        fi
    else
        echo " Une erreur est survenue lors de l'assignation du mdp : '$2' à l'utilisateur : '$1'"
    fi
else
        echo " Une erreur est survenue la création de l'utilisateur : '$2' "
fi
