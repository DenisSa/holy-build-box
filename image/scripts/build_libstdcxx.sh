#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

GCC_LIBSTDCXX_VERSION=8.3.0

function install_libstdcxx()
{
	local VARIANT="$1"
	local PREFIX="/hbb_$VARIANT"

	header "Installing libstdc++ static libraries: $VARIANT"
	download_and_extract gcc-$GCC_LIBSTDCXX_VERSION.tar.gz \
		gcc-$GCC_LIBSTDCXX_VERSION \
		https://ftpmirror.gnu.org/gcc/gcc-$GCC_LIBSTDCXX_VERSION/gcc-$GCC_LIBSTDCXX_VERSION.tar.gz

	(
		source "$PREFIX/activate"
		run rm -rf ../gcc-build
		run mkdir ../gcc-build
		echo "+ Entering /gcc-build"
		cd ../gcc-build

		export CFLAGS="$STATICLIB_CFLAGS"
		export CXXFLAGS="$STATICLIB_CXXFLAGS"
		../gcc-$GCC_LIBSTDCXX_VERSION/libstdc++-v3/configure \
			--prefix=$PREFIX --disable-multilib \
			--disable-libstdcxx-visibility --disable-shared
		run make -j$MAKE_CONCURRENCY
		run mkdir -p $PREFIX/lib
		run cp src/.libs/libstdc++.a $PREFIX/lib/
		run cp libsupc++/.libs/libsupc++.a $PREFIX/lib/
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf gcc-$GCC_LIBSTDCXX_VERSION
	run rm -rf gcc-build
}

if ! eval_bool "$SKIP_LIBSTDCXX"; then
	for VARIANT in $VARIANTS; do
		install_libstdcxx $VARIANT
	done
fi
