# MO Plugin Repository

[![Build Status](https://semaphoreci.com/api/v1/felovilches/mo-plugin-repository/branches/master/badge.svg)](https://semaphoreci.com/felovilches/mo-plugin-repository)

Construido con `Ruby 2.4.0p0` y `Rails 5.1.3`

## Despliegue en Heroku

https://mo-plugin-repository.herokuapp.com/

Reiniciar la base de datos con

```bash
heroku pg:reset database --confirm mo-plugin-repository
heroku run rake db:migrate
heroku run rake db:seed
```
