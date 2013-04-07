#!/bin/bash
rake log:clear
rake cache:clear
rake db:sessions:clear
rake tmp:clear
rake stats
