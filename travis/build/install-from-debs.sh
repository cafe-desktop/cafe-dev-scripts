#!/bin/bash

set -v
set -x

# Install .deb packages from release branch
git clone $1.git -b $2 tmp-install
cd tmp-install
for var in "${@:3}"
do
  wget $1/releases/download/`git describe --abbrev=0 --tags`/"$var"_`git describe --abbrev=0 --tags|sed 's/^.//'`-1_amd64.deb
  wget $1/releases/download/`git describe --abbrev=0 --tags`/"$var"_`git describe --abbrev=0 --tags|sed 's/^.//'`-1_all.deb
done
dpkg -i *.deb
cd ..
rm -rf tmp-install
