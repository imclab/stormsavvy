#!/bin/bash

git push git@heroku.com:stormsavvy3.git master
heroku restart -a stormsavy3
heroku logs -a stormsavvy3
heroku open -a stormsavy3
