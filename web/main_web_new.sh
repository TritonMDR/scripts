
function main_web () {

	while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
		echo -e " \n ######## MENU - Gestion Général -> WEB ######## "
		echo -e " 0) Gestion  de base donnée (Utilisateurs, Base de données) \n 1) Cloner un site (Paramètres : ID de l'utilisateur, URL du site à cloner) \n 2) Gestion des Vhost (Créer, Supprimer, Afficher les Vhost) \n "
		read -p " Votre choix (Q ou q pour quitter) : " action

		if [ $action = 0 ]; then
			main_bdd
		elif [ $action = 1 ]; then
			main_crawler
		elif [ $action = 2 ]; then
			main_vhost
		fi

		if [ $action = 'Q' ] || [ $action = 'q' ]; then
			exit
		fi
	done
}
