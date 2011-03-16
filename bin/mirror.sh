#!/bin/sh

export TZ=Japan

ps auxww | grep 'pavuk.sh' | grep -v grep
rc=$?

if [[ $rc -eq 0 ]]; then
        echo "Stopped as another pavuk.sh is working."
        exit 1
fi

#topdir=`pwd`
topdir=`dirname $0 | sed -e 's,\(.*\)/[^/]*,\1,'`
logdir=${topdir}/logs
date=`date '+%Y%m%d-%H%M'`
conf=${topdir}/mirror.conf

if [ x"$#" != x"0" ]; then
	if [ -f $1 ]; then
		conf=$1
	else
		echo "can't open conf file: $1"
		exit 1
	fi
fi

(cd ${topdir} && ./bin/remote_sync.sh ${conf} > ${logdir}/log.remote_sync.${date} 2>&1)
(cd ${topdir} && ./bin/local_sync.sh > ${logdir}/log.local_sync.${date} 2>&1)
(cd ${topdir} && ./bin/create_index.sh ${conf} > ${logdir}/log.create_index.${date} 2>&1)
