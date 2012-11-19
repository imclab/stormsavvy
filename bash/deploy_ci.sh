#!/bin/bash

# Bash ci script.

cd ~/src/stormsavvy/bash

git push git@heroku.com:stormsavvy3.git master
# heroku restart --app stormsavvy3 
heroku logs --app stormsavvy3

./deploy_ci.sh
sleep 300
