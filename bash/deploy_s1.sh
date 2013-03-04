#!/bin/bash

git push git@heroku.com:stormsavvy.git master
heroku restart worker.1 -a stormsavvy
heroku restart -a stormsavvy
heroku logs -a stormsavvy
heroku open -a stormsavvy
