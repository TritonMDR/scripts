function add_fqdn () {
	
	echo ' Ajout du FQDN ... \n'
	echo '+'$fqdn'.triton.itinet.fr:88.177.168.133:86400' >> /etc/tinydns/root/data
	echo ' \n...Fait'
}

function delete_fqdn () {

	if [ "$fqdn" != "cloud" ] || [ "$fqdn" != "database" ] || [ "$fqdn" != "mail" ] || [ "$fqdn" != "triton" ]
	then
		echo -e ' \n Suppression du FQDN en cours...'
			sed -i "/+$fqdn.triton.itinet.fr:88.177.168.133:86400/d" /etc/tinydns/root/data
			if [ $? -eq 0 ]; then
				echo -e ' ... Fait \n'
			else
				echo " Une erreur est survenue lors de la suppression du fqdn : $fqdn"
			fi
	else
		echo " Opération Impossible"
	fi
}
