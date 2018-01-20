# MO Plugin Repository

Construido con `Ruby 2.4.0p0` y `Rails 5.1.3`


## Despliegue en Docker

Utilizando el Dockerfile contenido en el proyecto se puede desplegar la aplicación en uno o varios servidores de aplicación. Al desplegarlo, se debe indicar la dirección y credenciales de la base de datos, dado que el container solo contiene la aplicación independiente, y no bases de datos.

Primero se debe clonar el proyecto y ejecutar los comandos en la raíz.

Se debe modificar las variables que aparecen al inicio.

```bash

user=dockeruser # Nombre de usuario
password=dockerpass # Clave del usuario
hostname=123.456.78.100
port=5432
databasename=dockerdb

url="postgres://${user}:${password}@${hostname}:${port}/${databasename}"
docker build -t morails .

# Ejecutar solo para inicializar la base de datos. No ejecutar dos veces
docker run -e DATABASE_URL=$url morails bundle exec rake db:migrate
docker run -e DATABASE_URL=$url morails bundle exec rake db:seed

# Comenzar la aplicación
docker run -e DATABASE_URL=$url -p 3000:3000 -d morails
```


En caso que el puerto `3000` esté ocupado en la máquina real, se puede mapear distinto usando por ejemplo `1234:3000`, en tal caso la aplicación queda ocupando el puerto 3000 dentro del container, pero 1234 en la máquina real.
