   read -p ' Indiquez le site a crawler (ex : www.google.fr) : ' site
   read -p ' Nom du site crawlé ? : ' name #$2
   read -p " Nom de l'utilisateur ? : " user 

    ./web/crawler/fonctions/automatique/add_crawler.sh $name $user $site
    if [ exit $? ]; then
        chmod 755 /var/www/html/$user/$site
        chown -R www-data:www-data /var/www/html/$user/$site
        ./dns/fonctions/automatique/add_fqdn_crawl.sh $user$name
        ./web/vhost/fonctions/automatique/add_vhost_crawl.sh $user $name $site
        ./web/vhost/fonctions/automatique/sed_crawl.sh $user $name
        cd /var/www/html/$user/$site
        mv index.html index.php
        cd /home/benji
        ./maj_zone.sh
        service nginx reload
    else
        exit
    fi
