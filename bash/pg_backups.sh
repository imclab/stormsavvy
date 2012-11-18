#!/bin/bash

# Bash script for Heroku postgres backups

cd ~/src/stormsavvy/script/heroku

heroku pgbackups:capture --app stormsavvy
heroku pgbackups:capture --expire --app stormsavvy
heroku pgbackups --app stormsavvy
heroku pg:info

# curl -o latest.dump `heroku pgbackups:url --app stormsavvy`
