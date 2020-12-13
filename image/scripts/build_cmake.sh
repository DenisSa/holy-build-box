#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

CMAKE_VERSION=3.16.4
CMAKE_MAJOR_VERSION=3.16

if ! eval_bool "$SKIP_CMAKE"; then
	header "Installing CMake $CMAKE_VERSION"
	download_and_extract cmake-$CMAKE_VERSION.tar.gz \
		cmake-$CMAKE_VERSION \
		https://cmake.org/files/v$CMAKE_MAJOR_VERSION/cmake-$CMAKE_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --no-qt-gui --parallel=$MAKE_CONCURRENCY
		run make -j$MAKE_CONCURRENCY
		run make install
		run strip --strip-all /hbb/bin/cmake /hbb/bin/cpack /hbb/bin/ctest
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf cmake-$CMAKE_VERSION
fi
