https://github.com/tumf/vagrant-ansible_local-centos7-sample

https://www.vagrantup.com/docs/provisioning/ansible_local.html

https://github.com/ansible/ansible/issues/14141

Bloque la version à http://mirror.centos.org/centos/7.3.1611/os/x86_64/Packages/ 
donc --releasever=7.3.1611
faire 
[vagrant@node2 ~]$ sudo yum install yum-plugin-versionlock
[vagrant@node2 ~]$ sudo yum versionlock ipa-server-*
Loaded plugins: fastestmirror, versionlock
Adding versionlock on: 0:ipa-server-dns-4.5.0-21.el7.centos.1.2
Adding versionlock on: 0:ipa-server-4.5.0-21.el7.centos.1.2
Adding versionlock on: 0:ipa-server-common-4.5.0-21.el7.centos.1.2
versionlock added: 3

Il faut bloquer à la version ipa-server-4.4.0-12.el7.centos.x86_64.rpm
Prendre la version v1611.01 sur https://app.vagrantup.com/centos/boxes/7/versions/1611.01

