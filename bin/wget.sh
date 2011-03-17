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

time ${wget} --directory-prefix=${dstdir}/mirror --recursive --page-requisites --convert-links --server-response --timestamping --level ${level} ${URL}
## -r : --recursive
## -k : --convert-links
## -np : --no-parent
## -p : --page-requisites
## -nH : --no-host-directories
## -l : --level
## -N : --timestamping
## -D : --domains
#
##wget -K -r -p -S -l 2 -I /cc/press/ http://tepco.mirror.myapp.jp/cc/press/index-j.html
##wget -r -k -np -p -nH -l 0 -N -D www.tepco.co.jp http://www.tepco.co.jp/
#
#ps -ef | grep wge[t]
#rc=$?
#
#if [[ $rc -eq 0 ]]; then
#        echo "Stopped as another wget is working."
#        exit 1
#fi
#
#export TZ=Japan
#
#wget=/usr/local/bin/wget
#topdir=`pwd`
#dstdir=${topdir}/tepco_mirror
#logdir=${topdir}/logs
#logfile=${logdir}/log.wget.`date '+%Y%m%d-%H%M'`
#
#mkdir -p ${dstdir}
#mkdir -p ${logdir}
#
#URL=http://tepco.mirror.myapp.jp/cc/press/index-j.html
#URL=http://tepco.mirror.myapp.jp/index-j.html
#URL=http://tepco.mirror.myapp.jp/
#
#echo "===> print debug information..."
#${wget} --version
#
#rm -f ${topdir}/index-j.html*
#echo "===> get top index.html file..."
#${wget} \
#--directory-prefix=${dstdir} \
#--no-host-directories \
#${URL}/index-j.html
#
##echo "===> debug"
##ls ${dstdir}/index-j.html*
#
##echo "===> gunzip index.html..."
##mv ${dstdir}/index-j.html ${dstdir}/index-j.html.gz
##gunzip ${dstdir}/index-j.html.gz
#
##echo "===> debug"
##ls ${dstdir}/index-j.html*
#
#echo "===> get all files..."
#time ${wget} \
#--directory-prefix=${dstdir} \
#--recursive \
#--no-host-directories \
#--page-requisites \
#--server-response \
#--timestamping \
#--level 2 \
#--force-html \
#--input-file=${dstdir}/index-j.html \
#--base=${URL}
