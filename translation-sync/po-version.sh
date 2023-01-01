#!/bin/bash

set -e

if [ ${PWD##*/} == "po" ]
then
  if [ $# -gt 1 ] && [ $# -lt 3 ]
  then
    egrep --include=\*.po --exclude-dir=.git -lRZ . | xargs -0 -l sed -i -e '/Project-Id-Version/c\\"Project-Id-Version: '$1' '$2'\\n\"'
    if [ ${PIPESTATUS[0]} -ne 0 ];then
        exit 1
    fi
    echo done
  else
    echo "2 arguments are required"
    exit
  fi
else
  echo "you aren't inside po folder"
  exit 1
fi
