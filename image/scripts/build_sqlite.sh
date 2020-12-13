#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

function install_sqlite()
{
	local VARIANT="$1"
	local PREFIX="/hbb_$VARIANT"

	header "Installing SQLite $SQLITE_VERSION static libraries: $PREFIX"
	download_and_extract sqlite-autoconf-$SQLITE_VERSION.tar.gz \
		sqlite-autoconf-$SQLITE_VERSION \
		https://www.sqlite.org/$SQLITE_YEAR/sqlite-autoconf-$SQLITE_VERSION.tar.gz

	(
		source "$PREFIX/activate"
		export CFLAGS="$STATICLIB_CFLAGS"
		export CXXFLAGS="$STATICLIB_CXXFLAGS"
		run ./configure --prefix="$PREFIX" --enable-static \
			--disable-shared --disable-dynamic-extensions
		run make -j$MAKE_CONCURRENCY
		run make install
		if [[ "$VARIANT" = exe_gc_hardened ]]; then
			run hardening-check -b "$PREFIX/bin/sqlite3"
		fi
		run strip --strip-all "$PREFIX/bin/sqlite3"
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf sqlite-autoconf-$SQLITE_VERSION
}

if ! eval_bool "$SKIP_SQLITE"; then
	for VARIANT in $VARIANTS; do
		install_sqlite $VARIANT
	done
	run mv /hbb_exe_gc_hardened/bin/sqlite3 /hbb/bin/
	for VARIANT in $VARIANTS; do
		run rm -f /hbb_$VARIANT/bin/sqlite3
	done
fi
