#!/bin/bash

set -e
set -v
set -x

if cat ./html-report/output_${TRAVIS_COMMIT}|grep -i warning|grep -v "autoreconf: export WARNINGS"; then exit 1; fi
