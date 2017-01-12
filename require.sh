
## DNS ##
source ./dns/main_dns.sh
source ./dns/fonctions/gestion/fqdn.sh
#source ./dns/fonctions/automatique/fqdn.sh

## MAIL ##
            ### MENU ###
source ./mail/main_mail_new.sh
            ### GESTION ###
source ./mail/fonctions/gestion/host.sh
source ./mail/fonctions/gestion/send.sh
source ./mail/fonctions/gestion/users.sh
            ### Automatique ###

## WEB ##
source ./web/main_web_new.sh

                   #########
################### CRAWLER ###################
                   #########

                ### MENU ###
source ./web/crawler/main_crawler_new.sh
                ### GESTION ###
source ./web/crawler/fonctions/gestion/crawler.sh
                ### Automatique ###
#source ./web/crawler/fonctions/automatique/crawler.sh

                ###########
################### BDD ###################
                ###########

                ### MENU ###
source ./web/bdd/main_bdd.sh
                ### GESTION ###
source ./web/bdd/fonctions/gestion/bdd.sh
source ./web/bdd/fonctions/gestion/users.sh
                ### Automatique ###
#source ./web/bdd/fonctions/automatique/bdd.sh
#source ./web/bdd/fonctions/automatique/users.sh

                    ###########
################### VIRTUALHOST ###################
                    ###########

                ### MENU ###
source ./web/vhost/main_vhost_new.sh
                ### GESTION ###
source ./web/vhost/fonctions/gestion/vhost.sh
                ### Automatique ###
#source ./web/vhost/fonctions/automatique/vhost.sh
