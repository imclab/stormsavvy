#!/bin/bash

# ci.sh

# bash ci script.

git add .
git commit -m 'heroku deploy with bash script'
git push git@heroku.com:ssci.git master
heroku run rake db:migrate --app ssci
heroku logs --app ssci

./script/ci.sh
sleep 300
