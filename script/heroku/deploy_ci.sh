#!/bin/bash

# Bash ci script.

git push git@heroku.com:ssci.git master
heroku restart --app ssci
heroku logs --app ssci

# cd ~/src/stormsavvy/script/heroku
# ./ci.sh
# sleep 300
