heroku pg:reset database --confirm mo-plugin-repository
heroku run rake database:reset_sequences
heroku run rake db:migrate
heroku run rake db:seed
heroku restart --app mo-plugin-repository

