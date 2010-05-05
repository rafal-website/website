#!/bin/bash


KATALOG_OLD=`pwd`

cd ..
KATALOG=`pwd`
cd ${KATALOG_OLD}

FILE0="rubygems-1.3.6"
FILE1="ruby-1.8.7-p174"


if [ -e ${FILE1}.tar.gz ]
then
 tar -zxvf ${FILE1}.tar.gz > /dev/null
else
 wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/${FILE1}.tar.gz
 tar -zxvf ${FILE1}.tar.gz > /dev/null
fi

cd ${FILE1}

./configure --prefix="${KATALOG}/Installed" > /dev/null && make > /dev/null && make install > /dev/null

cd ..

tar -zxvf ${FILE0}.tgz

cd ${FILE0}

export PATH="${KATALOG}/Installed/bin:${PATH}"
export LD_LIBRARY_PATH="${KATALOG}/Installed/lib:${LD_LIBRARY_PATH}"

ruby setup.rb && gem update --system && gem install rails -y

gem install sqlite3-ruby
gem install mysql

cd ..

rm -rf ${FILE0} ${FILE1}


exit 0
