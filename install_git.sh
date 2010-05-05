#!/bin/bash


KATALOG_OLD=`pwd`

cd ..
KATALOG=`pwd`
cd ${KATALOG_OLD}

rm -rf `ls -lah | egrep "git" | egrep "^d" | tr -s ' ' | cut -d ' ' -f 8`

if [ -e git-latest.tar.gz ]
then
 tar -zxvf git-latest.tar.gz > /dev/null
else
 wget http://www.codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.gz
 tar -zxvf git-latest.tar.gz > /dev/null
fi

cd `ls -lah | egrep "git" | egrep "^d" | tr -s ' ' | cut -d ' ' -f 8`

make configure > /dev/null && ./configure --prefix="${KATALOG}/Installed" > /dev/null && make > /dev/null && make install > /dev/null

cd ..

rm -rf `ls -lah | egrep "git" | egrep "^d" | tr -s ' ' | cut -d ' ' -f 8`


exit 0
