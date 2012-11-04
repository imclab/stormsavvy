#!/bin/bash

# Bash ci script.

cd ~/src/stormsavvy/script/heroku

git push git@heroku.com:stormsavvy3.git master
# heroku restart --app stormsavvy3 
heroku logs --app stormsavvy3

.~/src/stormsavvy/script/heroku/deploy_ci.sh
sleep 300
