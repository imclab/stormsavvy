#!/bin/bash

# Bash script for running rake tasks.

rake log:clear
rake cache:clear
rake db:sessions:clear

rake tmp:clear
rake tmp:pids:clear
rake tmp:sockets:clear
rake tmp:sessions:clear

rake db:migrate

rake db:test:prepare
rake db:fixtures:load

rake test:functionals
rake test:integration
rake test:plugins
rake test:units

rake stats
