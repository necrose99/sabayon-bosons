#!/bin/bash
set -o nounset
set -o errexit


if [[ ! -e ~/.bosonstate ]]; then mkdir -p ~/.bosonstate; fi
curl -s $1 | \
        grep '"sha": "' | \
        sed -n '1p' | \
        sed 's/  "sha": "//g' | \
        sed 's/",//g'  > $2
if [[ ! -e $3 ]]; then cp -rfv $2 $3; fi

#It's return value for now is not used
BOSON_FROM=$(cat $3) ~/boson -c $4 || true
cp -rfv $2 $3
