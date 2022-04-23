Travail à réaliser

## 1 « tcpdump ».
Vous incorporerez dans votre rapport une capture commentée de trafic VLAN entre un hôte et un routeur
(qui sont les interlocuteurs, où le trafic est-il sniffé, à qui appartient les adresses MAC, quelle est la nature
du trafic, son sens d’échange et le protocole observé)

### sniffé dans le hôte poste 3

15:53:09.014809 86:14:02:09:35:ca > 9a:25:0e:39:c1:e1, ethertype 802.1Q (0x8100), length 102: vlan 100, p 0, ethertype IPv4, (tos 0x0, ttl 64, id 55012, offset 0, flags [DF], proto ICMP (1), length 84)
    192.168.100.145 > 10.87.0.1: ICMP echo request, id 10228, seq 52, length 64
	0x0000:  4500 0054 d6e4 4000 4001 3433 c0a8 6491
	0x0010:  0a57 0001 0800 6864 27f4 0034 c504 6462
	0x0020:  0000 0000 7f39 0000 0000 0000 1011 1213
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233
	0x0050:  3435 3637
15:53:09.014961 9a:25:0e:39:c1:e1 > 86:14:02:09:35:ca, ethertype 802.1Q (0x8100), length 102: vlan 100, p 0, ethertype IPv4, (tos 0x0, ttl 63, id 34598, offset 0, flags [none], proto ICMP (1), length 84)
    10.87.0.1 > 192.168.100.145: ICMP echo reply, id 10228, seq 52, length 64
	0x0000:  4500 0054 8726 0000 3f01 c4f1 0a57 0001
	0x0010:  c0a8 6491 0000 7064 27f4 0034 c504 6462
	0x0020:  0000 0000 7f39 0000 0000 0000 1011 1213
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233
	0x0050:  3435 3637


### sniffé dans rout1

15:53:09.014875 b6:a7:0d:82:ed:ec > 5e:66:a9:74:dd:f7, ethertype IPv4 (0x0800), length 98: (tos 0x0, ttl 63, id 55012, offset 0, flags [DF], proto ICMP (1), length 84)
    192.168.100.145 > 10.87.0.1: ICMP echo request, id 10228, seq 52, length 64
	0x0000:  4500 0054 d6e4 4000 3f01 3533 c0a8 6491
	0x0010:  0a57 0001 0800 6864 27f4 0034 c504 6462
	0x0020:  0000 0000 7f39 0000 0000 0000 1011 1213
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233
	0x0050:  3435 3637
15:53:09.014940 5e:66:a9:74:dd:f7 > b6:a7:0d:82:ed:ec, ethertype IPv4 (0x0800), length 98: (tos 0x0, ttl 64, id 34598, offset 0, flags [none], proto ICMP (1), length 84)
    10.87.0.1 > 192.168.100.145: ICMP echo reply, id 10228, seq 52, length 64
	0x0000:  4500 0054 8726 0000 4001 c3f1 0a57 0001
	0x0010:  c0a8 6491 0000 7064 27f4 0034 c504 6462
	0x0020:  0000 0000 7f39 0000 0000 0000 1011 1213
	0x0030:  1415 1617 1819 1a1b 1c1d 1e1f 2021 2223
	0x0040:  2425 2627 2829 2a2b 2c2d 2e2f 3031 3233
	0x0050:  3435 3637

## 3 – Vous établirez le tunnel L2TPv3 en mode encapsulation IP entre Routeur1 et Routeur2.
Vous vérifierez que :

### a. le protocole ARP fonctionne normalement pour la découverte des machines quelle que soit leur côté de connexion par rapport à Internet ;

### b. le service DHCP que vous n’exécuterez que sur « Routeur1 » peut être utilisé par Poste1 ;

### c. une connexion TCP à l’aide de socat entre Routeur1 et Poste1 est possible à travers le tunnel.

Pour chaque vérification vous ajouterez dans votre rapport des captures de trafic et de configuration d’in-
terfaces permettant de justifier du bon fonctionnement de ces observations
