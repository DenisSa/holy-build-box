#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

AUTOMAKE_VERSION=1.16.1

if ! eval_bool "$SKIP_AUTOMAKE"; then
	header "Installing automake $AUTOMAKE_VERSION"
	download_and_extract automake-$AUTOMAKE_VERSION.tar.gz \
		automake-$AUTOMAKE_VERSION \
		https://ftpmirror.gnu.org/automake/automake-$AUTOMAKE_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --disable-shared --enable-static
		run make -j$MAKE_CONCURRENCY
		run make install-strip
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf automake-$AUTOMAKE_VERSION
fi
