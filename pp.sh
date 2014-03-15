#!/bin/bash
# git pull bitbucket master
# git pull github master

git pull --rebase bitbucket master
git pull --rebase stormsavvy_bitbucket master
git pull --rebase stormsavvy_github master

git push bitbucket master
git push --rebase stormsavvy_bitbucket master
git push --rebase stormsavvy_github master
