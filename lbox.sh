#! /bin/sh 

#LBox for NP2300

lbox=$(dirname $0)
cd $lbox

exec &> /tmp/LBox
echo "LBox 安装器"

case $(./qmsgbox 11 "安装(升级)" "卸载" "脚本" 0 -1 "LBox" "LBox安装程序") in
0)

sleep 1s
clear > /dev/tty0
echo -e "\n\n\n\n\n\n\n\n" > /dev/tty0

logi=$lbox/log/install.log

logi() { echo $1 >> $logi ;}
echoline() { echo "---------------" ;}
running()
{
case $running in
'\') running='/' ; echo -en "\b$running" > /dev/tty0;;
'/') running='-' ; echo -en "\b$running" > /dev/tty0;;
'-') running='\' ; echo -en "\b$running" > /dev/tty0;;
*) running='/' ; echo -en "\b$running" > /dev/tty0;;
esac
}

running
echoline
echo "rm..."
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
;;
1)
cd script/remove
for s in $(ls)
do
./${s}
done
cd ../../

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
fi
;;
2)
case $(./qmsgbox 11 "安装" "卸载" "退出" 0 2 "LBox" "安装/卸载脚本") in
0)
cd script/install
for s in $(ls)
do
./${s}
done
cd ../../
;;
1)
cd script/remove
for s in $(ls)
do
./${s}
done
cd ../../
;;
esac
;;
*) exit ;;
esac

sleep 1s
cat /tmp/LBox | iconv -f gb2312 -t utf-8 > /tmp/LBox.html
helpbrowser /tmp/LBox.html
rm /tmp/LBox.html /tmp/LBox