#!/bin/bash

set -v
set -x

if [ $1 ]
then
  export DISTRO=$1
else
  export DISTRO='debian'
fi

export TRAVIS_COMMIT=$GITHUB_SHA
export TRAVIS_BRANCH=$(echo $GITHUB_REF |cut -d "/" -f3)
./docker-build --name "$DISTRO" --config .build.yml --install
./docker-build --name "$DISTRO" --verbose --config .build.yml --build scripts
