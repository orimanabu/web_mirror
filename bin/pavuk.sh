#!/bin/sh

export TZ=Japan

if [ x"$#" != x"1" ]; then
	echo "$0 URL"
	exit 1
fi
URL=$1; shift

pavuk=/usr/local/bin/pavuk
topdir=`pwd`
logdir=${topdir}/logs
date=`date '+%Y%m%d-%H%M'`
dstdir=${topdir}/pavuk

mkdir -p ${dstdir}
mkdir -p ${logdir}

time ${pavuk} -cdir ${dstdir} -index_name index.html -base_level 1 -noRobots -preserve_time -lmax 2 -dont_leave_site -read_css -mode mirror ${URL}
