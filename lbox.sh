#! /bin/sh 

#LBox for NP2300

lbox=$(dirname $0)
cd $lbox

msg=./qmsgbox


log=$lbox/log/install.log
[ ! -d "$(dirname $log)" ]&&mkdir -p "$(dirname $log)"

#安装文件#
inst_file()
{
sleep 1s
clear > /dev/tty0
echo -e "\n\n\n\n\n\n\n\n" > /dev/tty0

log() { echo $1 >> $log ;}

title()
{
echo "---------------"
echo $1
echo "---------------"
}

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
title "Remove..."

for rf in $([ -f $log ]&&cat $log)
do
  rfa=$(echo $rf|sed 's#/opt/lbox#lbox#g')
  rfb=$(echo $rf|sed 's#/opt/QtPalmtop#qpe#g')
  [ ! -d $rf ] && { [ -f ./${rfa} -o -f ./${rfb} ]||{ rm $rf ; echo "rm $rf" ;} ;}
  [ -d $rf ] && { [ -d ./${rfa} -o -d ./${rfb} ]||{ rm -r $rf ; echo "rm $rf" ;} ;}
  running
done

echo -e "\b33% Done." > /dev/tty0

[ -f $log ]&&rm $log

inst()
{
[ ! -d $2 ]&&mkdir -p $2
for inst_file in $(ls $1)
do
  if [ -d $1/$inst_file ];then
    inst "$1/$inst_file" "$2/$inst_file"
  else
    if [ ! -f $2/$inst_file ];then
      echo "Install $2/$inst_file"
      cp "$1/$inst_file" "$2/$inst_file"
    else
      if [ -n "$( diff -q "$1/$inst_file" "$2/$inst_file" )" ];then
        echo "Upgrade $2/$inst_file"
        cp  $1/$inst_file $2/$inst_file
      else
        echo "Skip $2/$inst_file"
      fi
    fi
  log "$2/$inst_file"
  fi
  running
done
log $2
}

title "Install/Upgrade(lbox)"
inst lbox /opt/lbox

echo -e "\b66% Done." > /dev/tty0

cd qpe
for d in apps2 apps/5Tool bin data lib pics
do
  title "Install/Upgrade ${d}(qpe)"
  inst $d /opt/QtPalmtop/$d
done
cd ..

echo -e "\b100% Done." > /dev/tty0
}
#END#

#卸载文件#
rm_file()
{
if [ -f $log ];then
  for file in $(cat $log)
  do
    if [ -f $file ];then
      rm $file
      echo "Remove $file"
    elif [ -d $file ];then
      if [ ! -n "$(ls -A $file)" ];then
        rm -r $file
        echo "Rmdir $file"
      else
        echo "Skip $file (目录非空)"
      fi
    else
      echo "Skip $file (无此文件)"
    fi
  done
  rm $log
fi
}
#END#

#安装脚本#
inst_script()
{
cd script/install
for s in $(ls)
do
./${s}
done
cd ../../
}
#END#

#卸载脚本#
rm_script()
{
cd script/remove
for s in $(ls)
do
./${s}
done
cd ../../
}
#END#

exec &> /tmp/LBox

echo "LBox 安装器"

case $($msg 11 "安装" "卸载" "升级" 0 -1 "LBox" "LBox安装程序") in
0)
[ "$($msg 12 "继续" "取消" "" 0 1 "LBox" "确认安装?
(如果您已安装LBox,
请不要继续,以防止未知错误.)")" = 1 ]&&exit
inst_file
inst_script
;;
1)
[ "$($msg 12 "继续" "取消" "" 0 1 "LBox" "确认卸载?
(如果您未安装LBox,
请不要继续,以防止未知错误.)")" = 1 ]&&exit
rm_script
rm_file
;;
2)
[ "$($msg 12 "继续" "取消" "" 0 1 "LBox" "确认升级?
(如果您未安装LBox,
请不要继续,以防止未知错误.)")" = 1 ]&&exit
rm_script
inst_file
inst_script
;;
*)
exit 
;;
esac

sleep 1s
cat /tmp/LBox | iconv -f gb2312 -t utf-8 > /tmp/LBox.html
helpbrowser /tmp/LBox.html
rm /tmp/LBox.html /tmp/LBox