#!/bin/sh

topdir=`pwd`
#srcdir=${topdir}/tepco_mirror
#dstdir=/var/www/html.wget
srcdir=${topdir}/pavuk
docroot=/var/www/html
dstdir=${docroot}/mirror

rsync -av ${srcdir}/* ${dstdir}/

#find ${dstdir} -name '*.html' | while read file; do
#	file ${file} | grep gzip > /dev/null
#	if [ $? != 0 ]; then
#		continue
#	fi
#	echo "inflating $file..."
# 	mv ${file} ${file}.gz
# 	gunzip ${file}.gz
#done

cat <<END > ${docroot}/index.html
<html>
<head>
<title>mirroring sites</title>
</head>
<body>
  <ul>
END

ls ${dstdir} | while read line; do
	echo ${line} | grep index.html > /dev/null 2>&1
	if [ $? = 0 ]; then
		continue
	fi
	cat >> ${docroot}/index.html <<END
    <li><a href="mirror/${line}">${line}</a></li>
END
done

cat <<END >> ${docroot}/index.html
  </ul>
</body>
</html>
END
