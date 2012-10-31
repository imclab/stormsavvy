#!/bin/bash

# Bash staging deployment script.

cd ~/src/stormsavvy
git push git@heroku.com:stormsavvy2.git master
heroku run rake db:migrate --app stormsavvy2
heroku logs --app stormsavvy2
