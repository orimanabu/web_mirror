#!/bin/sh

topdir=`pwd`
srcdir=${topdir}/pavuk
docroot=/var/www/html
dstdir=${docroot}/mirror

mkdir -p ${dstdir}
chgrp users ${dstdir}
chmod g+w ${dstdir}
rsync -av ${srcdir}/* ${dstdir}/
