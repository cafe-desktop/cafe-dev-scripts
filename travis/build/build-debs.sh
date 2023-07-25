#!/bin/bash

set -e
set -v
set -x

# sample:
# ./build-debs https://github.com/cafe-desktop/debian-packages master cafe-sensors-applet
# between make-scanbuild and after-build

aptitude install -y devscripts dh-make dh-exec
cd ${START_DIR}
mkdir -p html-report
git clone --depth 1 $1.git -b $2 tmp-debs
cp -dpR ./tmp-debs/$3/debian .
mk-build-deps --install --remove --tool='aptitude -y' debian/control
dpkg-buildpackage -b -rfakeroot -us -uc
cd ..
tar cfJv deb_packages.tar.xz *deb *buildinfo *changes
mv *deb *buildinfo *changes deb_packages.tar.xz .${START_DIR}/html-report
