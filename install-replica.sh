#!/usr/bin/bash
set -x
export IPA_SERVER_PASSWORD=Welcome1
export IPA_SERVER_NAME=node1
export IPA_SERVER_DOMAIN=jobjects.org
export IPA_SERVER_IP=192.168.56.141
export IPA_SERVER_NTP=ntp1.net-courrier.extra.laposte.fr
sed -i -e "s#ExecStart=/sbin/rngd -f#ExecStart=/sbin/rngd -f -r /dev/urandom -o /dev/random#g" /usr/lib/systemd/system/rngd.service
systemctl daemon-reload
systemctl enable rngd
systemctl start rngd
ntpdate -su $IPA_SERVER_NTP

# ipa-server-install --admin-password=$IPA_SERVER_PASSWORD --ds-password=$IPA_SERVER_PASSWORD  --hostname=$IPA_SERVER_NAME.$IPA_SERVER_DOMAIN --ip-address=$IPA_SERVER_IP --domain=$IPA_SERVER_DOMAIN --realm=${IPA_SERVER_DOMAIN^^} --mkhomedir --setup-dns --forwarder=8.8.8.8 --forwarder=8.8.4.4 --auto-reverse --ssh-trust-dns --unattended
# ipa-server-install --admin-password=$IPA_SERVER_PASSWORD --ds-password=$IPA_SERVER_PASSWORD  --hostname=$IPA_SERVER_NAME.$IPA_SERVER_DOMAIN --ip-address=$IPA_SERVER_IP --domain=$IPA_SERVER_DOMAIN --realm=${IPA_SERVER_DOMAIN^^} --mkhomedir --setup-dns --forwarder=145.42.2.2 --forwarder=165.162.68.19 --auto-reverse --ssh-trust-dns --unattended
ipa-replica-install --principal admin --admin-password $IPA_SERVER_PASSWORD --server $IPA_SERVER_NAME.$IPA_SERVER_DOMAIN --domain=$IPA_SERVER_DOMAIN --setup-ca
