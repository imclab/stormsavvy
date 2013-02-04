#!/bin/bash

heroku pgbackups:capture --expire -a stormsavvy
heroku pgbackups -a stormsavvy
