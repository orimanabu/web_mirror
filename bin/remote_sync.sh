#!/bin/sh

export TZ=Japan

ps auxww | grep 'pavuk.sh' | grep -v grep
rc=$?

if [[ $rc -eq 0 ]]; then
        echo "Stopped as another pavuk.sh is working."
        exit 1
fi

topdir=`pwd`
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

${topdir}/bin/parse_conf.pl ${conf} | while read line; do
	echo line=$line >> ${logdir}/log.pavuk.${date}
	(cd ${topdir} && ./bin/pavuk.sh ${line} >> ${logdir}/log.pavuk.${date} 2>&1)
done
