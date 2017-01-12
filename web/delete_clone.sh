# $1 = user | $2 = site

read -p " Nom de l'utilisateur : " user 
read -p " Indiquez le site à supprimer (ex : www.google.fr) : " site

cut1=${site#*.}
echo " après 1ère découpe : $cut1"
cut2=${cut1%.*}
echo " après 2ème découpe : $cut2"
site2=$cut2

./dns/fonctions/automatique/delete_fqdn_crawl.sh $user $site2
./web/vhost/fonctions/automatique/delete_vhost_crawl.sh $user $site2
cd /var/www/html/$user
 rm -rf $site
 cd /home/benji
 ./maj_zone.sh

