#!/bin/bash
bundle exec rake db:migrate
bundle exec rake db:test:load
bundle exec rake db:seed
