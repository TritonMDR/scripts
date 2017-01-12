if [ "$1" != "cloud" ] || [ "$1" != "database" ] || [ "$1" != "mail" ] || [ "$1" != "triton" ]
	then
		echo -e ' \n Suppression du FQDN en cours...'
			sed -i "/+$1$2.triton.itinet.fr:88.177.168.133:86400/d" /etc/tinydns/root/data
			if [ $? -eq 0 ]; then
				echo -e ' ... Fait \n'
			else
				echo " Une erreur est survenue lors de la suppression du fqdn : $1$2.triton.itinet.fr"
			fi
	else
		echo " Opération impossible"
	fi
