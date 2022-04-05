#!/bin/bash

set -e
set -v
set -x

# Install .deb packages from release branch
git clone $1.git -b $2 tmp-install
cd tmp-install
for var in "${@:3}"
do
  if wget $1/releases/download/`git describe --abbrev=0 --tags`/"$var"_`git describe --abbrev=0 --tags|sed 's/^.//'`-1_amd64.deb ; then
    echo
  else
    wget $1/releases/download/`git describe --abbrev=0 --tags`/"$var"_`git describe --abbrev=0 --tags|sed 's/^.//'`-1_all.deb
  fi
done
dpkg -i *.deb 2>&1 | tee -a ../dpkg.log
cd ..
if grep -w 'dpkg: error' dpkg.log; then
  exit 1
fi
rm -rf tmp-install
