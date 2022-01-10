#!/bin/bash

set -v
set -x

unbuffer apt list --installed cafe-common libctk-3-dev 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
cat ./html-report/output_${TRAVIS_COMMIT} | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' > tmpfile #remove colors in the logs
cat tmpfile > ./html-report/output_${TRAVIS_COMMIT}
echo Errors detected in the build `cat ./html-report/output_${TRAVIS_COMMIT} | grep ' error:' | grep -v "\[" | wc -l` 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
echo Warnings detected in the logs `cat ./html-report/output_${TRAVIS_COMMIT} | grep -i warning | wc -l` 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
