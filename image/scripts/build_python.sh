#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

PYTHON_VERSION=2.7.15

if ! eval_bool "$SKIP_PYTHON"; then
	header "Installing Python $PYTHON_VERSION"
	download_and_extract Python-$PYTHON_VERSION.tgz \
		Python-$PYTHON_VERSION \
		https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb
		run make -j$MAKE_CONCURRENCY install
		run strip --strip-all /hbb/bin/python
		run strip --strip-debug /hbb/lib/python*/lib-dynload/*.so
	)
	if [[ "$?" != 0 ]]; then false; fi

	run hash -r

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf Python-$PYTHON_VERSION

	# Install setuptools and pip
	echo "Installing setuptools and pip..."
	run curl -OL --fail https://bootstrap.pypa.io/ez_setup.py
	run python ez_setup.py
	run rm -f ez_setup.py
	run easy_install pip
	run rm -f /setuptools*.zip
fi
