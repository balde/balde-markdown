#!/bin/bash
#
# This script assumes that balde and dependencies are already installed on the
# system.
#
# They should be installed by hand if you are going to run a Jenkins slave.
#
#     $ sudo apt-get install -y peg libfcgi-dev shared-mime-info pkg-config gettext \
#         zlib1g-dev libffi-dev autoconf automake1.11 build-essential libtool \
#         libxml2-utils valgrind clang
#
# To install balde, run the .build-balde.sh script (from balde's git repository,
# see its code for help).
#
# Also, it depends on some enviromnent variables, that are setup by Jenkins:
#
#     BALDE_VERSION (e.g. 0.1.1)
#

## balde variables
BALDE_BASE_DIR="/opt/balde/${BALDE_VERSION}"


## balde variables
BALDE_MARKDOWN_SRC_DIR="$(pwd)"
BALDE_MARKDOWN_BUILD_DIR="${BALDE_MARKDOWN_SRC_DIR}/build"


## balde needs to know where to look for glib stuff
export PKG_CONFIG_LIBDIR="${BALDE_BASE_DIR}/lib/pkgconfig"
export PKG_CONFIG_PATH="${BALDE_BASE_DIR}/lib/pkgconfig:/usr/share/pkgconfig"
export PATH="${BALDE_BASE_DIR}/bin:${PATH}"

BALDE_VERSION_PKGCONFIG="$(pkg-config --modversion balde)"
if [[ "${BALDE_VERSION_PKGCONFIG}" != "${BALDE_VERSION}" ]]; then
    exit 1
fi

rm -rf "${BALDE_MARKDOWN_BUILD_DIR}"

./autogen.sh

mkdir -p "${BALDE_MARKDOWN_BUILD_DIR}"
pushd "${BALDE_MARKDOWN_BUILD_DIR}" > /dev/null
"${BALDE_MARKDOWN_SRC_DIR}"/configure \
    --with-valgrind
popd > /dev/null

make \
    -j"$(($(cat /proc/cpuinfo | grep processor | wc -l)+1))" \
    -C "${BALDE_MARKDOWN_BUILD_DIR}" valgrind
