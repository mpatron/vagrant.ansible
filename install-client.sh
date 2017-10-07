#!/usr/bin/bash
set -x
# export IPA_SERVER_PASSWORD=Welcome1
# export IPA_SERVER_NAME=node1
# export IPA_SERVER_DOMAIN=jobjects.net
# export IPA_SERVER_IP=192.168.56.142
# export IPA_SERVER_NTP=ntp1.net-courrier.extra.laposte.fr

ntpdate -su $IPA_SERVER_NTP

ipa-client-install --hostname=`hostname -f` --server=$IPA_SERVER_NAME.$IPA_SERVER_DOMAIN --domain=$IPA_SERVER_DOMAIN --ntp-server=$IPA_SERVER_NTP -U -p admin -w $IPA_SERVER_PASSWORD
authconfig --enablemkhomedir --update
