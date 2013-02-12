#!/bin/bash

# Bash script for Heroku postgres backups

# cd ~/src/stormsavvy/script/heroku

heroku pgbackups:capture --expire -a stormsavvy
heroku pgbackups:capture -a stormsavvy
heroku pgbackups -a stormsavvy
heroku pg:info -a stormsavvy

# curl -o latest.dump `heroku pgbackups:url --app stormsavvy`
