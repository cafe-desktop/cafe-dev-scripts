#!/bin/bash

set -e
set -v
set -x

# sample:
# ./build-debs https://github.com/cafe-desktop/debian-packages master cafe-sensors-applet
# or just ./build-debs for current repo with master branch

if [ $# -eq 0 ]
then
  giturl=https://github.com/${OWNER_NAME}/debian-packages
  gitbranch=master
  gitrepo=${REPO_NAME}
else
  giturl=$1
  gitbranch=$2
  gitrepo=$3
fi

aptitude install -y devscripts dh-make dh-exec
cd ${START_DIR}
mkdir -p html-report
git clone --depth 1 ${giturl}.git -b ${gitbranch} tmp-debs
cp -dpR ./tmp-debs/${gitrepo}/debian .
tar cfJv ../debian.tar.xz debian
mk-build-deps --install --remove --tool='aptitude -y' debian/control
dpkg-buildpackage -b -rfakeroot -us -uc
cd ..
tar cfJv deb_packages.tar.xz *deb *buildinfo *changes
mv *deb *buildinfo *changes debian.tar.xz deb_packages.tar.xz .${START_DIR}/html-report
