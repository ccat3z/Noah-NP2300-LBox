#! /bin/sh

#LBox for NP2300


lbox=$(dirname $0)
cd $lbox
[ $(./qmsgbox 11 "NEXT" "" "" 0 -1 "UNINSTALL" "UNINSTALL") != 0 ]&&exit

echo -e "\n\nRunning..." > /dev/tty0
exec &> /tmp/LBox


echo "LBox °²×°Æ÷"


logi=$lbox/log/install.log
logr=$lbox/log/remove.log

logr() { echo $1 >> $logr ;}


if [ -f $logi ];then
  [ -f $logr ]&&mv -f $logr ${logr}.old
  for file in $(cat $logi)
  do
    if [ -f $file -o -d $file ];then
      rm -r $file
      echo "rm $file"
      logr $file
    fi
  done
  mv -f $logi ${logi}.old
else
  echo "No Install"
fi

cat /tmp/LBox | iconv -f gb2312 -t utf-8 > /tmp/LBox.html
helpbrowser /tmp/LBox.html
rm /tmp/LBox.html /tmp/LBox