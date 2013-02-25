#!/bin/bash

# heroku run rake scheduler:dailynotice -a stormsavvy
heroku run rake scheduler:northbay_forecast -a stormsavvy
heroku run rake scheduler:southbay_forecast -a stormsavvy
heroku run rake scheduler:eastbay_forecast -a stormsavvy
# heroku run rake scheduler:stormpopnotice -a stormsavvy
# heroku run rake scheduler:noaaalert -a stormsavvy
