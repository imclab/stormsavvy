#!/bin/bash

# ci.sh

# Bash CI script.

git add .
git commit -m 'nothing to see here, just the ci script running...'
git push git@heroku.com:ssci.git master
heroku run rake db:migrate --app ssci
heroku logs --app ssci

cd ~/src/stormsavvy/script
./ci.sh
sleep 300
