sed -i -e 's/fastcgi_param SCRIPT_FILENAME ;/fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;/g' /etc/nginx/sites-available/$1$2
sed -i -e 's/fastcgi_param PATH_INFO ;/fastcgi_param PATH_INFO $fastcgi_path_info;/g' /etc/nginx/sites-available/$1$2
