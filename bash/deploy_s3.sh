#!/bin/bash

git push git@heroku.com:stormsavvy3.git master
heroku restart worker.1 -a stormsavvy3
heroku restart -a stormsavvy3
heroku logs -a stormsavvy3
heroku open -a stormsavvy3
