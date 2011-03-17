#!/bin/sh

export TZ=Japan
fetcher=wget

ps auxww | grep ${fetcher}.sh | grep -v grep
rc=$?

if [[ $rc -eq 0 ]]; then
        echo "Stopped as another ${fetcher}.sh is working."
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
	echo line=$line >> ${logdir}/log.${fetcher}.${date}
	(cd ${topdir} && ./bin/${fetcher}.sh ${line} >> ${logdir}/log.${fetcher}.${date} 2>&1)
done
