# Configuracion servidor SFTP (serverManchester)

## Configuracion inicial
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
   address 192.168.1.30
   netmask 255.255.255.0
   dns-nameserver 192.168.1.20                    #IP serverMadrid a configurar
   dns-search naugthydog.com ns1.naugthydog.com    #Direccion servidor web configurado
```
Luego de esto reiniciamos los servicios de red con
```shell
sudo systemctl restart networking.service
```

## Configuracion SFTP

Actualizamos paquetes e instalamos el SFTP:

```shell
sudo apt update
sudo apt install vsftpd
```

Configuramos el VSFTP:

```shell
sudo nano /etc/vsftpd.conf
```

Se debe verificar que esta lineas existan tal cual, en caso que este comentadas descomentarlas y dejarlas tal cual:

```shell
# Descomenta o añade estas líneas
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
allow_writeable_chroot=YES
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH

```

Reiniciamos el servicio:

```shell
service vsftp restart
```

Creamos el usuario para el login en especifico del SFTP:

```shell
adduser zeto
```

Cambiamos el directorio de inicio:

```shell
usermod -d /mnt/zeto zeto
```

Creamos el directorio y le cambiamos el propietario:

```shell
mkdir -p /mnt/zeto
chown zeto:zeto /mnt/zeto

```
