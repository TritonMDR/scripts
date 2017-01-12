
function mail_modify_host () {

    echo " - Entrez le nouveau relayhost"
    read new_relayhost
    if (test -e /etc/postfix/main.cf)
    then
        echo " - Fichier main.cf trouvé"
        sed -i.bak -E 's/^([ \t]*relayhost[ \t]*=[ \t]*).*/\1'"$new_relayhost"'/' /$
        echo "Modification du relayhost effectuée"
        echo "new relayhost : " && grep "relayhost" /etc/postfix/main.cf
    else
        echo " - Fichier main.cf non trouvé"

    fi
        echo "                                                                     $
                                                                                   $
                                                                                   $
                                                                                   $
    "
        postfix reload
        echo "___________________"
}

function mail_show_host () {
    
    if (test -e /etc/postfix/main.cf)
    then
        grep "relayhost" /etc/postfix/main.cf
    fi
    echo "___________________"
}

