重复文件检测

find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate

常用date

\# 2011-12-08 11:09

date "+%G-%m-%d %H-%M"

\# 2011-12-08 11:09:13

date "+%G-%m-%d %X"

生成系统tags

ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S  -R -f ~/.vim/systags /opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/usr/include

ubuntu 查找文件所在包

apt-file search xxxx.so.1

ubuntu 修复引导

sudo add-apt-repository ppa:yannubuntu/boot-repair && sudo apt-get update

sudo apt-get install -y boot-repair

sudo boot-repair
