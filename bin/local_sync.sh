#!/bin/sh

subr=`dirname $0`/subr.sh
. ${subr}
. ${topdir}/env.sh

fetcher=${site_fetcher:=wget}

srcdir=${topdir}/${fetcher}
docroot=${site_docroot:=/var/www/html}

# for pavuk
dstdir=${docroot}/mirror

# for wget
dstdir=${docroot}

mkdir -p ${dstdir}
chgrp users ${dstdir}
chmod g+w ${dstdir}
rsync -av ${srcdir}/* ${dstdir}/
