#!/bin/bash

#sudo -S service ssh --full-restart << EOF
#x
#EOF

nohup /usr/bin/simage -c -p 44228 -t "veekxt.com:44229" -k "xietao is a good man" >/dev/null 2>&1 &

service ssh --full-restart

service mysql start

service cron start

#sudo service dbus start  #ssh will slow !!!

#nohup /usr/bin/v2ray/v2ray -config /etc/v2ray/config.json &

#nohup /usr/bin/v2ray/v2ray -config /etc/v2ray/config.json >/dev/null 2>&1 &

#nohup /usr/bin/v2ray/v2ray -config /mnt/c/soft/v2ray-v3.38-windows-64/config.json >/dev/null 2>&1 &


