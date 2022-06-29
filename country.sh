#!/bin/bash

total_args=$#

if [[ $total_args -lt 1 ]]; then
cat <<EOF
usage: $0 <country> [<country> ...]

    country   One or more country names separated by spaces
EOF
exit 1
fi

while [ $# -gt 0 ]; do
    country=$1
    url="https://restcountries.com/v3.1/name/${country}"
    
    response=$(curl --write-out '%{http_code}' --silent --output /dev/null $url)
    [[ $response -ne 200 ]] && printf "Error: ${country}\r\n\r\n"
    
    if [[ $response -eq 200 ]]; then
        curl -s $url | jq -r '.[] | ["Name: \(.name?.common?)", "Capital: \(.capital? // [] | join(", ")?)", "Population: \(.population?)", "Languages: \(.languages? // [] | join(", ")?)", "Currency: \([.currencies[]?.symbol?, .currencies[]?.name?] | join(" ")?)", ""] | .[]'
        # TODO: Remove last empty line
    fi
    shift
done

