#!/bin/bash

# Bash script for backing up pg database on heroku.

heroku pgbackups:capture HEROKU_POSTGRESQL_NAVY -a stormsavvy
heroku pgbackups:capture --expire -a stormsavvy
