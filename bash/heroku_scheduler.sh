#!/bin/bash

heroku run rake scheduler:dailynotice -a stormsavvy
heroku run rake scheduler:stormpopnotice -a stormsavvy
heroku run rake scheduler:noaaalert -a stormsavvy
