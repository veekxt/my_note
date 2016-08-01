重复文件检测

find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate

常用date

\# 2011-12-08 11:09
date +%G-%m-%d %H-%M
