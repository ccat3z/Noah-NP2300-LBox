#! /bin/sh

#LBox for NP2300

lbox=$(dirname $0)
cd $lbox
[ $(./qmsgbox 11 "NEXT" "" "" 0 -1 "INSTALL" "INSTALL") != 0 ]&&exit

clear > /dev/tty0
echo -e "\n\n\n\n\n\n\n\nRunning..." > /dev/tty0
exec &> /tmp/LBox

echo "LBox °²×°Æ÷"

logi=$lbox/log/install.log

logi() { echo $1 >> $logi ;}
echoline() { echo "---------------" ;}
running()
{
case $running in
'/') running='\' ; echo -en "\b$running" > /dev/tty0;;
'\') running='-' ; echo -en "\b$running" > /dev/tty0;;
'-') running='/' ; echo -en "\b$running" > /dev/tty0;;
*) running='/' ; echo -en "\b$running" > /dev/tty0;;
esac
}

running
echoline
echo "rm rmfile"
echoline
for rf in $([ -f $logi ]&&cat $logi)
do
  rfa=$(echo $rf|sed "s#/opt/lbox/#lbox/#g")
  rfb=$(echo $rf|sed "s#/opt/QtPalmtop/#qpe/#g")
  [ ! -d $rf ] && { [ -f ./${rfa} -o -f ./${rfb} ]||{ rm $rf ; echo "rm $rf" ;} ;}
  [ -d $rf ] && { [ -d ./${rfa} -o -d ./${rfb} ]||{ rm -r $rf ; echo "rm $rf" ;} ;}
  running
done

echo -e "\b33% Done." > /dev/tty0
[ -f $logi ]&&mv -f $logi ${logi}.old

idir()
{
[ ! -d $2 ]&&mkdir -p $2
for f in $(ls $1)
do
  if [ -d $1/$f ];then
    dir="$2/$f"
    idir $1/$f $2/$f
    logi $dir
  else
  if [ ! -f $2/$f ];then
    echo "install $2/$f"
    cp -d $1/$f $2/$f
  else
  if [ -n "$( diff -q "$1/$f" "$2/$f" )" ];then
    echo "upgrade $2/$f"
    cp -d $1/$f $2/$f
  else
    echo "skip $2/$f"
  fi
  fi
  logi "$2/$f"
  fi
  running
done
}

cd lbox
for d in apps apps2 bin data lib pics share
do
  echoline
  echo "install/upgrade $d(lbox)"
  echoline
  idir $d /opt/lbox/$d
  echo
done
cd ..
echo -e "\b66% Done." > /dev/tty0

cd qpe
for d in apps2 apps/5Tool bin data lib pics
do
  echoline
  echo "install/upgrade ${d}(qpe)"
  echoline
  idir $d /opt/QtPalmtop/$d
  echo
done
cd ..
echo -e "\b100% Done." > /dev/tty0

cat /tmp/LBox | iconv -f gb2312 -t utf-8 > /tmp/LBox.html
helpbrowser /tmp/LBox.html
rm /tmp/LBox.html /tmp/LBox