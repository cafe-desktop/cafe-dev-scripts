#!/bin/bash

set -e
set -v
set -x

# Install .deb packages from release branch
aptitude -y install ca-certificates
echo deb [trusted=yes] https://cafe-desktop.github.io/debian-packages/ ./ >> /etc/apt/sources.list
aptitude -y update

if [ $# -gt 0 ]
then
  aptitude -y install $1 > aptlog
  if grep -w "unmet dependencies" aptlog; then
    cat aptlog
    exit 1
  fi
  rm aptlog
fi
