#!/bin/bash

# Bash script for Heroku postgres backups
heroku pgbackups:capture --expire -a stormsavvy
heroku pgbackups -a stormsavvy
heroku pg:info -a stormsavvy
# curl -o latest.dump `heroku pgbackups:url --app stormsavvy`
