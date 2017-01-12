
function crawl_website () {

	read -p " Entrez le nom de l'utilisateur : " name
	read -p " Entrez l'url du site à cloner : " url

	mkdir /var/www/html/$name/$url &>/dev/null
	wget -p --convert-links --directory-prefix=/var/www/html/$name/$url &>/dev/null
	if [ $? -eq 0 ]; then
		echo " Le site à été cloné avec succès"
	else
		echo " Une erreur est survenue lors du clonage du site, veuillez réessayer "
	fi
}

function delete_website () {

	read -p " Entrez le nom de l'utilisateur : " name
	read -p " Entrez le nom du site à supprimer : " url
	
	rm -d /var/www/html/$name/$url
	if [ $? -eq 0 ]; then
		echo " Le site à été avec succès"
	else
		echo " Une erreur est survenue lors de la suppression du site "
	fi
}
