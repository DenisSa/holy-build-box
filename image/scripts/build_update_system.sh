#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

header "Updating system"
if [ $(date --date '2020-11-30T00:00:00' +'%s') -lt $(date +'%s') ]; then
run sed -i.bak -re 's/^(mirrorlist)/#\1/g' -e 's/^#(baseurl)/\1/g' -e 's/mirror(\.centos)/vault\1/g' -e 's|centos/\$releasever/([^/]+)/([^/]+)|'$CENTOS_VERSION'/\1/\2|g' /etc/yum.repos.d/CentOS-Base.repo
rm /etc/yum.repos.d/CentOS-Base.repo.bak
if [[ -f /etc/yum.repos.d/libselinux.repo ]]; then
	run sed -i.bak -re 's/^(mirrorlist)/#\1/g' -e 's/^#(baseurl)/\1/g' -e 's/mirror(\.centos)/vault\1/g' -e 's|centos/\$releasever/([^/]+)/([^/]+)|'$CENTOS_VERSION'/\1/\2|g' /etc/yum.repos.d/libselinux.repo
	rm /etc/yum.repos.d/libselinux.repo.bak
fi
fi
touch /var/lib/rpm/*
run yum update -y
run yum install -y curl epel-release tar
