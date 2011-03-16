#!/bin/sh

if [ x"$#" != x1 ]; then
	echo "$0 conf"
	exit 1
fi
conf=$1; shift

topdir=`pwd`
docroot=/var/www/html
dstdir=${docroot}/mirror

cat <<END > ${docroot}/index.html
<html>
<head>
<title>mirroring sites</title>
</head>
<body>
  <ul>
END

#ls ${dstdir} | while read line; do
#	echo ${line} | grep index.html > /dev/null 2>&1
#	if [ $? = 0 ]; then
#		continue
#	fi
${topdir}/bin/parse_conf.pl ${conf} | while read line; do
	url=`echo ${line} | cut -d' ' -f1`
	path=`echo ${line} | cut -d' ' -f3`
	cat >> ${docroot}/index.html <<END
    <li><a href="mirror/${path}">${url}</a></li>
END
done

cat <<END >> ${docroot}/index.html
  </ul>
</body>
</html>
END
chgrp users ${docroot}/index.html
chmod g+w ${docroot}/index.html
