Voici le mode opératoire, ça fonctionne.
Editer les fichiers :
cp /usr/sbin/ipa-replica-conncheck /usr/sbin/ipa-replica-conncheck.init
cp /usr/lib/python2.7/site-packages/ipapython/ipautil.py /usr/lib/python2.7/site-packages/ipapython/ipautil.py.init
Suivre le diff pour modifier les fichiers en conséquence :
[root@freeipav1 ~]# diff /usr/sbin/ipa-replica-conncheck /usr/sbin/ipa-replica-conncheck.init
386c386
<                 socket_timeout=CONNECT_TIMEOUT, log_errors=True,check_all_ifaces=True)
---
>                 socket_timeout=CONNECT_TIMEOUT, log_errors=True)
[root@freeipav1 ~]# diff /usr/lib/python2.7/site-packages/ipapython/ipautil.py /usr/lib/python2.7/site-packages/ipapython/ipautil.py.init
951c951
<                    socket_timeout=None, log_errors=False,check_all_ifaces=False):
---
>                    socket_timeout=None, log_errors=False):
958,959c958
<     all_open = True
<     some_open = False
---
>     port_open = True
976d974
<             some_open = True
978c976
<             all_open = False
---
>             port_open = False
996c994
<     return all_open if check_all_ifaces else some_open
---
>     return port_open
Puis lancer l'update de freeipa
ipa-server-upgrade –v
…
successfull