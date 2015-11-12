#!/bin/bash
set -o nounset
set -o errexit


./get_last_commit.sh $1 $2 $3
#It's return value for now is not used
BOSON_FROM=$(cat $3) ~/boson -c $4 || true
cp -rfv $2 $3
