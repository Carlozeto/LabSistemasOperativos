Actualizamos paquetes e instalamos el paquete de samba con:

```shell
sudo apt update
sudo apt install samba
```

Configuramos la carpeta que vamos a compartir, abrimos el archivo con:

```shell
sudo nano /etc/samba/smb.conf
```

Definimos el recurso que compartiremos:

```shell
[data]
   comment = Carpeta de archivos subidos  # Descripción de la sección
   path = /mnt/archivosSubidos            # Ruta local de la carpeta a compartir
   browseable = yes                        # La carpeta es visible para los usuarios al explorar la red
   read only = no                          # Los usuarios tienen permiso de escritura en la carpeta
   guest ok = yes                          # Se permite el acceso de invitados a la carpeta
   create mask = 0755                     # Permisos predeterminados para nuevos archivos

```

Reiniciamos el servicio y verificamos su estado con:

```shell
service smbd restart
service smbd status
```

Creamos usuarios de SMBD con:

```shell
smbpasswd -a nombreUsuario
```

Se debe instalar el client de samba

```shell
apt-get install smbclient
```

Asi se conecta:

```shell
smbclient //192.168.1.5/data -U yksogeidSMB
```

```shell
USUARIO: yksogeidSMB
CLAVE: yksogeid
```
