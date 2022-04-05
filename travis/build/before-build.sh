#!/bin/bash

set -e
set -v
set -x

mkdir html-report
unbuffer cppcheck $ARGS_CPPCHECK . 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi

if grep -w "`basename "${0}" .sh`: line" ./html-report/output_${TRAVIS_COMMIT}; then
  exit 1
fi
