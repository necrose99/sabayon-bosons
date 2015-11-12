#!/bin/bash
set -o nounset
set -o errexit


./get_last_commit.sh $1 $2 $3
BOSON_FROM=$(cat $3) ~/boson -c $4
cp -rfv $2 $3
