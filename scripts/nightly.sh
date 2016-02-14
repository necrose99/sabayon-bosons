#!/bin/bash

repositories_dir=( "/artifacts_dir/sabayon-distro" "/artifacts_dir/for-gentoo")

for i in "${repositories_dir[@]}"
do
   OUTPUT_DIR="${i}_entropy" PORTAGE_ARTIFACTS="$i" sabayon-createrepo
done
