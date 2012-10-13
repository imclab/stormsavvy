#!/bin/bash

# ci.sh

# bash ci script.

git push git@heroku.com:ssci.git master
heroku logs --app ssci

./script/ci.sh
sleep 300
