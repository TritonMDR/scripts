if (test -e /etc/postfix/vmailbox)
then
    echo " - Fichier vmailbox trouvé"
    grep "$1@" /etc/postfix/vmailbox &>/dev/null
    echo " - Vérification de l'existence de l'utilisateur"
    if [ "$?" = "0" ]
    then
        echo " - Existence OK"
        sed -ie "/$1@/d" /etc/postfix/vmailbox
        rm -rf /var/spool/mail/$1
        sed -ie "/$1|/d" /etc/courier/userdb
        echo " - Suppression OK"
    else
        echo " - L'utilisateur n'existe pas"
    fi
else
    echo " - Fichier vmailbox non trouvé"
fi

echo " - Rechargement des services ..."
postmap /etc/postfix/vmailbox
postfix reload
makeuserdb
/etc/init.d/courier-authdaemon force-reload
/etc/init.d/courier-imap force-reload
echo "___________________"