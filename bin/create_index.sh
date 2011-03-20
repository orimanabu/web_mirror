#!/bin/sh

if [ x"$#" != x1 ]; then
	echo "$0 conf"
	exit 1
fi
conf=$1; shift

subr=`dirname $0`/subr.sh
. ${subr}
. ${topdir}/env.sh

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
