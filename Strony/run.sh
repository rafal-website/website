#!/bin/bash


rm -rf test

KATALOG=`pwd`

cd ..

export PATH="`pwd`/Installed/bin:${PATH}"

cd ${KATALOG}

rails test

cd test

ruby script/server --binding=localhost -d

ruby script/generate controller test index

rm -rf public/index.html

cp -r ../index.html.erb app/views/test/
cp -r ../routes.rb ../database.yml config/

#rake db:create


exit 0
