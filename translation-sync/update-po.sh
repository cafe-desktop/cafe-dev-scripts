#!/bin/bash

set -e
set -v
set -x

for file in *.po; 
do 
  msgmerge -U -N $file $1;
done;
