#!/bin/bash

set -e
set -v
set -x

curl -Ls -o docker-build https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/docker-build
curl -Ls -o gen-index https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/gen-index.sh
curl -Ls -o html-cppcheck https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/html-cppcheck.sh
curl -Ls -o install-from-git https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/install-from-git.sh
curl -Ls -o install-from-debs https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/install-from-debs.sh
curl -Ls -o make-scanbuild https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/make-scanbuild.sh
curl -Ls -o after-build https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/after-build.sh
curl -Ls -o before-build https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/before-build.sh
curl -Ls -o debrepo-install https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/debrepo-install.sh
curl -Ls -o build-debs https://github.com/cafe-desktop/cafe-dev-scripts/raw/devel/travis/build/build-debs.sh
chmod +x docker-build gen-index html-cppcheck install-from-git install-from-debs make-scanbuild after-build before-build debrepo-install build-debs
