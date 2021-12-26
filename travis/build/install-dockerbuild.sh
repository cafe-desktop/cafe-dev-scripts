#!/bin/bash

set -v
set -x

curl -Ls -o docker-build https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/docker-build
curl -Ls -o gen-index https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/gen-index.sh
curl -Ls -o html-cppcheck https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/build/html-cppcheck.sh
chmod +x docker-build gen-index html-cppcheck
