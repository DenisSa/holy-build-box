#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

if ! eval_bool "$SKIP_AUTOCONF"; then
	header "Installing autoconf $AUTOCONF_VERSION"
	download_and_extract autoconf-$AUTOCONF_VERSION.tar.gz \
		autoconf-$AUTOCONF_VERSION \
		https://ftpmirror.gnu.org/autoconf/autoconf-$AUTOCONF_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --disable-shared --enable-static
		run make -j$MAKE_CONCURRENCY
		run make install-strip
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf autoconf-$AUTOCONF_VERSION
fi
