if (test -e /etc/postfix/vmailbox)
then
    echo " - Fichier vmailbox trouvé"
    echo " - Vérification de l'existence de l'utilisateur..."
    grep "$1@" /etc/postfix/vmailbox &>/dev/null
    if [ "$?" != "0" ]
    then
        echo " - L'utilisateur n'existe pas"
        echo "$1@triton.itinet.fr $1/" >> /etc/postfix/vmailbox
        if !(test -d /var/mail/$1)
        then
            echo " - Création du dossier utilisateur"
            maildirmake /var/mail/$1
            echo " - Attribution des droits dossier"
            chown -R vmail:vmail /var/mail/$1
userdb $1 set uid=5000 gid=5000 home=/var/mail/$1 mail=/var/mail/$1
userdb $1 set systempw=$(openssl passwd -1 $2)<<EOF
$2
$2
EOF
        fi
        echo " - Création OK"
        echo "Rechargement des services..."
        postmap /etc/postfix/vmailbox
        postfix reload
        makeuserdb
    else
        echo " - L'utilisateur existe déjà"
    fi
fi
echo "___________________"
