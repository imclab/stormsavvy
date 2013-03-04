#!/bin/bash

rake log:clear
rake cache:clear
rake db:sessions:clear
rake tmp:clear

rake db:test:purge
rake db:test:prepare
rake db:fixtures:load

rake stats

# rake tmp:pids:clear
# rake tmp:sockets:clear
# rake tmp:sessions:clear

# rake test:functionals
# rake test:integration
# rake test:plugins
# rake test:units
