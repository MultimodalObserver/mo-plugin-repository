# MO Plugin Repository

[![Build Status](https://semaphoreci.com/api/v1/felovilches/mo-plugin-repository/branches/master/badge.svg)](https://semaphoreci.com/felovilches/mo-plugin-repository)

Construido con `Ruby 2.4.0p0` y `Rails 5.1.3`


## Despliegue en Docker

Se debe modificar las variables que aparecen al inicio.

```bash

user=dockeruser # Nombre de usuario
password=dockerpass # Clave del usuario
hostname=123.456.78.100
port=5432
databasename=dockerdb

url="postgres://${user}:${password}@${hostname}:${port}/${databasename}"
docker build -t morails .
docker run -e DATABASE_URL=$url morails bundle exec rake db:migrate
docker run -e DATABASE_URL=$url morails bundle exec rake db:seed
docker run -e DATABASE_URL=$url -p 3000:3000 morails
```


## Despliegue en Heroku

https://mo-plugin-repository.herokuapp.com/

Reiniciar la base de datos con

```bash
heroku pg:reset database --confirm mo-plugin-repository
heroku run rake db:migrate
heroku run rake db:seed
```
