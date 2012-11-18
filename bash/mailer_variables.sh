#!/bin/bash

# set_variable.sh
# Bash script for setting mailer variables in
# ActionMailer.

export SENDGRID_USERNAME=doolin
export SENDGRID_PASSWORD=wegabyte

heroku config:add SENDGRID_USERNAME=doolin --app stormsavvy
heroku config:add SENDGRID_PASSWORD=wegabyte --app stormsavvy

export STORMSAVVY_GMAIL_USERNAME=alerts@stormsavvy.com
export STORMSAVVY_GMAIL_PASSWORD=DarkAndStormy

heroku config:add STORMSAVVY_GMAIL_USERNAME=alerts@stormsavvy.com --app stormsavvy
heroku config:add STORMSAVVY_GMAIL_PASSWORD=DarkAndStormy --app stormsavvy