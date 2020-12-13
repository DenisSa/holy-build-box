#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

header "Installing compiler toolchain"
if [ `uname -m` != x86_64 ]; then
curl -s https://packagecloud.io/install/repositories/phusion/centos-6-scl-i386/script.rpm.sh | bash
sed -i 's|$arch|i686|; s|\$basearch|i386|g' $CHROOT/etc/yum.repos.d/phusion*.repo
DEVTOOLSET_VER=7
a 32-bit version of devtoolset-8 would need to get compiled
GCC_LIBSTDCXX_VERSION=7.3.0
else
run yum install -y centos-release-scl
DEVTOOLSET_VER=8
fi
run yum install -y devtoolset-${DEVTOOLSET_VER} file patch bzip2 zlib-devel gettext
