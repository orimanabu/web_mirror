#!/bin/sh

subr=`dirname $0`/subr.sh
. ${subr}
. ${topdir}/env.sh

builddir=${topdir}/build
prefix=/usr/local

mkdir -p ${builddir}

#echo "===> git"
#(cd ${builddir} && tar jxvf ${topdir}/Downloads/git-1.7.4.1.tar.bz2)
#(cd ${builddir}/git-1.7.4.1 && ./configure --prefix=${prefix})
#(cd ${builddir}/git-1.7.4.1 && make install)

echo "===> pavuk"
(cd ${builddir} && tar zxvf ${topdir}/Downloads/pavuk-0.9.35.tar.gz)
(cd ${builddir}/pavuk-0.9.35 && ./configure --prefix=${prefix})
(cd ${builddir}/pavuk-0.9.35 && make install)

echo "===> wget"
(cd ${builddir} && tar jxvf ${topdir}/Downloads/wget-1.12.tar.bz2)
(cd ${builddir}/wget-1.12 && ./configure --prefix=${prefix})
(cd ${builddir}/wget-1.12 && make install)
