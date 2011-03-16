#!/bin/sh

topdir=`pwd`
#srcdir=${topdir}/tepco_mirror
dstdir=/var/www/html.wget
srcdir=${topdir}/pavuk
dstdir=/var/www/html.pavuk

rsync -av ${srcdir}/ ${dstdir}/

#find ${dstdir} -name '*.html' | while read file; do
#	file ${file} | grep gzip > /dev/null
#	if [ $? != 0 ]; then
#		continue
#	fi
#	echo "inflating $file..."
# 	mv ${file} ${file}.gz
# 	gunzip ${file}.gz
#done
