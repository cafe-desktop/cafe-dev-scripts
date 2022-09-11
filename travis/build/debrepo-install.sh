#!/bin/bash

set -e
set -v
set -x

# Install .deb packages from release branch
echo deb [trusted=yes] https://cafe-desktop.github.io/debian-packages/ ./ >> /etc/apt/sources.list
aptitude -y update
aptitude -y install $1 > aptlog
if grep -w "unmet dependencies" aptlog; then
  exit 1
fi
