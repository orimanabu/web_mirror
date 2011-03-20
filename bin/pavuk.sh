#!/bin/sh

export TZ=Japan
subr=`dirname $0`/subr.sh
. ${subr}
. ${topdir}/env.sh

pavuk=${site_pavuk:=/usr/local/bin/pavuk}
date=`date '+%Y%m%d-%H%M'`
dstdir=${topdir}/pavuk

if [ "$#" -lt "2" ]; then
	echo "$0 URL level"
	exit 1
fi
URL=$1; shift
level=$1; shift

mkdir -p ${dstdir}/mirror
mkdir -p ${logdir}

time ${pavuk} \
-store_info \
-noCGI \
-limit_inlines \
-cdir ${dstdir}/mirror \
-index_name index.html \
-base_level 1 \
-noRobots \
-preserve_time \
-lmax ${level} \
-dont_leave_site \
-read_css \
-mode sync \
${URL}
