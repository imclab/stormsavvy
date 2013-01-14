#/bin/bash

git add app/assets/pdfs/CEM2030_production.pdf
git commit -m 'editing fields in 2030'
git push bitbucket master
git push git@heroku.com:stormsavvy2.git master
