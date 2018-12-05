
创建文件夹

curl -u xietao:somepass -X MKCOL "https://veekxt.com/nextcloud/remote.php/dav/files/xietao/$(date '+%d-%b-%Y')"

上传文件

curl -u xietao:somepass -T simage "https://veekxt.com/nextcloud/remote.php/dav/files/xietao/$(date '+%d-%b-%Y')/simage"