#!/bin/bash

set -e
set -v
set -x

unbuffer apt list --installed cafe-common libctk-3-dev 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi

cat ./html-report/output_${TRAVIS_COMMIT} | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' > tmpfile #remove colors in the logs
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
cat tmpfile > ./html-report/output_${TRAVIS_COMMIT}
if [ -f "dpkg.log" ]; then
    cat dpkg.log 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
    echo Errors detected in dpkg `cat dpkg.log | grep 'dpkg: error' | wc -l` 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
fi
echo Errors detected in the build `cat ./html-report/output_${TRAVIS_COMMIT} | grep ' error:' | grep -v "\[" | wc -l` 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
export WARNINGS_LOGS=`cat ./html-report/output_${TRAVIS_COMMIT} | grep -i warning | wc -l`
echo Warnings detected in the logs $WARNINGS_LOGS 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
export CPPCHECK_LOGS=`cat ./cppcheck-htmlreport/index.html |grep total|sed 's/           <tr><td><\/td><td>//g'|sed 's/<\/td><td>total<\/td><\/tr>//g'`
echo cppcheck defects detected in the logs $CPPCHECK_LOGS 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
echo TOTAL warnings detected in the logs `echo $(($WARNINGS_LOGS + $CPPCHECK_LOGS))` 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if grep -w "`basename "${0}" .sh`: line" ./html-report/output_${TRAVIS_COMMIT}; then
  exit 1
fi
