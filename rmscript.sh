#! /bin/sh

#LBox for NP2300

lbox=$(dirname $0)
cd $lbox
[ $(./qmsgbox 11 "NEXT" "" "" 0 -1 "UNINSTALL" "RUN UNINSTALL Script") != 0 ]&&exit

clear > /dev/tty0
echo -e "\n\n\n\n\n\n\n\nRunning..." > /dev/tty0
exec &> /tmp/LBox

echo "LBox °²×°Æ÷"
cd script/remove
for s in $(ls)
do
./${s}
done
cd ../../

cat /tmp/LBox | iconv -f gb2312 -t utf-8 > /tmp/LBox.html
helpbrowser /tmp/LBox.html
rm /tmp/LBox.html /tmp/LBox