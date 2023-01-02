#!/bin/bash

set -e
set -v
set -x

unbuffer apt list --installed `aptitude search ~o 2>&1 | tee -a --output-error=exit checkerror |cut -d ' ' -f3 2>&1 | tee -a --output-error=exit checkerror` 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi

cat ./html-report/output_${TRAVIS_COMMIT} | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' > tmpfile #remove colors in the logs
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
cat tmpfile > ./html-report/output_${TRAVIS_COMMIT}
if [ -f "dpkg.log" ]; then
    cat dpkg.log 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
    echo Errors detected in dpkg `cat dpkg.log 2>&1 | tee -a --output-error=exit checkerror | grep 'dpkg: error' 2>&1 | tee -a --output-error=exit checkerror| wc -l 2>&1 | tee -a --output-error=exit checkerror` 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
fi
echo Errors detected in the build `cat ./html-report/output_${TRAVIS_COMMIT} 2>&1 | tee -a --output-error=exit checkerror | grep ' error:' 2>&1 | tee -a --output-error=exit checkerror | grep -v "\[" 2>&1 | tee -a --output-error=exit checkerror | wc -l 2>&1 | tee -a --output-error=exit checkerror` 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
export WARNINGS_LOGS=`cat ./html-report/output_${TRAVIS_COMMIT} 2>&1 | tee -a --output-error=exit checkerror | grep -i warning 2>&1 | tee -a --output-error=exit checkerror | wc -l 2>&1 | tee -a --output-error=exit checkerror`
echo Warnings detected in the logs $WARNINGS_LOGS 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
export CPPCHECK_LOGS=`cat ./cppcheck-htmlreport/index.html 2>&1 | tee -a --output-error=exit checkerror | grep total 2>&1 | tee -a --output-error=exit checkerror | sed 's/           <tr><td><\/td><td>//g' 2>&1 | tee -a --output-error=exit checkerror | sed 's/<\/td><td>total<\/td><\/tr>//g' 2>&1 | tee -a --output-error=exit checkerror`
echo cppcheck defects detected in the logs $CPPCHECK_LOGS 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
echo TOTAL warnings detected in the logs `echo $(($WARNINGS_LOGS + $CPPCHECK_LOGS)) 2>&1 | tee -a --output-error=exit checkerror` 2>&1 | tee -a --output-error=exit ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi
if grep -w "`basename "${0}" .sh 2>&1 | tee -a --output-error=exit checkerror`: line" ./html-report/output_${TRAVIS_COMMIT}; then
  exit 1
fi
if grep -w "./after-build: line" checkerror; then
  exit 1
fi
rm checkerror
if grep -w 'undeclared.txt' ./html-report/output_${TRAVIS_COMMIT}; then
  find . -name '*undeclared.txt'
  cat `find . -name '*undeclared.txt'`
  exit 1
fi
