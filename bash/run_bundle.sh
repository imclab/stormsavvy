#!/bin/bash

DEBUG_RESOLVER=true bundle install
bundle install
# bundle update

git add Gemfile
git add Gemfile.lock
git commit -m 'run bundle install'

git push bitbucket master
git push github master
