#!/bin/bash

function show_vhost () {
    echo -e "\n "
    ls /etc/nginx/sites-enabled
    echo -e " \n"
}

function add_vhost () {

    read -p ' ID : ' id
    read -p ' url : ' url
    read -p ' suffixe : ' suff

    echo "server {
            listen 80;
            server_name $id$suff.triton.itinet.fr;
            root /var/www/html/$id/$url;
            index index.php;
            location ~ ^/(build|tests|config|lib|3rdparty|templates|data)/{
            deny all;
        }
        location ~ \.php(?:$|/){
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $fastcgi_path_info;
            fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }
    }" > /etc/nginx/sites-available/$id$suff

        if [ $? -eq 0 ]; then
            echo "réussi"
            ln -s /etc/nginx/sites-available/$id$suff /etc/nginx/sites-enabled/
            if [ $? -eq 0 ]; then
                echo "Le lien symbolique a été crée avec succès "
            else
                echo "Une erreur c'est produite lors de la création du lien symbolique"
            fi
        else
            echo "Une erreur c'est produite, le vhost pour le site $id$suff.triton.itinet.fr n'a pas été crée"
        fi
}

function add_auto_vhost () {
# $6 = ID
# $7 = url
# $8 = suffixe

    echo "server {
            listen 80;
            server_name $6$8.triton.itinet.fr;
            root /var/www/html/$6/$7;
            index index.php;
            location ~ ^/(build|tests|config|lib|3rdparty|templates|data)/{
            deny all;
        }
        location ~ \.php(?:$|/){
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $fastcgi_path_info;
            fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }
    }" > /etc/nginx/sites-available/$6$8

        if [ $? -eq 0 ]; then
            echo "réussi"
            ln -s /etc/nginx/sites-available/$6$8 /etc/nginx/sites-enabled/
            if [ $? -eq 0 ]; then
                echo "Le lien symbolique a été crée avec succès "
            else
                echo "Une erreur c'est produite lors de la création du lien symbolique"
            fi
        else
            echo "Une erreur c'est produite, le vhost pour le site $6$8.triton.itinet.fr n'a pas été crée"
        fi
}


function delete_vhost () {
    
    read -p ' ID : ' id
    read -p ' Suff : ' suff

    rm /etc/nginx/sites-available/$id$suff
    rm /etc/nginx/sites-enabled/$id$suff
    if [ $? -eq 0 ]; then
        rm -i $1 -f
            if [ $? -eq 0 ]; then
                echo "Le lien symbolique a été supprimé avec succès"
            else
                echo "Une erreur c'est produite lors de la suppression du lien symbolique"
            fi
        else
            echo "Une erreur c'est produite, le vhost pour le site $id$suff.triton.itinet.fr n'a pas été supprimé"
        fi
}