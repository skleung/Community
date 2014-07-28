#!/bin/bash
echo "git push"
git push
echo "rake db:drop"
rake db:drop
echo "rake db:create"
rake db:create
echo "rake db:migrate"
rake db:migrate
echo "rake db:seed"
rake db:seed
echo "git push heroku master"
git push heroku master
echo "heroku pg:reset DATABASE --confirm community-food"
heroku pg:reset DATABASE --confirm community-app
echo "heroku run rake db:migrate"
heroku run rake db:migrate
echo "heroku run rake db:seed"
heroku run rake db:seed
