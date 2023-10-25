#!/bin/bash

set -e
set -v
set -x

export TITLECPPCHECK="${REPO_NAME} (cppcheck `dpkg -l cppcheck|grep cppcheck|cut -d " " -f10`)"
cppcheck --xml --output-file=cppcheck.xml $ARGS_CPPCHECK .
cppcheck-htmlreport --title="$TITLECPPCHECK" --file=cppcheck.xml --report-dir=cppcheck-htmlreport
