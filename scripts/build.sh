#!/bin/bash
#set -o nounset
set -o errexit

repository_url="$1"
last_commit_path="$2"
previous_commit_path="$3"
boson_file="$4"

die() { echo "$@" 1>&2 ; exit 1; }

[ -z "$repository_url" ] && echo "No repository url defined" &&  exit 2 
[ -z "$last_commit_path" ] && echo "No path to save the last commit is defined" &&  exit 2                                                                                                                                                                                  
[ -z "$previous_commit_path" ] && echo "No path to save the previous commit is defined" &&  exit 2
[ -z "$boson_file" ] && echo "No boson file is defined" &&  exit 2                                                                                                                                                                                                         


[ ! -e ~/.bosonstate ] && mkdir -p ~/.bosonstate

echo ">> Git repository: $repository_url"
echo ">> Extrapolating last commit, and saving it in $last_commit_path"

curl -s $repository_url | \
        grep '"sha": "' | \
        sed -n '1p' | \
        sed 's/  "sha": "//g' | \
        sed 's/",//g'  > $last_commit_path

[ -e $last_commit_path ] || die "Error fetching the last commit of the repository" 


if [[ ! -e $previous_commit_path ]]  || [[ ! -s $previous_commit_path ]]; then
  cp -rfv $last_commit_path $previous_commit_path
  echo ">> There wasn't a previous commit, saving it to $previous_commit_path"
fi

echo ">> Starting build from "
last_commit=$(cat $last_commit_path)
previous_commit=$(cat $previous_commit_path)
echo "$last_commit"

[ -z "$last_commit" ] && die "No last commit was fetched"
[ -z "$previous_commit" ] && previous_commit="$last_commit"

#It's return value for now is not used

BOSON_FROM=$last_commit ~/boson -c $boson_file || true

cp -rfv $last_commit_path $previous_commit_path
