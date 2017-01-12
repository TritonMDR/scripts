if test -d /var/www/html/$1
then
    cd /var/www/html/$1/
    rm -rf $2
else
    echo 'Opération impossible'
fi
