#!/bin/bash

# Bash staging deployment script.

git push git@heroku.com:stormsavvy.git master
heroku logs --app stormsavvy
