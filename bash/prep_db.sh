#!/bin/bash

rake db:migrate
rake db:seed
rake db:test:prepare
bundle exec rspec spec
