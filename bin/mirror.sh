#!/bin/sh

export TZ=Japan
subr=`dirname $0`/subr.sh
. ${subr}
. ${topdir}/env.sh
date=`date '+%Y%m%d-%H%M'`
conf=${topdir}/mirror.conf
fetcher=${site_fetcher:=wget}
docroot=${site_docroot:=/var/www/html}

ps auxww | grep ${fetcher}.sh | grep -v grep
rc=$?

if [[ $rc -eq 0 ]]; then
        echo "Stopped as another ${fetcher}.sh is working."
        exit 1
fi

if [ x"$#" != x"0" ]; then
	if [ -f $1 ]; then
		conf=$1
	else
		echo "can't open conf file: $1"
		exit 1
	fi
fi

echo "===> mirror.sh"
date
echo "conf: ${conf}"
${topdir}/bin/parse_conf.pl --fetcher=${fetcher} ${conf} | while read line; do
	echo "url: ${line}"
done
echo "topdir: ${topdir}"
echo "logdir: ${logdir}"
echo "docroot: ${docroot}"
echo "fetcher: ${fetcher}"

(cd ${topdir} && ./bin/remote_sync.sh ${conf} > ${logdir}/log.remote_sync.${date} 2>&1)
(cd ${topdir} && ./bin/local_sync.sh > ${logdir}/log.local_sync.${date} 2>&1)

chcon=`which chcon`
if [ $? = 0 ]; then
	echo "chcon: ${chcon}"
	${chcon} -t httpd_sys_content_t ${docroot}/mirror -R
fi

#(cd ${topdir} && ./bin/create_index.sh ${conf} > ${logdir}/log.create_index.${date} 2>&1)

date
