## My vps config note ( debian9 )

总体上，我需要配置：
- mysql
- web: /hfuu_shop
- web: /
- web: /nextcloud
- web: TLS

### 基本工具&配置
```
wget https://raw.githubusercontent.com/veekxt/util_note/master/.vimrc -O ~/.vimrc
apt update;apt upgrade
apt install vim git curl wget zsh htop tree aria2 haveged nginx
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
git config --global user.name "veekxt"
git config --global user.email "veekxt@gmail.com"
```

### SSH
```
端口配置：

允许root登录
PermitRootLogin yes

vim /etc/ssh/sshd_config
systemctl restart ssh

免密码登录(client)

ssh-keygen -t rsa -b 4096 -C "veekxt@gmail.com"
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 10091 root@back.veekxt.com

1小时不掉线

ClientAliveInterval 60
ClientAliveCountMax 60

生成新key
ssh-keygen -t rsa -b 4096 -C "veekxt@gmail.com"

```

### MySQL
```
apt install mariadb-server
mysql -u root
use mysql;
update user set authentication_string=password('some_string_password') where user='root';
update user set host = '%' where user = 'root';
update user set plugin='mysql_native_password';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
flush privileges;
vim /etc/mysql/mysql.conf.d/mysqld.cnf #注释 bind-address, 添加 lower_case_table_names = 1
performance_schema=OFF #大幅降低内存占用

systemctl restart mysql

backup

mysqldump -uroot -p --databases my_site >/tmp/md.txt
```

### tomcat
```
apt install tomcat9 tomcat9-admin
 

vim /etc/tomcat9/tomcat-users.xml #添加<role rolename="manager-gui"/><user username="tomcat" password="some-string" roles="manager-gui"/>
systemctl restart tomcat8
```

### flask

```
apt install python3-pip python3-mysqldb
pip3 install commonmark Flask Flask-Login Flask-Mail Flask-Script Flask-SQLAlchemy Flask-WTF commonmark gunicorn mysqlclient


mkdir /veekxt
cd /veekxt
git clone git@github.com:veekxt/my_site.git

vim /usr/lib/systemd/system/gunicorn.service
写入

[Unit]
Description=gunicorn daemon
After=network.target
[Service]
PIDFile=/run/gunicorn/pid
User=root
RuntimeDirectory=gunicorn
WorkingDirectory=/veekxt/my_site
ExecStart=env VDATABASE='mysql://root:pass@localhost:3306/my_site' gunicorn -b0.0.0.0:9016 --user=root main:app
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s TERM $MAINPID
PrivateTmp=true
[Install]
WantedBy=multi-user.target


# 运行
systemctl enable gunicorn
systemctl start gunicorn

```

## nextcloud
```
apt install apache2 libapache2-mod-php php-gd php-json php-mysql php-curl php-mbstring php-intl php-imagick php-xml php-zip
cd /var/www
go to https://nextcloud.com/install/#instructions-server
wget https://download.nextcloud.com/server/releases/nextcloud-13.0.5.tar.bz2
tar -xjf nextcloud-13.0.5.tar.bz2
vim /etc/apache2/sites-available/nextcloud.conf

chown -R www-data:www-data /var/www/nextcloud/


# 添加

Alias /nextcloud "/var/www/nextcloud/"

<Directory /var/www/nextcloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/nextcloud
 SetEnv HTTP_HOME /var/www/nextcloud

</Directory>

ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/nextcloud.conf

a2enmod rewrite
a2enmod headers
a2enmod env
a2enmod dir
a2enmod mime

# 更改端口
vim /etc/apache2/ports.conf
vim /etc/apache2/sites-enabled/000-default.conf

service apache2 restart

```

## TLS
```

https://lolico.moe/tutorial/acme-le-wc.html

curl https://get.acme.sh | sh

获取阿里云API
https://ak-console.aliyun.com/#/accesskey

export Ali_Key=""
export Ali_Secret=""

申请证书
~/.acme.sh/acme.sh --issue --dns dns_ali -d veekxt.com -d '*.veekxt.com'
查看
ll ~/.acme.sh/veekxt.com

copy nginx.conf to new vps

tomcat (do not config this, just use http):
vim /etc/tomcat9/server.xml

      <Connector port="44300" protocol="HTTP/1.1"
                 connectionTimeout="20000"
                 redirectPort="443" proxyPort="443" maxHttpHeaderSize="8192" />
     添加
          <Valve className="org.apache.catalina.valves.RemoteIpValve"
                       remoteIpHeader="x-forwarded-for"
                        remoteIpProxiesHeader="x-forwarded-by"
                        protocolHeader="x-forwarded-proto" />
     到<HOST>

# useless if use https to config
nextcloud:
vim /var/www/nextcloud/config/config.php
add:
  'trusted_proxies'   => ['127.0.0.1'],
  'overwritehost'     => 'veekxt.com',
  'overwriteprotocol' => 'https',
  'overwritewebroot'  => '/nextcloud',
  'overwritecondaddr' => '^127\.0\.0\.1$',

```

check:

https://veekxt.com  
http://veekxt.com/hfuu_shop  
https://veekxt.com/nextcloud  


