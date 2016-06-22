# EVH: TODO: removing the update process which requires binfmt_misc, etc. Lets just grab base images for now.
# Use qemu unless running on armv7l architecture
#if [ $(uname -m) != "aarm64" -a ! -f /proc/sys/fs/binfmt_misc/arm ]; then
#  sudo sh -c 'echo ":arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:" >/proc/sys/fs/binfmt_misc/register'
#fi
