#!/bin/bash

#création des netns
ip netns add routA
ip netns add routB
ip netns add rout1
ip netns add rout2
ip netns add poste1
ip netns add poste2
ip netns add poste3
ip netns add poste4
ip netns add internet1 

#créer les switchs
ovs-vsctl add-br resB
ovs-vsctl add-br resC
ovs-vsctl add-br resD
ovs-vsctl add-br resE
ovs-vsctl add-br internet1

#configuration du routeur A
ip link add routA-eth0 type veth peer name resC-routA
ip link add routA-eth1 type veth peer name internet1-routA
ip link set routA-eth0 netns routA
ip link set routA-eth1 netns routA
ovs-vsctl add-port resC resC-routA
ovs-vsctl add-port internet1 internet1-routA
ip link set dev resC-routA up
ip link set dev internet1-routA
ip netns exec routA ip link set dev lo up
ip netns exec routA ip link set dev routA-eth0 up
ip netns exec routA ip link set dev routA-eth1 up
ip netns exec routA ip a add dev routA-eth0 172.16.1.254/24
ip netns exec routA ip a add dev routA-eth1 10.87.0.1/24
ip netns exec routA sysctl net.ipv4.conf.all.forwarding=1

#configuration du routeur B
ip link add routB-eth0 type veth peer name resB-routB
ip link add routB-eth1 type veth peer name internet1-routB
ip link set routB-eth0 netns routB
ip link set routB-eth1 netns routB
ovs-vsctl add-port resB resB-routB
ovs-vsctl add-port internet1 internet1-routB
ip link set dev resB-routB up
ip link set dev internet1-routB up
ip netns exec routB ip link set dev lo up
ip netns exec routB ip link set dev routB-eth0 up
ip netns exec routB ip link set dev routB-eth1 up
ip netns exec routB ip a add dev routB-eth0 172.16.1.254/24
ip netns exec routB ip a add dev routB-eth1 10.87.0.2/24
ip netns exec routB sysctl net.ipv4.conf.all.forwarding=1

#configuration du routeur 1
ip link add rout1-eth0 type veth peer name resC-rout1
ip link add rout1-eth1 type veth peer name resD-rout1
ip link set rout1-eth0 netns rout1
ip link set rout1-eth1 netns rout1
ovs-vsctl add-port resC resC-rout1
ovs-vsctl add-port resD resD-rout1
ip link set dev resC-rout1 up
ip link set dev resD-rout1 up
ip netns exec rout1 ip link set dev lo up
ip netns exec rout1 ip link set dev rout1-eth0 up
ip netns exec rout1 ip link set dev rout1-eth1 up
ip netns exec rout1 ip a add dev rout1-eth0 172.16.1.253/24
ip netns exec rout1 sysctl net.ipv4.conf.all.forwarding=1

#configuration du routeur 2
ip link add rout2-eth0 type veth peer name resB-rout2
ip link add rout2-eth1 type veth peer name resE-rout2
ip link set rout2-eth0 netns rout2
ip link set rout2-eth1 netns rout2
ovs-vsctl add-port resB resB-rout2
ovs-vsctl add-port resE resE-rout2
ip link set dev resB-rout2 up
ip link set dev resE-rout2 up
ip netns exec rout2 ip link set dev lo up
ip netns exec rout2 ip link set dev rout2-eth0 up
ip netns exec rout2 ip link set dev rout2-eth1 up
ip netns exec rout2 ip a add dev rout2-eth0 172.16.1.253/24
ip netns exec rout2 sysctl net.ipv4.conf.all.forwarding=1

#configuration du poste 1
ip link add poste1-eth0 type veth peer name resE-poste1
ip link set poste1-eth0 netns poste1
ovs-vsctl add-port resE resE-poste1
ip link set dev resE-poste1 up
ip netns exec poste1 ip link set dev lo up
ip netns exec poste1 ip link set dev poste1-eth0 up
#ip netns exec poste1 ip r add default via 10.10.10.254

#configuration du poste 2
ip link add poste2-eth0 type veth peer name resE-poste2
ip link set poste2-eth0 netns poste2
ovs-vsctl add-port resE resE-poste2
ip link set dev resE-poste2 up
ip netns exec poste2 ip link set dev lo up
ip netns exec poste2 ip link set dev poste2-eth0 up
#ip netns exec poste1 ip r add default via 10.10.10.254

#configuration du poste 3
ip link add poste3-eth0 type veth peer name resD-poste3
ip link set poste3-eth0 netns poste3
ovs-vsctl add-port resD resD-poste3
ip link set dev resD-poste3 up
ip netns exec poste3 ip link set dev lo up
ip netns exec poste3 ip link set dev poste3-eth0 up
#ip netns exec poste1 ip r add default via 10.10.10.254

#configuration du poste 4
ip link add poste4-eth0 type veth peer name resD-poste4
ip link set poste4-eth0 netns poste4
ovs-vsctl add-port resD resD-poste4
ip link set dev resD-poste4 up
ip netns exec poste4 ip link set dev lo up
ip netns exec poste4 ip link set dev poste4-eth0 up
#ip netns exec poste1 ip r add default via 10.10.10.254

#Mise en place des Vlans

ip netns exec rout1 ip link add link rout1-eth1 name rout1-eth1.100 type vlan id 100
ip netns exec rout1 ip link set dev rout1-eth1.100 up
ip netns exec rout1 ip link add link rout1-eth1 name rout1-eth1.200 type vlan id 200
ip netns exec rout1 ip link set dev rout1-eth1.200 up
ip netns exec rout1 ip a add dev rout1-eth1.100 192.168.100.254/24 brd 192.168.100.255
ip netns exec rout1 ip a add dev rout1-eth1.200 192.168.200.254/24 brd 192.168.200.255

