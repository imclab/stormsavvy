#!/bin/bash

# Bash script for master branch repo pull and push:
# 1. Assumes that all changes have been committed
# 2. Run only changes have been committed / merged

# Public github repo, do not push until config.yml hidden
# github=git@github.com:WalterYu/stormsavvy.git
# git pull github master
# git push github master

# bitbucket=git@bitbucket.org:doolin/stormsavvy.git
git pull bitbucket master
git push bitbucket master

git pull github master
git push github master
