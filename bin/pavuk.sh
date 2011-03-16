#!/bin/sh

export TZ=Japan

pavuk=/usr/local/bin/pavuk
topdir=`pwd`
logdir=${topdir}/logs
date=`date '+%Y%m%d-%H%M'`
dstdir=${topdir}/pavuk

mkdir -p ${dstdir}
mkdir -p ${logdir}

time ${pavuk} -cdir ${dstdir} -base_level 2 -noRobots -preserve_time -lmax 2 -dont_leave_site -read_css -mode mirror http://tepco.mirror.myapp.jp/index-j.html
