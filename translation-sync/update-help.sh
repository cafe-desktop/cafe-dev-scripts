#!/bin/bash

set -v
set -x

for dir in ./*/     # list directories in the form "/tmp/dirname/"
do
    dir=${dir%*/}      # remove the trailing "/"
#    echo "${dir##*/}"    # print everything after the final "/"
#    echo "./${dir##*/}/*.po"    # print everything after the final "/"
    msgmerge -U -N ./${dir##*/}/*.po $1;
done
