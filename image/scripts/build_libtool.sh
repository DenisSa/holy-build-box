#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

LIBTOOL_VERSION=2.4.6

if ! eval_bool "$SKIP_LIBTOOL"; then
	header "Installing libtool $LIBTOOL_VERSION"
	download_and_extract libtool-$LIBTOOL_VERSION.tar.gz \
		libtool-$LIBTOOL_VERSION \
		https://ftpmirror.gnu.org/libtool/libtool-$LIBTOOL_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --disable-shared --enable-static
		run make -j$MAKE_CONCURRENCY
		run make install-strip
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf libtool-$LIBTOOL_VERSION
fi
