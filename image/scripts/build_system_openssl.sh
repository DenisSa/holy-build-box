#!/bin/bash

set -e

source /hbb_build/scripts/common.sh


if ! eval_bool "$SKIP_SYSTEM_OPENSSL"; then
	header "Installing system OpenSSL $OPENSSL_VERSION"
	download_and_extract openssl-$OPENSSL_VERSION.tar.gz \
		openssl-$OPENSSL_VERSION \
		https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
	(
		activate_holy_build_box_deps_installation_environment
		run ./config --prefix=/hbb --openssldir=/hbb/openssl threads zlib shared
		run make
		run make install_sw
		run strip --strip-all /hbb/bin/openssl
		run strip --strip-debug /hbb/lib/libssl.so /hbb/lib/libcrypto.so
		run rm -f /hbb/lib/libssl.a /hbb/lib/libcrypto.a
		run ln -s /etc/pki/tls/certs/ca-bundle.crt /hbb/openssl/cert.pem
	)
	if [[ "$?" != 0 ]]; then false; fi

	echo "Leaving source directory"
	popd >/dev/null
	run rm -rf openssl-$OPENSSL_VERSION
fi
