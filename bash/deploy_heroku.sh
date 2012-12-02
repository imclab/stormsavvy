#!/bin/bash

git pull bitbucket master
./bash/deploy_s1.sh
sleep 30
./bash/deploys2.sh
