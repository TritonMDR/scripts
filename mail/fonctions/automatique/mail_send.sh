    telnet localhost 25 <<EOF
ehlo triton.itinet.fr
mail from:$1
rcpt to:$2
data
subject:$3
$4
.
EOF
