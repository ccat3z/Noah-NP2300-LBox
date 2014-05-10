---
layout:         index_architect
---
##!!!注意!!!安装v2.0.2版本的请在安装目录下创建log文件夹,否则无法正确卸载/升级.(最新版已解决此问题)

这一个拓展工具包..目前只用3个功能..陆续添加中  
具体不多说 基本每周更新一次  
暂时取名LBox..以后会和iTool Box for NP2300合并  

##安装方法
将安装文件复制到储存卡中,  
执行lbox.sh 选择"安装",  
重启即可.  
注意保留log文件夹(安装记录),script文件夹(卸载脚本)及lbox.sh(卸载程序)  

##卸载方法
将log文件夹和script文件夹与lbox.sh复制到同一目录下中,  
执行lbox.sh 选择"卸载",  
重启即可.  

##升级方法
将log文件夹和script文件夹与lbox.sh复制到同一目录下中,  
执行lbox.sh 选择"卸载",  
重启即可.   

##功能简介
###命令执行器
执行本地磁盘/工具/记事本/c.txt  
保存的执行结果在储存卡/命令.txt  
拓展选项使用方法:  
在本地磁盘/工具/记事本/c.txt中加入选项  
以'#+'为开头,程序会自动读取  
e.g.  
`#+viewer=ebook iconv=utf-8TOgbk`  
支持的选项:  
1:`viewer=qt|ebook|html|tty`  
说明:用QT对话框(默认),电子书,Helpbrowser,TTY查看执行结果  
2:`iconv=输入编码TO输出编码`  
说明:将执行结果从输入{编码转换}到{输出编码}  

###虚拟终端
这个...从Qtopia中移植过来  
不支持中文..  
上方图标:新标签页-打开键盘-打开输入窗口-TAB-ESC-ESC-粘贴  

###拓展后台
改进版的后台  
连按两下HOME键可打开后台拓展  
按下结束后台..其余功能正在开发中   

##截图
暂无  

##论坛地址
[阿诺论坛](http://club.noahedu.com/forum.php?mod=viewthread&tid=137399)


