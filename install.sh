#!/bin/bash


FILE0="rubygems-1.3.6"


sudo apt-get install ruby rdoc irb libyaml-ruby libzlib-ruby ri libopenssl-ruby libmysqlclient15-dev ruby1.8-dev

tar -zxvf ${FILE0}.tgz

cd ${FILE0}

sudo ruby setup.rb && sudo gem1.8 update --system && sudo gem1.8 install rails -y

sudo gem1.8 install mysql

cd ..

rm -rf ${FILE0}


exit 0
