test -d /var/www/html/$1/myhost &>/dev/null
if [ $? = 0 ]; then
    echo " Vous possédez déjà un espace d'hébergement "  
elif [ $? = 1 ]; then
    ### Création du répertoire myhost ###
    mkdir /var/www/html/$1/myhost &>/dev/null

    echo -e " ############# Création des comptes WEB de l'utilisateur '$1' en cours ... ############# \n "
    ### Création de la page d'accueil du site ###
    touch /var/www/html/$1/myhost/index.php
    echo "<div align='center'><b>BIENVENUE SUR LE SITE DE : $1</b></div>" > /var/www/html/$1/myhost/index.php

    chown -R $1 /var/www/html/$1/myhost &>/dev/null
    ### Création d'un FQDN pour l'utilisateur ###
    ./dns/fonctions/automatique/add_fqdn_user.sh $1
    ### Création d'un VHOST ###
    ./web/vhost/fonctions/automatique/add_vhost_user.sh $1
    ./web/vhost/fonctions/automatique/sed_user.sh $1
    ### Création d'un compte MYSQL ###
    ./web/bdd/fonctions/automatique/add_user.sh $1 $2
    ### Création d'une BDD ###
    ./web/bdd/fonctions/automatique/add_bdd.sh $1 $2
    ### Création d'un compte Owncloud ###

    ### Finalisation de l'installation ###
    cd /home/benji
    ./maj_zone.sh
    service nginx reload
    echo -e " \n ############# Création des comptes WEB de l'utilisateur '$1' terminé ... ############# \n Vous pouvez désormais accéder à votre site : $1.triton.itinet.fr \n Vos identifiants SFTP  : $1 | Mot de passe : $2 \n Vous pouvez désormais accéder à votre BDD \n Vos identifiants : Nom de la BDD : $1 | utilisateur : $1 | Mot de passe : $2 "
fi

