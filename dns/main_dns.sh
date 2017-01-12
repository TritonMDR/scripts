
function main_dns () {

	while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
		echo -e " \n ######## MENU - Gestion général -> DNS ######## "
		echo -e " 0) Créer un FQDN (paramètre : Nom) \n 1) Supprimer un FQDN (paramètre : Nom) \n "
		read -p " Votre choix (Q ou q pour quitter) : " action

		if [ $action = 0 ]; then
			read -p " Entrez le nom du FQDN : " fqdn
			add_fqdn $fqdn
		elif [ $action = 1 ]; then
			read -p " Entrez le nom du FQDN (ID + Suffix | ex : 001test) : " fqdn

			delete_fqdn $fqdn
		fi

		if [ $action = 'Q' ] || [ $action = 'q' ]; then
			exit
		fi
	done
}
		
