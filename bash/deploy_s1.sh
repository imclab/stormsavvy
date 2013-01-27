#!/bin/bash

git push git@heroku.com:stormsavvy.git master
heroku restart -a stormsavvy
heroku logs -a stormsavvy
heroku open -a stormsavvy
