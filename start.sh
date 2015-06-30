#!/bin/bash

# After editing these values, rename this file to start.sh

# This file will be seeded with default values that each individual
# developer should change when they first start
# working on the repo. This file should be in the .gitignore
# so usernames and passwords aren't commited to the repo.

source config.sh

nodemon server/server.js
