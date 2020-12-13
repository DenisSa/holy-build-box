#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

if ! eval_bool "$SKIP_PKG_CONFIG"; then
	header "Installing pkg-config $PKG_CONFIG_VERSION"
	download_and_extract pkg-config-$PKG_CONFIG_VERSION.tar.gz \
		pkg-config-$PKG_CONFIG_VERSION \
		https://pkgconfig.freedesktop.org/releases/pkg-config-$PKG_CONFIG_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --with-internal-glib
		run rm -f /hbb/bin/*pkg-config
		run make -j$MAKE_CONCURRENCY install-strip
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf pkg-config-$PKG_CONFIG_VERSION
fi
