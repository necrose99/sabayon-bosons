#!/bin/bash
set -o nounset
set -o errexit

wget 'https://github.com/mudler/boson/releases/download/v0.2.2/boson_linux_amd64' \
          -O ~/boson && chmod +x ~/boson
sudo mkdir -p /log_dir
sudo mkdir -p /artifacts_dir
