echo ' Ajout du FQDN ... \n'
sudo echo '+'$1'.triton.itinet.fr:88.177.168.133:86400' >> /etc/tinydns/root/data

if [ $? -eq 0 ]; then
    echo '...Fait'
else
    echo "Une erreur est survenue lors de l'ajout du FQDN : $1"
fi