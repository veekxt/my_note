## My vps config note ( debian9 )

总体上，我需要配置：
- mysql
- web: /HfuuShop
- web: /
- web: /nextcloud
- web: TLS
- v2ray

### 基本工具&配置
```
apt update;apt upgrade
apt install vim git curl wget zsh htop
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git config --global user.name "veekxt"
git config --global user.email "veekxt@gmail.com"
```

### SSH
```
端口配置：

vim /etc/ssh/sshd_config
systemctl restart ssh

免密码登录(client)

ssh-keygen -t rsa -b 4096 -C "veekxt@gmail.com"
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 10091 root@back.veekxt.com
```

### MySQL
```
apt install mysql-server
mysql -u root
use mysql;
update user set authentication_string=password('some_string_password') where user='root';
update user set host = '%' where user = 'root';
update user set plugin='mysql_native_password';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
flush privileges;
vim /etc/mysql/mysql.conf.d/mysqld.cnf #注释 bind-address, 添加 lower_case_table_names = 1
systemctl restart mysql
```

### tomcat
```
apt install tomcat8
apt install tomcat8-admin
cd /etc/tomcat8/
vim tomcat-users.xml #添加<role rolename="manager-gui"/><user username="tomcat" password="4296527mu" roles="manager-gui"/>
systemctl restart tomcat8
```

### flask

```
apt install python3-pip
pip3 install pip3 install Flask Flask-Bootstrap Flask-Login Flask-Mail Flask-Script Flask-SQLAlchemy Flask-WTF
apt-get install python3-mysqldb

mkdir /veekxt
cd /veekxt
git clone git@github.com:veekxt/my_site.git

# 添加到/etc/rc.local

export VSECRET_KEY="jshdfluigsofiu"
export MAIL_USERNAME="veekxt@gmail.com"
export MAIL_PASSWORD="42965273gg"
export VDATABASE="mysql://root:4296527mvms@localhost:3306/my_site"

cd /veekxt/my_site/
gunicorn -b0.0.0.0:9016 --user=root main:app -D

# 运行

systemctl enable rc-local
reboot

```

## nextcloud
```
apt-get install apache2 mariadb-server libapache2-mod-php7.0 php7.0-gd php7.0-json php7.0-mysql php7.0-curl php7.0-mbstring php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip
cd /var/www
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

## v2ray
```
bash <(curl -L -s https://install.direct/go.sh)
systemctl enable v2ray
```

## TLS
```
https://lolico.moe/tutorial/acme-le-wc.html
and nginx config

tomcat :
vim /etc/tomcat8/server.xml

      <Connector port="44300" protocol="HTTP/1.1"
                 connectionTimeout="20000"
                 redirectPort="443" proxyPort="443" maxHttpHeaderSize="8192" />

```

##