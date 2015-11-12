#!/bin/bash
set -o nounset
set -o errexit

wget 'https://github.com/mudler/boson/releases/download/v0.2.3/boson_linux_amd64' \
          -O ~/boson && chmod +x ~/boson

# Trying to able to use arm with qemu-arm-static

# load the binfmt_misc module
if [ ! -d /proc/sys/fs/binfmt_misc ]; then
  sudo /sbin/modprobe binfmt_misc
fi

sudo apt-get install -y binfmt-support

sudo echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-binfmt:' > /proc/sys/fs/binfmt_misc/register
sudo wget 'https://github.com/Sabayon/docker-base-armhfp/raw/master/ext/qemu-arm-static' \
          -O /usr/bin/qemu-arm-binfmt && chmod +x /usr/bin/qemu-arm-binfmt

sudo wget 'https://raw.githubusercontent.com/Sabayon/docker-builder-amd64/master/script/builder' \
          -O /builder && chmod +x /builder

sudo mkdir -p /log_dir
sudo mkdir -p /artifacts_dir
