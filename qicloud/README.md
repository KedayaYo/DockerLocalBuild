
### MySQL 8.0+ 使用 Navicat 会出现链接失败的情况，可以使用下面方式修改后再连接。
#### 报错信息：
`docker 2059 - Authentication plugin 'caching_sha2_password' cannot be loaded: dlope`

#### 解决方案：
1. 在 MySQL 容器启动的情况下，执行 `docker exec -it mysql /bin/bash` 命令进入容器内。
2. 在 MySQL 容器内执行 `mysql -uroot -p` 命令进入 MySQL 服务。
3. 执行 `select user,host,plugin,authentication_string from mysql.user ;` 命令查询用户信息。
4. 如果 user=root and host=% and plugin=caching_sha2_password 的记录存在，则继续执行修改。
5. 修改用户身份验证插件，则执行 `ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mysql_3306';`。
6. 重新使用 Navicat 进行 MySQL 数据库连接。

ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mysql_3306';


ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'SkySysGo2022';





[mysqld]
#Mysql服务的唯一编号 每个mysql服务Id需唯一
server-id=1

#服务端口号 默认3306
port=3306

#mysql安装根目录（default /usr）
#basedir=/usr/local/mysql

#mysql数据文件所在位置
datadir=/var/lib/mysql

#pid
pid-file=/var/run/mysqld/mysqld.pid

#设置socke文件所在目录
socket=/var/lib/mysql/mysql.sock

#设置临时目录
#tmpdir=/tmp

# 用户
user=mysql

# 允许访问的IP网段
bind-address=0.0.0.0

# 跳过密码登录
#skip-grant-tables

#主要用于MyISAM存储引擎,如果多台服务器连接一个数据库则建议注释下面内容
#skip-external-locking

#只能用IP地址检查客户端的登录，不用主机名
#skip_name_resolve=1

#事务隔离级别，默认为可重复读，mysql默认可重复读级别（此级别下可能参数很多间隙锁，影响性能）
#transaction_isolation=READ-COMMITTED

#数据库默认字符集,主流字符集支持一些特殊表情符号（特殊表情符占用4个字节）
character-set-server=utf8mb4

#数据库字符集对应一些排序等规则，注意要和character-set-server对应
collation-server=utf8mb4_general_ci

#设置client连接mysql时的字符集,防止乱码
init_connect='SET NAMES utf8mb4'

#是否对sql语句大小写敏感，1表示不敏感
lower_case_table_names=1

#最大连接数
max_connections=400

#最大错误连接数
max_connect_errors=1000

#TIMESTAMP如果没有显示声明NOT NULL，允许NULL值
explicit_defaults_for_timestamp=true

#SQL数据包发送的大小，如果有BLOB对象建议修改成1G
max_allowed_packet=128M

#MySQL连接闲置超过一定时间后(单位：秒)将会被强行关闭
#MySQL默认的wait_timeout  值为8个小时, interactive_timeout参数需要同时配置才能生效
interactive_timeout=1800
wait_timeout=1800

#内部内存临时表的最大值 ，设置成128M。
#比如大数据量的group by ,order by时可能用到临时表，
#超过了这个值将写入磁盘，系统IO压力增大
tmp_table_size=134217728
max_heap_table_size=134217728

#禁用mysql的缓存查询结果集功能
#后期根据业务情况测试决定是否开启
#大部分情况下关闭下面两项
#query_cache_size = 0
#query_cache_type = 0
 
#数据库错误日志文件
#log-error=/var/log/mysqld.log

#慢查询sql日志设置
#slow_query_log=1
#slow_query_log_file=/var/log/mysqld_slow.log

#检查未使用到索引的sql
log_queries_not_using_indexes=1

#针对log_queries_not_using_indexes开启后，记录慢sql的频次、每分钟记录的条数
log_throttle_queries_not_using_indexes=5

#作为从库时生效,从库复制中如何有慢sql也将被记录
log_slow_slave_statements=1

#慢查询执行的秒数，必须达到此值可被记录
long_query_time=8

#检索的行数必须达到此值才可被记为慢查询
min_examined_row_limit=100

#mysql binlog日志文件保存的过期时间，过期后自动删除
#expire_logs_days=5
binlog_expire_logs_seconds=604800