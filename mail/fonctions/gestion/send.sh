
function mail_send () {
    
    read -p " Entrez l'adresse d'émission : " from
    read -p " Entrez le destinataire : " to
    read -p " Sujet du mail : " subject
    read -p " Message : " message
    telnet localhost 25 <<EOF
ehlo triton.itinet.fr
mail from:$from
rcpt to:$to
data
subject:$subject
$message
.
EOF
echo " Mail envoyé avec succès"

}
