# Projet-Infrastructure-Reseau

IPsec-secured L2TPv3 tunnel for implementing VLAN trunking
Comparison with VXLANs

## Dig in

The project aims to study the L2TPv3 protocol, RFC 3931, to make level 2 tunnels.
We will use it to do “trunking” of VLANs and service pooling such as DHCP.
Finally, using an “intelligent” configuration, we will limit the use of the tunnel when the hosts want to
will be able to connect to the internet by allowing them to do so directly from their “side of the internet”



We have the following network where the networks are disjoint at level 2:

![image](https://user-images.githubusercontent.com/75567246/180564779-8a8482ef-4646-45db-9474-63193b5821c8.png)


We would like to arrive at the following diagram where the networks are linked at level 2:


![image](https://user-images.githubusercontent.com/75567246/180564934-2857c1c5-271c-47da-9a4c-14b397aa0e4f.png)





A DHCP server will be implemented on “Router1” in order to configure the different hosts of the two
VLANs (whether or not separated by Internet)


Each Poste and router will be implemented using a “network namespace”.







## contributors :

* [Yawavi Jeona-Lucie LATEVI](https://github.com/jeo284)
* [Claudio Antonio](https://github.com/MonaQuimbamba)
