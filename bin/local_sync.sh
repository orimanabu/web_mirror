#!/bin/sh

topdir=`pwd`
fetcher=pavuk
fetcher=wget
srcdir=${topdir}/${fetcher}
docroot=/var/www/html

# for pavuk
dstdir=${docroot}/mirror

# for wget
dstdir=${docroot}

mkdir -p ${dstdir}
chgrp users ${dstdir}
chmod g+w ${dstdir}
rsync -av ${srcdir}/* ${dstdir}/
