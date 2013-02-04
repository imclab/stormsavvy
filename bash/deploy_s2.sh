#!/bin/bash

git push git@heroku.com:stormsavvy2.git master
heroku restart worker.1 -a stormsavvy2
heroku restart -a stormsavvy2
heroku logs -a stormsavvy2
heroku open -a stormsavvy2
