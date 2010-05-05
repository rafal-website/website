#!/bin/bash


function usage() {
 echo "[ ERROR ]" > /dev/stderr
 echo "Usage: ${1} < import/checkout/commit/update/list > < path_to_project > < 0/1 >" > /dev/stderr
 exit 0
}


if [ ${#} -ne 3 ]
then
 usage ${0}
fi

KATALOG_OLD=`pwd`

cd ..
KATALOG=`pwd`
cd ${KATALOG_OLD}

if [ -e ${KATALOG}/Installed ]
then
 export PATH="${KATALOG}/Installed/bin:${PATH}"
fi

git config --global user.name "Rafal Opiela"
git config --global user.email opiela@wsisiz.edu.pl

KATALOG=`pwd`
PROGRAM=`basename ${0}`

if [ "${1}" == "import" ]
then
 rm -rf `find \`pwd\` -type d | egrep ".git$"`

 git config --global user.name "Rafal Opiela"
 git config --global user.email opiela@wsisiz.edu.pl

 git config --global color.diff auto
 git config --global color.status auto
 git config --global color.branch auto

 git init
 git add .
 git commit -a -m "Initial commit"

 if [ ${3} -eq 0 ]
 then
  cd ..

  rm -rf ${2}
 fi

 if [ -e ~/.ssh ]
 then
  mv ~/.ssh ~/.ssh_org
 fi

 cp -r .ssh ~

 if [ ${3} -eq 0 ]
 then
  git clone --bare -l ${KATALOG}/.git ${2}
 else
  git remote add origin git@github.com:rafal-website/website.git
  git push origin master
 fi

 if [ -e ~/.ssh_org ]
 then
  rm -rf ~/.ssh
  mv ~/.ssh_org ~/.ssh
 fi
elif [ "${1}" == "checkout" ]
then
 cd ..
 rm -rf ${KATALOG}

 #git://github.com/rafal-website/website.git
 git clone ${2} ${KATALOG}
elif [ "${1}" == "update" ]
then
 git pull
elif [ "${1}" == "commit" ]
then
 git add .
 git commit -a -m "Commiting changes"
 git push git@github.com:rafal-website/website.git
 git pull
elif [ "${1}" == "list" ]
then
 cd .. && git clone ${2} ${KATALOG}_Tmp

 cd ${KATALOG}_Tmp && find `pwd` -type f | egrep -v "\/\.git"

 cd .. && rm -rf ${KATALOG}_Tmp
else
 usage ${0}
fi


exit 0
