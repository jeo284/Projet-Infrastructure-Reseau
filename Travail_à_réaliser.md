Travail à réaliser

## 1 « tcpdump ».
Vous incorporerez dans votre rapport une capture commentée de trafic VLAN entre un hôte et un routeur
(qui sont les interlocuteurs, où le trafic est-il sniffé, à qui appartient les adresses MAC, quelle est la nature
du trafic, son sens d’échange et le protocole observé)

### sniffé dans le hôte poste 3

sudo tcpdump -nvveX -i poste3-eth0 not tcp
```
18:28:37.425339 fe:00:04:ab:34:43 > 96:f6:41:18:44:64, ethertype 802.1Q (0x8100), length 102: vlan 100, p 0, ethertype IPv4, (tos 0x0, ttl 64, id 13220, offset 0, flags [DF], proto ICMP (1), length 84)
    192.168.100.33 > 172.16.1.253: ICMP echo request, id 26591, seq 219, length 64
	0x0000:  4500 0054 33a4 4000 4001 342e c0a8 6421  E..T3.@.@.4...d!
	0x0010:  ac10 01fd 0800 cac6 67df 00db 35cc 6662  ........g...5.fb
	0x0020:  0000 0000 637d 0600 0000 0000 1011 1213  ....c}..........
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
	0x0050:  3435 3637                                4567
18:28:37.425382 96:f6:41:18:44:64 > fe:00:04:ab:34:43, ethertype 802.1Q (0x8100), length 102: vlan 100, p 0, ethertype IPv4, (tos 0x0, ttl 64, id 45275, offset 0, flags [none], proto ICMP (1), length 84)
    172.16.1.253 > 192.168.100.33: ICMP echo reply, id 26591, seq 219, length 64
	0x0000:  4500 0054 b0db 0000 4001 f6f6 ac10 01fd  E..T....@.......
	0x0010:  c0a8 6421 0000 d2c6 67df 00db 35cc 6662  ..d!....g...5.fb
	0x0020:  0000 0000 637d 0600 0000 0000 1011 1213  ....c}..........
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
	0x0050:  3435 3637                                4567
```
@ipv dst : 172.16.1.253 => celui du rout1
@ipv src :   192.168.100.33 => celui du poste3

### sniffé dans rout1

sudo tcpdump -nvveX -i rout1-eth1.100
```
18:26:28.401323 96:f6:41:18:44:64 > fe:00:04:ab:34:43, ethertype IPv4 (0x0800), length 98: (tos 0x0, ttl 64, id 28686, offset 0, flags [none], proto ICMP (1), length 84)
    172.16.1.253 > 192.168.100.33: ICMP echo reply, id 26591, seq 93, length 64
	0x0000:  4500 0054 700e 0000 4001 37c4 ac10 01fd  E..Tp...@.7.....
	0x0010:  c0a8 6421 0000 41a3 67df 005d b4cb 6662  ..d!..A.g..]..fb
	0x0020:  0000 0000 761f 0600 0000 0000 1011 1213  ....v...........
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
	0x0050:  3435 3637                                4567
18:26:29.425343 fe:00:04:ab:34:43 > 96:f6:41:18:44:64, ethertype IPv4 (0x0800), length 98: (tos 0x0, ttl 64, id 63588, offset 0, flags [DF], proto ICMP (1), length 84)
    192.168.100.33 > 172.16.1.253: ICMP echo request, id 26591, seq 94, length 64
	0x0000:  4500 0054 f864 4000 4001 6f6d c0a8 6421  E..T.d@.@.om..d!
	0x0010:  ac10 01fd 0800 4e44 67df 005e b5cb 6662  ......NDg..^..fb
	0x0020:  0000 0000 607d 0600 0000 0000 1011 1213  ....`}..........
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223  .............!"#
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233  $%&'()*+,-./0123
	0x0050:  3435 3637            

```

ou sur rout1
* ping -c 1 -I rout1-eth1.100 172.16.1.253
* sudo tcpdump -lnvv -i rout1-eth1.100

```
tcpdump: listening on rout1-eth1.100, link-type EN10MB (Ethernet), capture size 262144 bytes
20:11:39.325540 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 172.16.1.253 tell 192.168.100.254, length 28
20:11:40.344461 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 172.16.1.253 tell 192.168.100.254, length 28
20:11:41.368459 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 172.16.1.253 tell 192.168.100.254, length 28

```
* sudo tcpdump -nvveX -i rout1-eth1 not tcp

```
tcpdump: listening on rout1-eth1, link-type EN10MB (Ethernet), capture size 262144 bytes
^C20:11:39.325549 a2:a5:05:e6:db:6f > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 46: vlan 100, p 0, ethertype ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 172.16.1.253 tell 192.168.100.254, length 28
	0x0000:  0001 0800 0604 0001 a2a5 05e6 db6f c0a8  .............o..
	0x0010:  64fe 0000 0000 0000 ac10 01fd            d...........
20:11:40.344476 a2:a5:05:e6:db:6f > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 46: vlan 100, p 0, ethertype ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 172.16.1.253 tell 192.168.100.254, length 28
	0x0000:  0001 0800 0604 0001 a2a5 05e6 db6f c0a8  .............o..
	0x0010:  64fe 0000 0000 0000 ac10 01fd            d...........
20:11:41.368478 a2:a5:05:e6:db:6f > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 46: vlan 100, p 0, ethertype ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 172.16.1.253 tell 192.168.100.254, length 28
	0x0000:  0001 0800 0604 0001 a2a5 05e6 db6f c0a8  .............o..
	0x0010:  64fe 0000 0000 0000 ac10 01fd            d...........

3 packets captured
3 packets received by filter
0 packets dropped by kernel

```

## 2 - Vous rédigerez une description/présentation rapide du protocole L2TPv3 et de la technologie des VXLANs, « Virtual eXtensible Local Area Network », RFC 7348.
Vous compléterez cette présentation :
a. en comparant les deux solutions ;
b. en étudiant la mise en œuvre dans Linux des VXLANs dans Open vSwitch ;
c. en étudiant les solutions de chiffrement du trafic L2TPv3 ou VXLAN ;
d. en comparant avec MPLS ces deux technologies


## 3 – Vous établirez le tunnel L2TPv3 en mode encapsulation IP entre Routeur1 et Routeur2.
Vous vérifierez que :

### a. le protocole ARP fonctionne normalement pour la découverte des machines quelle que soit leur côté de connexion par rapport à Internet ;

### b. le service DHCP que vous n’exécuterez que sur « Routeur1 » peut être utilisé par Poste1 ;

### c. une connexion TCP à l’aide de socat entre Routeur1 et Poste1 est possible à travers le tunnel.

Pour chaque vérification vous ajouterez dans votre rapport des captures de trafic et de configuration d’in-
terfaces permettant de justifier du bon fonctionnement de ces observations
