#!/bin/bash

set -e
set -v
set -x

for file in *.po;
do
  msgmerge -N "$file" "$1" > "$file.tmp"
  msgattrib --no-obsolete "$file.tmp" -o "$file"
  rm "$file.tmp"
done
