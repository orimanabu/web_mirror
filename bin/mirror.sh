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

#cat ${topdir}/mirror.conf | while read line; do
#	echo ${line} | grep '^#' > /dev/null 2>&1
#	if [ $? = 0 ]; then
#		echo "comment: ${line}"
#	else
#		echo "url: ${line}"
#		echo "url: ${line}" >> ${logdir}/log.pavuk.${date}
${topdir}/bin/parse_conf.pl ${topdir}/mirror.conf | while read line; do
	echo line=$line
	(cd ${topdir} && ./bin/pavuk.sh ${line} >> ${logdir}/log.pavuk.${date} 2>&1)
done
(cd ${topdir} && ./bin/local_sync.sh > ${logdir}/log.local.${date} 2>&1)

