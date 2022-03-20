#!/bin/bash

set -e
set -v
set -x

mkdir html-report
unbuffer cppcheck $ARGS_CPPCHECK . 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
