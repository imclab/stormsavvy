#!/bin/bash

# Bash script to clean and recompile assets

rake assets:clean
rake assets:precompile

RAILS_ENV=development bundle exec rake assets:clean
RAILS_ENV=development bundle exec rake assets:precompile

RAILS_ENV=production bundle exec rake assets:clean
RAILS_ENV=production bundle exec rake assets:precompile