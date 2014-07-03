#!/bin/bash
echo "git push heroku master"
git push heroku master
echo "heroku pg:reset DATABASE --confirm community-food"
heroku pg:reset DATABASE --confirm community-food
echo "heroku run rake db:migrate"
heroku run rake db:migrate
echo "heroku run rake db:seed"
heroku run rake db:seed