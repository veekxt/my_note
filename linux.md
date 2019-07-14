重复文件检测
```
find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
```

常用date
```
# 2011-12-08 11:09

date "+%G-%m-%d %H-%M"

# 2011-12-08 11:09:13

date "+%G-%m-%d %X"
```
生成系统tags
```
ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S  -R -f ~/.vim/systags /opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/usr/include
```
ubuntu 查找文件所在包
```
apt-file search xxxx.so.1
```
ubuntu 修复引导
```
sudo add-apt-repository ppa:yannubuntu/boot-repair && sudo apt-get update

sudo apt-get install -y boot-repair

sudo boot-repair
```
查看gcc预定义宏
```
gcc -E -dM - < /dev/null
```
svn删除未跟踪文件
```
svn st | grep '^?' | awk '{print $2}' | xargs rm -rf
```
pip升级所有包
```
pip freeze --local | grep -v '^-e' | cut -d = -f 1  | xargs -n1 pip install -U
```
clone all my reps
```
curl -s https://api.github.com/users/veekxt/repos | grep \"ssh_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 proxychains git clone
```
换行符（win -> linux）转换(递归)
```
find . -type f -print0 | xargs -0 dos2unix
```
disable ssh hot key
```
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
LogLevel QUIET
```
backup system
```
rsync -aAXv --delete --exclude={"/dev/*","/ext/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*/.thumbnails/*","/home/*/.cache/*","/home/*/.local/share/Trash/*","/home/*/.gvfs","/home/*/Nextcloud/*"} / /ext/arch_backup
```
creat ap
```
create_ap wlp3s0 wlp3s0 MyAccessPoint 44442222 --freq-band 2.4
```
7zip
```
7zr a -r -mx=4 folder.zip folder 
```
统计文件(夹)数量
```
find ./ | wc -l
find ./ -type f | wc -l
find ./ -type d | wc -l
```