ip netns exec rout2 ip link add link rout2-eth1 name rout2-eth1.100 type vlan id 100
ip netns exec rout2 ip link set dev rout2-eth1.100 up
ip netns exec rout2 ip link add link rout2-eth1 name rout2-eth1.200 type vlan id 200
ip netns exec rout2 ip link set dev rout2-eth1.200 up
ip netns exec rout2 ip a add dev rout2-eth1.100 192.168.100.253/24 brd 192.168.100.255
ip netns exec rout2 ip a add dev rout2-eth1.200 192.168.200.253/24 brd 192.168.200.255

ip netns exec poste1 ip link add link poste1-eth0 name poste1-eth0.100 type vlan id 100
ip netns exec poste1 ip link set poste1-eth0.100 up
ip netns exec poste1 ip a add dev poste1-eth0.100 192.168.100.1/24 brd 192.168.100.255

ip netns exec poste2 ip link add link poste2-eth0 name poste2-eth0.200 type vlan id 200
ip netns exec poste2 ip link set poste2-eth0.200 up
ip netns exec poste2 ip a add dev poste2-eth0.200 192.168.200.1/24 brd 192.168.200.255

ip netns exec poste3 ip link add link poste3-eth0 name poste3-eth0.100 type vlan id 100
ip netns exec poste3 ip link set poste3-eth0.100 up
ip netns exec poste3 ip a add dev poste3-eth0.100 192.168.100.2/24 brd 192.168.100.255

ip netns exec poste4 ip link add link poste4-eth0 name poste4-eth0.200 type vlan id 200
ip netns exec poste4 ip link set poste4-eth0.200 up
ip netns exec poste4 ip a add dev poste4-eth0.200 192.168.200.2/24 brd 192.168.200.255

#route par défaut
ip netns exec poste1 ip r add default via 192.168.100.253
ip netns exec poste2 ip r add default via 192.168.200.253
ip netns exec poste3 ip r add default via 192.168.100.254
ip netns exec poste4 ip r add default via 192.168.200.254

#Mise en place du tunnel L2TPv3
#nstaller le paquet «bridge-utils»
#rout1
#creation du tunel: l'interface IF2 ici l2tpeth0
#de 172.16.1.253 -> 172.16.2.253
ip netns exec rout1 ip l2tp add tunnel remote 172.16.2.253 local 172.16.1.253 encap ip tunnel_id 3000 peer_tunnel_id 4000
ip netns exec rout1 ip l2tp add session tunnel_id 3000 session_id 1000 peer_session_id 2000
#activation de l2tpeth0
ip netns exec rout1 ip link set l2tpeth0 up
#ajout du bridge "tunel"
ip netns exec rout1 brctl addbr tunnel
#ajout dans de l'interface du tunel (l2tpeth0) le bridge sans configuration
ip netns exec rout1 brctl addif tunnel l2tpeth0
#ajout dans de l'interface connecté au réseau (rout1-eth1) le bridge sans configuration
ip netns exec rout1 brctl addif tunnel rout1-eth1
#activation de l'interface correspondant au bridge
ip netns exec rout1 ip link set tunnel up
#configuration de l’étiquettage VLAN pour le VLAN 100
ip netns exec rout1 ip netns exec rout1 ip link add link tunnel name tunnel.100 type vlan id 100
#activation
ip netns exec rout1 ip link set tunnel.100 up
#configuration de l’étiquettage VLAN pour le VLAN 200
ip netns exec rout1 ip netns exec rout1 ip link add link tunnel name tunnel.200 type vlan id 200
#activation
ip netns exec rout1 ip link set tunnel.200 up
#configuration IP de l’interface
ip netns exec rout1 ip addr add 192.168.100.254/24 dev tunnel.100
ip netns exec rout1 ip addr add 192.168.200.254/24 dev tunnel.200

#rout2
#creation du tunel: l'interface IF2 ici l2tpeth0
#de 172.16.2.253 -> 172.16.1.253
ip netns exec rout2 ip l2tp add tunnel local 172.16.2.253 remote 172.16.1.253 encap ip tunnel_id 3000 peer_tunnel_id 4000
ip netns exec rout2 ip l2tp add session tunnel_id 3000 session_id 1000 peer_session_id 2000
#activation de l2tpeth0
ip netns exec rout2 ip link set l2tpeth0 up
#ajout du bridge "tunel"
ip netns exec rout2 brctl addbr tunnel
#ajout dans de l'interface du tunel (l2tpeth0) le bridge sans configuration
ip netns exec rout2 brctl addif tunnel l2tpeth0
#ajout dans de l'interface connecté au réseau (rout2-eth1) le bridge sans configuration
ip netns exec rout2 brctl addif tunnel rout2-eth1
#activation de l'interface correspondant au bridge
ip netns exec rout2 ip link set tunnel up
#configuration de l’étiquettage VLAN pour le VLAN 100
ip netns exec rout2 ip netns exec rout2 ip link add link tunnel name tunnel.100 type vlan id 100
#activation
ip netns exec rout2 ip link set tunnel.100 up
#configuration de l’étiquettage VLAN pour le VLAN 200
ip netns exec rout2 ip netns exec rout2 ip link add link tunnel name tunnel.200 type vlan id 200
#activation
ip netns exec rout2 ip link set tunnel.200 up
#configuration IP de l’interface
ip netns exec rout2 ip addr add 192.168.100.253/24 dev tunnel.100
ip netns exec rout2 ip addr add 192.168.200.253/24 dev tunnel.200