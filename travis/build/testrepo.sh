#!/bin/bash

set -e
set -v
set -x

git clone --depth 1 https://github.com/cafe-desktop/debian-packages -b gh-pages tmp-install
cd tmp-install
aptitude -y install `grep ^Package Packages | cut -d' ' -f2 | tr '\n' ' ' | sed 's/$/\n/'` > aptlog
if grep -w "Not Installed" aptlog; then
    cat aptlog
    cat aptlog|grep Depends
    exit 1
fi
cat aptlog
