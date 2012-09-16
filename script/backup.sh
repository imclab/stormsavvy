#!/bin/bash

# backup.sh

# Bash backup script:
# Temp Repos: ssbs2 = staging, ssbs = production
# Real Repos: stormsavvy2 = staging, stormavvy = production

# Destroy existing temp repos
# heroku destroy ssbs2 --confirm=ssbs2
# heroku destroy ssbs --confirm=ssbs

# Remove existing temp repos on local
# rm -rf ~/src/ssbs2
# rm -rf ~/src/ssbs

# Create new temp repos
# heroku create --app ssbs2 --stack cedar
# heroku create --app ssbs --stack cedar

# Deploy to new temp staging repo
cd ~/src/stormsavvy
git add .
git commit -m 'nothing to see here... bash script running'
git push git@heroku.com:ssbs2.git master
heroku run rake db:migrate --app ssbs2
heroku restart --app ssbs2
heroku logs --app ssbs2

# Deploy to new temp production repo
git add .
git commit -m 'nothing to see here... bash script running'
git push git@heroku.com:ssbs.git master
heroku run rake db:migrate --app ssbs
heroku restart  --app ssbs
heroku logs --app ssbs

# Back-up actual repos
# rm -rf ~/src/ss-staging
# rm -rf ~/src/ss-production

cd ~/src
git clone git@heroku.com:stormsavvy2.git ss-staging
git clone git@heroku.com:stormsavvy.git ss-production
