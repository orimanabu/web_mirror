#!/bin/sh

topdir=/home/ori/tepco

logdir=${topdir}/logs
date=`date '+%Y%m%d-%H%M'`

#(cd ${topdir} && ./bin/remote_sync.sh > ${logdir}/log.remote.${date} 2>&1)
(cd ${topdir} && ./bin/pavuk.sh > ${logdir}/log.pavuk.${date} 2>&1)
(cd ${topdir} && ./bin/local_sync.sh > ${logdir}/log.local.${date} 2>&1)

