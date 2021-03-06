#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

CCACHE_VERSION=3.5

if ! eval_bool "$SKIP_CCACHE"; then
	header "Installing ccache $CCACHE_VERSION"
	download_and_extract ccache-$CCACHE_VERSION.tar.gz \
		ccache-$CCACHE_VERSION \
		https://samba.org/ftp/ccache/ccache-$CCACHE_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb
		run make -j$MAKE_CONCURRENCY install
		run strip --strip-all /hbb/bin/ccache
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf ccache-$CCACHE_VERSION
fi
