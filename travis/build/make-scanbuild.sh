#!/bin/bash

set -e
set -v
set -x

export TITLESCANBUILD="${REPO_NAME} (clang-tools `dpkg -s clang-tools|grep -i version|cut -d " " -f 2`) - scan-build results"
NOCONFIGURE=1 ./autogen.sh
scan-build $CHECKERS ./configure $1

if [ $CPU_COUNT -gt 1 ]; then
    unbuffer scan-build $CHECKERS --html-title="$TITLESCANBUILD" --keep-cc -o html-report make -j $(( $CPU_COUNT + 1 )) 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
else
    unbuffer scan-build $CHECKERS --html-title="$TITLESCANBUILD" --keep-cc -o html-report make 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
fi

unbuffer make check 2>&1 | tee -a ./html-report/output_${TRAVIS_COMMIT}
if [ ${PIPESTATUS[0]} -ne 0 ];then
    exit 1
fi

make install

if [ "${REPO_NAME}" != "ctk" ]; then
  make distcheck
fi
