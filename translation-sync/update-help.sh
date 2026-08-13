#!/bin/bash

set -e
set -v
set -x

for dir in ./*/; do
    dir=${dir%*/}
    for file in "$dir"/*.po; do
        [ -e "$file" ] || continue
        msgmerge -N "$file" "$1" > "$file.tmp"
        msgattrib --no-obsolete "$file.tmp" -o "$file"
        rm "$file.tmp"
    done
done
