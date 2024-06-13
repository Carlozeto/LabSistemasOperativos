# Instalacion y configuracion servidor DHCP (serverGilgamesh)
## Configuracion inicial servidor
Inicialmente configuramos la IP del servidor para que sea estatica y pueda tener conexion con el servidor DNS:

```shell
sudo nano /etc/network/interfaces
```

Este archivo queda de la siguiente manera:
```shell
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
Luego de esto reiniciamos los servicios de red con
```shell
sudo systemctl restart networking.service
```

## Configuracion servicios DHCP
Inicialmente instalamos los servicios de DHCP con:
```shell
sudo apt update
sudo apt-get install isc-dhcp-server
```
Tras instalarlo tendremos un nuevo directorio donde podremos configurar el servicio DHCP, redes, subredes y dominios.
Para acceder a el y configurarlo ejecutamos el comando:
```shell
sudo nano /etc/dhcp/dhcpd.conf
```
Una vez adentro tendremos una configuracion inicial la cual comentaremos o la eliminaremos, para posteriormente agregar nuestra configuracion, para esto agregamos lo siguiente a nuestro archivo:
```shell
option domain-name "dominio.local"

option domain-name-servers ns1.dominio.local, ns2.dominio.local;

default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 192.168.1.0 netmask 255.255.255.0{   #IP y subnet de la red
 range 192.168.1.40 192.168.1.60;           #Rango de red (IPs a asignar)
 option domain-name-servers 192.168.1.20;   #Direccion IP servidor DNS configurado
 option routers 192.168.1.1;                #Direccion router
 option broadcast-address 192.168.1.255     #Direccion de broadcast
```
Esta configuracion especificada sera la que se comparte a las maquinas a las cuales el servidor DHCP les asigne su IP

Finalmente, reiniciamos el servidor con 
```shell
sudo systemctl restart isc-dhcp-server
```

En caso de errores podemos revisar el registro de ejecucion del servicio con los siguientes comandos 
```shell
sudo systemctl isc-dhcp-server
```
o para mas detalles
```shell
sudo journalctl -xeu networking.service
```

