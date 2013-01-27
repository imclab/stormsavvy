#!/bin/bash

git push git@heroku.com:stormsavvy4.git master
heroku restart -a stormsavvy4
heroku logs -a stormsavvy4
heroku open -a stormsavvy4
