#!/bin/bash

function add_fqdn ()
{
    echo 'Ajout du FQDN ... \n'
    echo '+'$1'.triton.itinet.fr:88.177.168.133:86400' >> /etc/tinydns/root/data
    echo '\n...Fait'
}

function delete_fqdn ()
{
    echo 'Suppression du FQDN ... \n'
    sed -i -e "s/+$1.triton.itinet.fr:88.177.168.133:86400//g" /etc/tinydns/root/data
    echo '\n... Fait'
}