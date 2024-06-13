#Instalacion y configuracion servidor DHCP (serverGilgamesh)
## Configuracion inicial servidor
Inicialmente configuramos la IP del servidor para que sea estatica y pueda tener conexion con el servidor DNS:

```shell
sudo nano /etc/network/interfaces
```

Este archivo queda de la siguiente manera:
```shell
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet static
   address 192.168.1.10
   netmask 255.255.255.0
   network 192.160.1.0
   broadcast 192.168.1.255
   dns-nameserver 192.168.1.20                    #IP serverMadrid a configurar
   dns-search naugthydog.com ns1.naugthydog.com    #Direccion servidor web configurado
```
