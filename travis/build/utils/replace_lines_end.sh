#!/bin/bash

set -e

if [[ -d ".git" ]]
then
  if [ $# -gt 1 ] && [ $# -lt 3 ]
  then
    egrep --exclude=\*.{png,svg,xcf} --exclude-dir=.git -lRZ $1 . | xargs -0 -l sed -i -e '$s/'$1'/'$2'/'
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
    echo done
  else
    echo "2 arguments are required"
    exit
  fi
else
  echo "you aren't inside git repository"
  exit 1
fi
