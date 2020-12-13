#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

if ! eval_bool "$SKIP_M4"; then
	header "Installing m4 $M4_VERSION"
	download_and_extract m4-$M4_VERSION.tar.gz \
		m4-$M4_VERSION \
		https://ftpmirror.gnu.org/m4/m4-$M4_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --disable-shared --enable-static
		run make -j$MAKE_CONCURRENCY
		run make install-strip
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf m4-$M4_VERSION
fi
