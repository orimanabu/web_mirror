#!/bin/sh

function upper_path {
	local path=$1; shift
	echo ${path%/*}
}

function absolute_path {
	local script_path=$1; shift
	echo $(cd $(dirname ${script_path}) && pwd)/$(basename ${script_path})
}

abspath=`absolute_path $0`
bindir=`dirname ${abspath}`
topdir=`upper_path ${bindir}`
logdir=${topdir}/logs

OPT=`getopt t $*`
if [ $? != 0 ]; then
	echo "$0 [-t]"
	exit 1
fi

set -- $OPT
#echo BEFORE: $*

while true; do
	case $1 in
	-t)
		shift
		echo "===> variables:"
		echo abspath=${abspath}
		echo bindir=${bindir}
		echo topdir=${topdir}
		echo logdir=${logdir}
		echo "===> test for absolute_path"
		absolute_path "bin/mirror.sh"
		absolute_path "./bin/mirror.sh"
		absolute_path ${HOME}"/web_mirror/bin/mirror.sh"
 
		echo "===> test for upper_path"
		abspath=`absolute_path "bin/mirror.sh"`
		upper_path `dirname ${abspath}`
 
		;;
	--)
		shift
		break
		;;
	*)
		echo "unknown option: $1"
		;;
	esac
done
