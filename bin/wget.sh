#!/bin/sh

export TZ=Japan

if [ "$#" -lt "2" ]; then
	echo "$0 URL level"
	exit 1
fi
URL=$1; shift
level=$1; shift

wget=/usr/local/bin/wget
topdir=`pwd`
logdir=${topdir}/logs
date=`date '+%Y%m%d-%H%M'`
dstdir=${topdir}/wget

mkdir -p ${dstdir}/mirror
mkdir -p ${logdir}

time ${wget} \
--directory-prefix=${dstdir}/mirror \
--recursive \
--page-requisites \
--convert-links \
--server-response \
--backup-converted \
--timestamping \
--level=${level} \
${URL}
