
function mail_show_users () {
    
    cat /etc/postfix/vmailbox | cut -d@ -f1
}

function mail_create_user () {

    read -p " - Entrez le nom d'utilisateur à rajouter : " arg
    if (test -e /etc/postfix/vmailbox)
    then
        echo " - Fichier vmailbox trouvé"
        echo " - Vérification de l'existence de l'utilisateur..."
        grep "$arg@" /etc/postfix/vmailbox &>/dev/null
        if [ "$?" != "0" ]
        then
            echo " - L'utilisateur n'existe pas"
            echo "$arg@triton.itinet.fr $arg/" >> /etc/postfix/vmailbox
            if !(test -d /var/spool/mail/$arg)
            then
                echo " - Création du dossier utilisateur"
                mkdir /var/spool/mail/$arg
                mkdir /var/spool/mail/$arg/new
                mkdir /var/spool/mail/$arg/cur
                mkdir /var/spool/mail/$arg/tmp
                echo " - Attribution des droits dossier"
                chown -R vmail:vmail /var/spool/mail/$arg
                userdb $arg set uid=5000 gid=5000 home=/var/mail/$arg mail=/var/mail/$arg
                userdbpw -md5 | userdb $arg set systempw
            fi
            echo " - Création OK"
        else
            echo " - L'utilisateur existe déjà"
        fi
    fi
    echo " Rechargement des services..."
    postmap /etc/postfix/vmailbox
    postfix reload
    makeuserdb
    /etc/init.d/courier-authdaemon force-reload
    /etc/init.d/courier-imap force-reload
    echo "___________________"
}

function mail_delete_user () {

    read -p " - Entrez le nom d'utilisateur à supprimer : " arg
    if [ $arg ]
    then
        if (test -e /etc/postfix/vmailbox)
        then
            echo " - Fichier vmailbox trouvé"
            echo " - Vérification de l'existence de l'utilisateur"
            grep "$arg@" /etc/postfix/vmailbox &>/dev/null
            if [ "$?" = "0" ]
            then
                echo " - Existence OK"
                sed -ie "/$arg@/d" /etc/postfix/vmailbox
                rm -rf /var/mail/$arg
                sed -ie "/$arg|/d" /etc/courier/userdb
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
        echo " ___________________"
    else
        echo " Mauvaise entrée utilisateur"
    fi

}
