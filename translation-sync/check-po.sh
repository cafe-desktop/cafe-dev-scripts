#!/bin/bash

set -v
set -x

for file in *.po; 
do 
  msgfmt -C $file;
done;
