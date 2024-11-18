-- 创建数据库
CREATE DATABASE  `qicloud_private` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use qicloud_private;
source /opt/sql/qicloud_private_init.sql;

use mysql;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mysql_3306';
