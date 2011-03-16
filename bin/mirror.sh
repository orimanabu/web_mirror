#!/bin/sh

export TZ=Japan

topdir=`pwd`
logdir=${topdir}/logs
date=`date '+%Y%m%d-%H%M'`

cat ${topdir}/mirror.conf | while read line; do
	echo ${line} | grep '^#' > /dev/null 2>&1
	if [ $? = 0 ]; then
		echo "comment: ${line}"
	else
		echo "url: ${line}"
		echo "url: ${line}" >> ${logdir}/log.pavuk.${date}
		(cd ${topdir} && ./bin/pavuk.sh ${line} >> ${logdir}/log.pavuk.${date} 2>&1)
	fi
done
(cd ${topdir} && ./bin/local_sync.sh > ${logdir}/log.local.${date} 2>&1)

