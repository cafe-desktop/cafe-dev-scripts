#!/bin/bash

set -e
set -v
set -x

if grep -w 'undeclared.txt' ./html-report/output_${TRAVIS_COMMIT}; then
  find . -name '*undeclared.txt'
  cat `find . -name '*undeclared.txt'`
  exit 1
fi
