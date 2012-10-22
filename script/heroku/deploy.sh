#!/bin/bash

# deploy.sh

# Bash deployment script.

# Deploy to real staging
cd ~/src/stormsavvy
./script/heroku/ci.sh
./script/heroku/backup.sh
./script/heroku/staging.sh

git push git@heroku.com:stormsavvy2.git master
heroku run rake db:migrate --app stormsavvy2
heroku logs --app stormsavvy2

# Deploy to real production 
git push git@heroku.com:stormsavvy.git master
heroku run rake db:migrate --app stormsavvy
heroku logs --app stormsavvy
