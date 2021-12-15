#!/bin/bash

set -v
set -x

export TITLECPPCHECK="${REPO_NAME} (cppcheck `dpkg -s cppcheck|grep -i version|cut -d " " -f 2`)"
cppcheck --force --xml --output-file=cppcheck.xml --enable=warning,style,performance,portability,information,missingInclude .
cppcheck-htmlreport --title="$TITLECPPCHECK" --file=cppcheck.xml --report-dir=cppcheck-htmlreport
