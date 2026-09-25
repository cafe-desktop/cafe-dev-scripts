#!/bin/bash

set -e
set -v
set -x

export TITLECPPCHECK="${REPO_NAME} (cppcheck `dpkg-query -W -f='${Version}' cppcheck`)"
cppcheck --xml --output-file=cppcheck.xml $ARGS_CPPCHECK .
cppcheck-htmlreport --title="$TITLECPPCHECK" --file=cppcheck.xml --report-dir=cppcheck-htmlreport
