#!/bin/bash

total_args=$#

if [[ $total_args -lt 2 ]]; then
cat <<EOF
usage: $0 <path> <component> [<component> ...]

    path        Absolute path to react repo
    component   Component name
EOF
exit 1
fi

path=$1

while [ $# -gt 1 ]; do
    count=$(find $path -type f \! -path "*node_modules*" \! -path "*.git*" \( -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o  -name "*.tsx" \) -exec grep -o -E "import[A-Za-z\{\}\"\'\/\. ]*from[A-Za-z\{\}\"\'\/\. ]*$2" '{}' \; | wc -l)
    echo "${2} - ${count}"
    shift
done
