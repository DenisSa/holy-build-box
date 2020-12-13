#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

GIT_VERSION=2.25.1

if ! eval_bool "$SKIP_GIT"; then
	header "Installing Git $GIT_VERSION"
	download_and_extract git-$GIT_VERSION.tar.gz \
		git-$GIT_VERSION \
		https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.gz

	(
		activate_holy_build_box_deps_installation_environment
		run make configure
		run ./configure --prefix=/hbb --without-tcltk
		run make -j$MAKE_CONCURRENCY
		run make install
		run strip --strip-all /hbb/bin/git
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf git-$GIT_VERSION
fi
