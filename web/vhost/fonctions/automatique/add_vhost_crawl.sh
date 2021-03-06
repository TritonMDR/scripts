echo "server {
            listen 80;
            server_name $1$2.triton.itinet.fr;
            root /var/www/html/$1/$3;
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
    }" > /etc/nginx/sites-available/$1$2

        if [ $? -eq 0 ]; then
            echo "réussi"
            ln -s /etc/nginx/sites-available/"$1$2" /etc/nginx/sites-enabled/
            if [ $? -eq 0 ]; then
                echo "Le lien symbolique a été crée avec succès "
            else
                echo "Une erreur c'est produite lors de la création du lien symbolique"
            fi
        else
            echo "Une erreur c'est produite, le vhost pour le site $1$2.triton.itinet.fr n'a pas été crée"
        fi