# 修改MySQL数据库的字符编码方法（为了支持emoji表情等特殊字符）

## 一种稳妥且安全的方式：备份再导入
通过mysqldump工具导出数据，修改编码之后再次导入的方法，方便快捷。
1. 先备份数据库  
> mysqldump -h localhost -u username -p -B db | sed 's/AUTO_INCREMENT=[0-9]*\s//g' > db.sql
2. 修改数据库的字符编码，如果mysql server端默认字符编码非utf8mb4时，需要停服修改mysql server端字符编码
3. 重新导入数据库

## 升级utf8到utf8mb4
1. 备份
安全第一，备份所有需要升级字符编码的数据库
可以将库dump出来
如果是虚拟机，可以给整个主机做快照

2. 升级
utf8mb4是MySQL5.5.3版本之后支持的字符集，so，如果你需要使用这个字符集，前提条件是你的MySQL版本必须 >= 5.5.3

3. 修改
在MySQL中，可以为一个database设置字符编码，可以为一张表设置字符编码，甚至可以为某一个字段设置字符编码

3.1 查看当前系统默认的字符集设置
确保数据库服务器的编码是utf8mb4；如果不是，就必须重启数据库服务器才行（也即无法online变更）
>SHOW VARIABLES LIKE 'character%';
MySQL [(none)]> show variables like '%chara%';
+--------------------------+----------------------------------+
| Variable_name            | Value                            |
+--------------------------+----------------------------------+
| character_set_client     | utf8mb4                          |
| character_set_connection | utf8mb4                          |
| character_set_database   | utf8mb4                          |
| character_set_filesystem | binary                           |
| character_set_results    | utf8mb4                          |
| character_set_server     | utf8mb4                          |
| character_set_system     | utf8                             |
| character_sets_dir       | /usr/local/mysql/share/charsets/ |
+--------------------------+----------------------------------+
8 rows in set (0.00 sec)

3.2 查看database的字符编码
>SHOW CREATE DATABASE wine;
MySQL [(none)]> show create database wine;
+----------+------------------------------------------------------------------+
| Database | Create Database                                                  |
+----------+------------------------------------------------------------------+
| wine     | CREATE DATABASE `wine` /*!40100 DEFAULT CHARACTER SET utf8mb4 */ |
+----------+------------------------------------------------------------------+
1 row in set (0.00 sec)

3.3 修改database的字符编码
>ALTER DATABASE database_name CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
但是，要注意：虽然修改了database的字符集为utf8mb4，但是实际只是修改了database新创建的表，默认使用utf8mb4，原来已经存在的表，字符集并没有跟着改变，需要手动为每张表设置字符集

3.4 查看table的字符编码
>SHOW CREATE TABLE user;

3.5 修改table的字符编码
- 只修改表默认的字符集 
> ALTER TABLE table_name DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
- 修改表默认的字符集和所有字符列的字符集
> ALTER TABLE table_name CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

3.6 查看column的字符编码
>SHOW FULL COLUMNS FROM user;

3.7 修改column的字符编码
> ALTER TABLE table_name CHANGE column_name column_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

4. 修复&优化所有数据表
> mysqlcheck -u root -p --auto-repair --optimize --all-databases

