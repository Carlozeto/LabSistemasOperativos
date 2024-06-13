# INSTALACION DE SERVICIO DNS Y NGINX

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
   address 192.168.1.20
   netmask 255.255.255.0
```
Luego de esto reiniciamos los servicios de red con
```shell
sudo systemctl restart networking.service
```

## Configuracion servicios DNS
Actualizamos paquetes e instalamos el de BIND9

```shell
sudo apt update
sudo apt install bind9 bind9utils bind9-doc
```

Configurar la zona del dominio

```shell
sudo nano /etc/bind/named.conf.local
```

Agregar esto:

```shell
zone "naugthydog.com" {
    type master;
    file "/etc/bind/zones/db.naugthydog.com";
};
```

Crear el archivo de zona:

```shell
sudo mkdir -p /etc/bind/zones
sudo nano /etc/bind/zones/db.naugthydog.com
```

Agregar el siguiente contenido al archivo de zona:

```shell
$TTL    604800
@       IN      SOA     ns1.naugthydog.com. admin.naugthydog.com. (
                      2024061001         ; Serial
                      604800             ; Refresh
                      86400              ; Retry
                      2419200            ; Expire
                      604800 )           ; Negative Cache TTL
;
@       IN      NS      ns1.naugthydog.com.
@       IN      A       192.168.1.20
www     IN      A       192.168.1.20
ns1     IN      A       192.168.1.20

```

Reiniciamos el servicio

```shell
sudo systemctl restart bind9
```

Verificamos que este respondiendo correctamente:

```shell
dig @localhost www.naugthydog.com
```

## Configuracion NGINX (Servicios Web)

Actualizamos paquetes y instalamos el de NGINX

```shell
sudo apt update
sudo apt install nginx
```

Creamos un archivo de configuracion para el dominio naugthydog.com

```shell
sudo nano /etc/nginx/sites-available/naugthydog.com
```

Añadimos la siguiente configuracion y guardamos cambios:

```shell
server {
    listen 80;
    server_name naugthydog.com www.naugthydog.com;

    root /var/www/naugthydog.com;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Creamos un directorio raiz y un index de ejemplo:

```shell
sudo mkdir -p /var/www/naugthydog.com
sudo nano /var/www/naugthydog.com/index.html
```

Adimos un html basico:

<!DOCTYPE html>

```shell
<!DOCTYPE html>
<html>
<head>
    <title>Bienvenido a naugthydog.com</title>
</head>
<body>
    <h1>Hola, mundo!</h1>
    <p>Este es un ejemplo de HTML para naugthydog.com.</p>
</body>
</html>

```

Habilitamos la configuracion y reiniciamos:

```shell
sudo ln -s /etc/nginx/sites-available/naugthydog.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```
