#!/bin/bash
# This just installs the services file and fetch the latest version of boson. It is menant to be run in a VM, don't do it on your PC.

set -e

# Fetch latest version
echo "Installing latest boson(tm) available"
wget $(curl https://api.github.com/repos/mudler/boson/releases/latest -L | grep download | grep amd64 | sed 's/"browser_download_url": "//' | sed 's/"//') -O /usr/local/bin/boson
chmod +x /usr/local/bin/boson

echo "Copying services and bosons files"
cp -rfv services/* /etc/systemd/system/
cp -rfv *.boson /

systemctl daemon-reload
pushd services/
for f in *.service;
do
        echo "Starting and enabling $f"
        systemctl enable $f
        systemctl start $f
done
popd

mkdir -p /artifacts_dir/for-gentoo
mkdir -p /artifacts_dir/sabayon-distro
mkdir -p /log_dir/for-gentoo
mkdir -p /log_dir/sabayon-distro
