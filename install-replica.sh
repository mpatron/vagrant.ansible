#!/usr/bin/bash
set -x
# export IPA_SERVER_PASSWORD=Welcome1
# export IPA_SERVER_NAME=node1
# export IPA_SERVER_DOMAIN=jobjects.net
# export IPA_SERVER_IP=192.168.56.141
# export IPA_SERVER_NTP=0.fr.pool.ntp.org

ntpdate -su $IPA_SERVER_NTP

ipa-replica-install --principal admin --admin-password $IPA_SERVER_PASSWORD --server $IPA_SERVER_NAME.$IPA_SERVER_DOMAIN --domain=$IPA_SERVER_DOMAIN --setup-ca --unattended
