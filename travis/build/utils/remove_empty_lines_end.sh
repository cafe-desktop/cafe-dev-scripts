#!/bin/bash

set -e

if [[ -d ".git" ]]
then
    egrep --exclude=\*.{png,svg,xcf} --exclude-dir=.git -lRZ $1 . | xargs -0 -l sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}'
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
    echo done
else
  echo "you aren't inside git repository"
  exit 1
fi
