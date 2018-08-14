#!/bin/bash

#sudo -S service ssh --full-restart << EOF
#x
#EOF

service ssh --full-restart

service mysql start

service cron start

/usr/bin/v2ray/v2ray -config /etc/v2ray/config.json

