#!/bin/bash

# Bash ci script.

cd ~/src/stormsavvy/script/heroku

git push git@heroku.com:ssci.git master
heroku restart --app ssci
heroku logs --app ssci
./deploy_ci.sh

sleep 300
