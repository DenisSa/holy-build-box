#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

CURL_VERSION=7.63.0

if ! eval_bool "$SKIP_SYSTEM_CURL"; then
	header "Installing system Curl $CURL_VERSION"
	run tar xjf /hbb_build/curl-$CURL_VERSION.tar.bz2
	echo "Entering /curl-$CURL_VERSION"
	pushd "curl-$CURL_VERSION" >/dev/null

	(
		activate_holy_build_box_deps_installation_environment
		run ./configure --prefix=/hbb --disable-static --disable-debug --enable-optimize \
			--disable-manual --with-ssl --with-ca-bundle=/etc/pki/tls/certs/ca-bundle.crt
		run make -j$MAKE_CONCURRENCY
		run make install
		run strip --strip-all /hbb/bin/curl
		run strip --strip-debug /hbb/lib/libcurl.so
	)
	if [[ "$?" != 0 ]]; then false; fi

	hash -r

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf curl-$CURL_VERSION
fi
