#!/bin/bash

set -e

if [[ -d ".git" ]]
then
  if [ $# -eq 1 ]
  then
    egrep --exclude=\*.{png,svg,xcf} --exclude-dir=.git -lRZ $1 . | xargs -0 -l sed -i -e '/'$1'/d'
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
    echo done
  else
    echo "1 argument is required"
    exit
  fi
else
  echo "you aren't inside git repository"
  exit 1
fi
