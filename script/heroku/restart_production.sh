#!/bin/bash

# Bash script for rolling back and restarting production app.

heroku restart --app stormsavvy
heroku run rake db:migrate --app stormsavvy
