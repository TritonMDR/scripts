function main_crawler () {
	
	while [ -z $action ] || [ $action != 'Q' ] || [ $action != 'q' ]; do
		echo -e " 0) Cloner un site \n 1) Supprimer un site " 
		read -p " Votre ou vos choix : " action
		if [ $action = 0 ]; then
			crawl_website
		elif [ $action = 1 ]; then
			delete_website
		fi

		if [ $action = 'Q' ] || [ $action = 'q' ]; then
			exit
		fi
	done
}
