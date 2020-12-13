FROM centos:6
ADD image /hbb_build

RUN bash /hbb_build/scripts/initialize.sh
RUN bash /hbb_build/scripts/build_users_groups.sh
RUN bash /hbb_build/scripts/build_variants.sh
RUN bash /hbb_build/scripts/build_update_repos.sh
RUN bash /hbb_build/scripts/build_update_system.sh
RUN bash /hbb_build/scripts/build_install_compiler_toolchain.sh
RUN bash /hbb_build/scripts/build_system_openssl.sh
RUN bash /hbb_build/scripts/build_system_curl.sh
RUN bash /hbb_build/scripts/build_m4.sh
RUN bash /hbb_build/scripts/build_autoconf.sh
RUN bash /hbb_build/scripts/build_automake.sh
RUN bash /hbb_build/scripts/build_libtool.sh
RUN bash /hbb_build/scripts/build_pkgconfig.sh
RUN bash /hbb_build/scripts/build_ccache.sh
RUN bash /hbb_build/scripts/build_cmake.sh
RUN bash /hbb_build/scripts/build_git.sh
RUN bash /hbb_build/scripts/build_python.sh
RUN bash /hbb_build/scripts/build_libstdcxx.sh
RUN bash /hbb_build/scripts/build_zlib.sh
RUN bash /hbb_build/scripts/build_openssl.sh
RUN bash /hbb_build/scripts/build_curl.sh
RUN bash /hbb_build/scripts/build_sqlite.sh
