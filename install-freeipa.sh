#!/usr/bin/bash
set -x
# export IPA_SERVER_PASSWORD=Welcome1
# export IPA_SERVER_NAME=node1
# export IPA_SERVER_DOMAIN=jobjects.net
# export IPA_SERVER_IP=192.168.56.141
# export IPA_SERVER_NTP=0.fr.pool.ntp.org

ntpdate -su $IPA_SERVER_NTP

ipa-server-install --admin-password=$IPA_SERVER_PASSWORD --ds-password=$IPA_SERVER_PASSWORD  --hostname=$IPA_SERVER_NAME.$IPA_SERVER_DOMAIN --ip-address=$IPA_SERVER_IP --domain=$IPA_SERVER_DOMAIN --realm=${IPA_SERVER_DOMAIN^^} --mkhomedir --setup-dns --forwarder=8.8.8.8 --forwarder=8.8.4.4 --auto-reverse --ssh-trust-dns --unattended
firewall-cmd --add-service={freeipa-ldap,freeipa-ldaps,dns,ntp} --permanent
firewall-cmd --reload

# Connection Admin
printf $IPA_SERVER_PASSWORD | kinit admin

# Ajout des entrées dans le DNS
for number in {1..3}
do
ipa dnsrecord-add 56.168.192.in-addr.arpa. 14$number --ptr-rec=node$number.jobjects.net.
done

# Commencer par ajouter les groupes de wildfly dans FreeIPA
ipa group-add 'wfmonitor' --desc="Wildfly : Users of the Monitor role have the fewest permissions and can only read the current configuration and state of the server. This role is intended for users who need to track and report on the performance of the server. Monitors cannot modify server configuration, nor can they access sensitive data or operations."
ipa group-add 'wfoperator' --desc="Wildfly : The Operator role extends the Monitor role by adding the ability to modify the runtime state of the server. This means that Operators can reload and shutdown the server as well as pause and resume JMS destinations. The Operator role is ideal for users who are responsible for the physical or virtual hosts of the application server so they can ensure that servers can be shutdown and restarted correctly when need be. Operators cannot modify server configuration or access sensitive data or operations."
ipa group-add 'wfmaintainer' --desc="Wildfly : The Maintainer role has access to view and modify the runtime state and all configurations except sensitive data and operations. The Maintainer role is the general purpose role that does not have access to sensitive data and operation. The Maintainer role allows users to be granted almost complete access to administer the server without giving those users access to passwords and other sensitive information. Maintainers cannot access sensitive data or operations."
ipa group-add 'wfdeployer' --desc="Wildfly : The Deployer role has the same permissions as the Monitor, but it can modify the configuration and state for deployments and any other resource type enabled as an application resource."
ipa group-add 'wfsuperuser' --desc="Wildfly : The SuperUser role does not have any restrictions, and it has complete access to all resources and operations of the server, including the audit logging system. If RBAC is disabled, all management users have permissions equivalent to the SuperUser role."
ipa group-add 'wfadministrator' --desc="Wildfly : The Administrator role has unrestricted access to all resources and operations on the server except the audit logging system. The Administrator role has access to sensitive data and operations. This role can also configure the access control system. The Administrator role is only required when handling sensitive data or configuring users and roles. Administrators cannot access the audit logging system and cannot change themselves to the Auditor or SuperUser role."
ipa group-add 'wfauditor' --desc="Wildfly : The Auditor role has all the permissions of the Monitor role and can also view (but not modify) sensitive data. It has full access to the audit logging system. The Auditor role is the only role besides SuperUser that can access the audit logging system. Auditors cannot modify sensitive data or resources. Only read access is permitted."

# Puis ajouter l'utilisateur wildfly
ipa user-add wildfly --first="Wildfly" --last="JBoss" --random > ~/user-wildfly.txt && cat ~/user-wildfly.txt

# Puis ajouter l'utilisateur wildfly au groupe SuperUser
ipa group-add-member --users=wildfly wfsuperuser

ipa group-add 'developpers' --desc="Groupe des developpeurs"

ipa user-add alice --first="Alice" --last="Savoie"  --email="alice@$IPA_SERVER_DOMAIN" --random > ~/user-alice.txt && cat ~/user-alice.txt
ipa user-add bob --first="Bob" --last="Marley"  --email="bob@$IPA_SERVER_DOMAIN" --random > ~/user-bob.txt && cat ~/user-bob.txt
ipa user-add carole --first="Carole" --last="Rousseau"  --email="carole@$IPA_SERVER_DOMAIN" --random > ~/user-carole.txt && cat ~/user-carole.txt
ipa user-add dave --first="Dave" --last="Levenbach"  --email="dave@$IPA_SERVER_DOMAIN" --random > ~/user-dave.txt && cat ~/user-dave.txt
ipa user-add eve --first="Eve" --last="Angeli"  --email="eve@$IPA_SERVER_DOMAIN" --random > ~/user-eve.txt && cat ~/user-eve.txt
ipa user-add franck --first="Frank" --last="Dubosc"  --email="franck@$IPA_SERVER_DOMAIN" --random > ~/user-franck.txt && cat ~/user-franck.txt

ipa group-add-member --users={alice,bob,carole,dave,eve,franck} developpers
