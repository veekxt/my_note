rsync -aAXv --delete --exclude={"/dev/*","/ext/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*/.thumbnails/*","/home/*/.cache/*","/home/*/.local/share/Trash/*","/home/*/.gvfs","/home/*/Nextcloud/*"} / /ext/arch_backup