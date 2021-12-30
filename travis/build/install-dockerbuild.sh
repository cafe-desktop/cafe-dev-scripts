#!/bin/bash

set -v
set -x

curl -Ls -o docker-build https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/docker-build
curl -Ls -o gen-index https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/gen-index.sh
curl -Ls -o html-cppcheck https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/build/html-cppcheck.sh
curl -Ls -o install-from-git https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/build/install-from-git.sh
curl -Ls -o install-from-debs https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/build/install-from-debs.sh
curl -Ls -o make-scanbuild https://github.com/cafe-desktop/cafe-dev-scripts/raw/master/travis/build/make-scanbuild.sh
chmod +x docker-build gen-index html-cppcheck install-from-git install-from-debs make-scanbuild
