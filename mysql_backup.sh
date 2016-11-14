#!/bin/bash  
  
#备份保存路径  
backup_dir=/home/chehlling/mysql_backup_dir
#日期  
dd=`date +%Y%m%d-%H:%M`  
#备份工具  
tool=mysqldump  
#用户名  
username=root  
#密码  
password=******  
#将要备份的数据库  
database_name=(information_schema RUNOOB mysql test)  
  
for db in ${database_name[*]}
do
$tool -u$username -p$password $db --skip-lock-tables > $backup_dir/$db-$dd.sql  
tar czvf $backup_dir/$db-$dd.sql.tar.gz $backup_dir/$db-$dd.sql

rm $backup_dir/$db-$dd.sql
  
#写创建备份日志  
echo "create `echo "$backup_dir/$db-$dd.sql.tar.gz"|cut -d "/" -f 4- `" >> $backup_dir/log.txt  

#按文件更改时间来查找文件，-n指n天以内，+n指n天以前
#find path -mtim [-n +n] [-print] [-exec -ok command] {} \; 
#按文件访问时间来查
#find path -atime -n +n  
#按文件创建时间来查找文件
#find path -ctime -n +n
find $backup_dir -mtime +7 -name "*.sql.tar.gz" -exec rm -rf {} \;
done
