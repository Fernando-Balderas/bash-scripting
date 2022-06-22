#!/bin/bash

total_args=$#

if [[ $total_args -lt 1 ]]; then
cat <<EOF
Missing arguments

Execution: <PATH> [<AUTHOR> <AUTHOR> ...]

PATH: Absolute path
AUTHOR: (Optional) Author name
EOF
exit 1
fi

path=$1
original_path=pwd

cd $path

if [[ $total_args -eq 1 ]]; then
    git shortlog --summary --numbered --email --all | awk '{printf("%s - %s\n\r", $2, $1)}'
fi

if [[ $total_args -gt 1 ]]; then
    while [ $# -gt 0 ]; do
        git shortlog --summary --numbered --email --all | grep $1 | awk '{printf("%s - %s\n\r", $2, $1)}'
        shift
    done
fi
