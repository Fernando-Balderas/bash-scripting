#!/bin/bash

total_args=$#

if [[ $total_args -lt 1 ]]; then
cat <<EOF
usage: $0 <path> [<author> <author> ...]

    path        Absolute path to react repo
    author      (Optional) Author name
EOF
exit 1
fi

path=$1
[[ ! -d $path ]] && exit 1
cd $path

if [[ $total_args -eq 1 ]]; then
    git shortlog --summary --numbered --email --all | awk '{printf("%s - %s\r\n", $2, $1)}'
fi

if [[ $total_args -gt 1 ]]; then
    while [ $# -gt 0 ]; do
        git shortlog --summary --numbered --email --all | grep $1 | awk '{printf("%s - %s\r\n", $2, $1)}'
        shift
    done
fi
