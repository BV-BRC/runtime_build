#!/bin/bash

target=${TARGET-"/kb/runtime"}
if [[ $# -ne 0 ]] ; then
        target=$1
        shift
fi

IDIR=$target

# download and install daemonize
git clone https://github.com/bmc/daemonize.git
pushd daemonize
./configure --prefix=$IDIR
make || exit 1
make install || exit 1
popd
rm -rf daemonize
ln -s $IDIR/sbin/daemonize $IDIR/bin/daemonize
