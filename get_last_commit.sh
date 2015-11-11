#!/bin/bash
set -o nounset
set -o errexit


if [[ ! -e ~/.bosonstate ]]; then mkdir -p ~/.bosonstate; fi
curl -s $1 | \
        grep '"sha": "' | \
        sed -n '1p' | \
        sed 's/  "sha": "//g' | \
        sed 's/",//g'  > $2
