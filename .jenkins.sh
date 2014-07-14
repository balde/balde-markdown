#!/bin/bash
#
# This script assumes that balde and dependencies are already installed on the
# system.
#
# They should be installed by hand if you are going to run a Jenkins slave.
#
#     $ sudo apt-get install -y peg libfcgi-dev shared-mime-info pkg-config gettext \
#         zlib1g-dev libffi-dev autoconf automake1.11 build-essential libtool \
#         libxml2-utils valgrind clang libmarkdown2-dev
#
# To install balde, run the .build-balde.sh script (from balde's git repository,
# see its code for help).


## balde-markdown variables
BALDE_MARKDOWN_SRC_DIR="$(pwd)"
BALDE_MARKDOWN_BUILD_DIR="${BALDE_MARKDOWN_SRC_DIR}/build"

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
