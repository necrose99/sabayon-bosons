#!/bin/bash
set -o nounset
set -o errexit

wget 'https://github.com/mudler/boson/releases/download/v0.2.3/boson_linux_amd64' \
          -O ~/boson && chmod +x ~/boson

sudo wget 'https://raw.githubusercontent.com/Sabayon/docker-builder-amd64/master/script/builder' \
          -O /builder && chmod +x /builder

sudo mkdir -p /log_dir
sudo mkdir -p /artifacts_dir
