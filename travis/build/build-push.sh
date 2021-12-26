#!/bin/bash

set -v
set -x

export TRAVIS_COMMIT=$GITHUB_SHA
export TRAVIS_BRANCH=$(echo $GITHUB_REF |cut -d "/" -f3)
./docker-build --name "debian" --config .build.yml --install
./docker-build --name "debian" --verbose --config .build.yml --build scripts
