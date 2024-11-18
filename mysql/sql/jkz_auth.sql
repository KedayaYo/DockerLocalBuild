/*
 Navicat Premium Data Transfer

 Source Server         : 小分队测试服务
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : 101.34.229.221:3306
 Source Schema         : jkz_auth

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 30/06/2023 23:03:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ali_domain_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `ali_domain_oss_config`;
CREATE TABLE `ali_domain_oss_config` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `DOMAIN_NAME` varchar(255) DEFAULT NULL COMMENT '播流域名',
  `IS_CONFIG` int DEFAULT '0' COMMENT '是否配置视频录制(0表示未配置,1表示已配置)',
  `OSS_ENDPOINT` varchar(255) DEFAULT NULL COMMENT 'OSS域名',
  `OSS_BUCKET` varchar(255) DEFAULT NULL COMMENT 'Bucket名称',
  `REGION_ID` varchar(64) DEFAULT NULL COMMENT '可用区ID',
  `STATUS` int DEFAULT NULL COMMENT '状态',
  `CREATE_USER_NAME` varchar(64) DEFAULT NULL COMMENT '创建人姓名',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER_NAME` varchar(64) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for ali_video_record_info
-- ----------------------------
DROP TABLE IF EXISTS `ali_video_record_info`;
CREATE TABLE `ali_video_record_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `VIDEO_TYPE` varchar(32) DEFAULT NULL COMMENT '视频类型(ch表示第一视角,cam表示第三视角,in表示内视视角)',
  `DOMAIN_NAME` varchar(255) DEFAULT NULL COMMENT '录制域名',
  `APP_NAME` varchar(255) DEFAULT NULL COMMENT '应用名',
  `STREAM_NAME` varchar(255) DEFAULT NULL COMMENT '流名称',
  `DURATION` decimal(32,0) DEFAULT NULL COMMENT '视频时长',
  `MISSION_BATCH` varchar(30) NOT NULL COMMENT '任务批次号',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `STATUS` int DEFAULT NULL COMMENT '状态(0无效,1有效)',
  `VIDEO_URI` varchar(255) DEFAULT NULL COMMENT '视频URI',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  `UAV_START_TIME` datetime DEFAULT NULL COMMENT '无人机开始时间',
  `UAV_END_TIME` datetime DEFAULT NULL COMMENT '无人机降落时间',
  `ST_ID` varchar(30) DEFAULT NULL COMMENT '站点编号',
  `REMARK` text COMMENT '备注',
  PRIMARY KEY (`ID`,`MISSION_BATCH`) USING BTREE,
  UNIQUE KEY `missionBatch` (`MISSION_BATCH`) USING BTREE COMMENT 'missionBatch唯一标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for ali_video_record_oss_config_info
-- ----------------------------
DROP TABLE IF EXISTS `ali_video_record_oss_config_info`;
CREATE TABLE `ali_video_record_oss_config_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `DOMAIN_NAME` varchar(255) DEFAULT NULL COMMENT '播流域名',
  `APP_NAME` varchar(255) DEFAULT NULL COMMENT '应用名',
  `STREAM_NAME` varchar(255) DEFAULT NULL COMMENT '流名称',
  `IS_CONFIG` int DEFAULT '0' COMMENT '是否配置视频录制(0表示未配置,1表示已配置)',
  `OSS_ENDPOINT` varchar(255) DEFAULT NULL COMMENT 'OSS域名',
  `OSS_BUCKET` varchar(255) DEFAULT NULL COMMENT 'Bucket名称',
  `REGION_ID` varchar(64) DEFAULT NULL COMMENT '可用区ID',
  `ST_ID` varchar(30) DEFAULT NULL COMMENT '站点编号',
  `STATUS` int DEFAULT NULL COMMENT '状态',
  `CREATE_USER_NAME` varchar(64) DEFAULT NULL COMMENT '创建人姓名',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER_NAME` varchar(64) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for ftp_station_config
-- ----------------------------
DROP TABLE IF EXISTS `ftp_station_config`;
CREATE TABLE `ftp_station_config` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ST_ID` varchar(30) DEFAULT NULL COMMENT '站点编号',
  `HOST_NAME` varchar(32) DEFAULT NULL COMMENT 'ftp地址',
  `PORT` int DEFAULT NULL COMMENT 'ftp端口号',
  `USER_NAME` varchar(255) DEFAULT NULL COMMENT 'ftp用户名',
  `PASSWORD` varchar(255) DEFAULT NULL COMMENT 'ftp密码',
  `BASE_PATH` varchar(255) DEFAULT NULL COMMENT 'ftp根目录地址',
  `IS_DELETE` int DEFAULT '0' COMMENT '逻辑删除 1删除',
  `PROTOCOL` varchar(255) DEFAULT NULL COMMENT '协议(参数:FTP 或者FTPS)',
  `ENCRYPTION` varchar(255) DEFAULT NULL COMMENT '加密方式(参数:show 显示加密  implicit 隐式加密)',
  `CHARACTER_STR` varchar(255) DEFAULT NULL COMMENT '字符集(默认:UTF-8)',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `ST_ID` (`ST_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for media_ftp_scan_log
-- ----------------------------
DROP TABLE IF EXISTS `media_ftp_scan_log`;
CREATE TABLE `media_ftp_scan_log` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ST_ID` varchar(16) DEFAULT NULL COMMENT '站点编号',
  `UAV_ID` varchar(32) DEFAULT NULL COMMENT '无人机编号',
  `MEDIA_DATE` datetime DEFAULT NULL COMMENT '媒体文件日期',
  `MISSION_BATCH` varchar(32) DEFAULT NULL COMMENT '任务批次号',
  `MEDIA_TYPE` varchar(32) DEFAULT NULL COMMENT '媒体文件类型(photo,video)',
  `SCAN_STATUES` varchar(16) DEFAULT NULL COMMENT '文件处理结果状态(A自动处理;M手动处理;U未处理)',
  `EXCEPT_INFO` varchar(255) DEFAULT NULL COMMENT '扫描结果异常',
  `FILE_URL` varchar(255) DEFAULT NULL COMMENT '原始文件路径',
  `FILE_NAME` varchar(64) DEFAULT NULL COMMENT '原始文件名称',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER_ID` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(64) DEFAULT NULL COMMENT '创建人姓名',
  `METHOD_NAME` varchar(255) DEFAULT NULL COMMENT '方法名',
  `REQUEST_PARAMS` varchar(255) DEFAULT NULL COMMENT '请求参数',
  `BAK_URL` varchar(255) DEFAULT NULL COMMENT '备份路径',
  `COPY_URL` varchar(255) DEFAULT NULL COMMENT '整理路径',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for oss_config_info
-- ----------------------------
DROP TABLE IF EXISTS `oss_config_info`;
CREATE TABLE `oss_config_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ENDPOINT` varchar(32) DEFAULT NULL COMMENT '域名地址',
  `BUCKET_NAME` varchar(255) DEFAULT NULL COMMENT 'oss仓库地址',
  `ACCESS_KEY_ID` varchar(255) DEFAULT NULL COMMENT '密钥',
  `SECRET_ACCESS_KEY` varchar(255) DEFAULT NULL COMMENT '密码',
  `BASE_PATH` varchar(255) DEFAULT NULL COMMENT '根目录地址',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for project_info
-- ----------------------------
DROP TABLE IF EXISTS `project_info`;
CREATE TABLE `project_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PNum` varchar(15) NOT NULL,
  `PName` varchar(35) NOT NULL,
  `country` varchar(30) DEFAULT '',
  `provinces` varchar(10) DEFAULT NULL COMMENT '省份',
  `city` varchar(20) DEFAULT NULL COMMENT '城市',
  `chargePerson` varchar(20) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createUser` varchar(20) NOT NULL,
  `updateTime` timestamp NULL DEFAULT NULL,
  `updateUser` varchar(20) DEFAULT NULL,
  `chargeCorporation` varchar(100) DEFAULT NULL,
  `isDelete` tinyint DEFAULT '0',
  `deploymentMode` tinyint DEFAULT NULL,
  `projectAddress` varchar(100) DEFAULT NULL,
  `AMID` smallint DEFAULT NULL,
  `cp_id` varchar(64) DEFAULT NULL COMMENT '企业唯一编号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_approval_task_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_approval_task_info`;
CREATE TABLE `sky_approval_task_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TASK_ID` varchar(255) DEFAULT NULL COMMENT '任务编号',
  `TASK_NAME` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `TASK_DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `TASK_STATUS` int DEFAULT NULL COMMENT '任务状态(0 待审批  1 审批已通过  2审批未通过)',
  `APPROVAL_OPINIONS` varchar(255) DEFAULT NULL COMMENT '审批意见',
  `APPROVAL_USER_ID` varchar(15) DEFAULT NULL COMMENT '审批人编号',
  `APPROVAL_USER_NAME` varchar(64) DEFAULT NULL COMMENT '审批人姓名',
  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '任务审批时间',
  `PARENT_TASK_ID` varchar(255) DEFAULT NULL COMMENT '父工单ID,没有父工单,该字段为0',
  `IS_EXIST_CHILD_TASK` int DEFAULT NULL COMMENT '是否存在子工单,0不存在,1存在',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人编号',
  `CREATE_USER_NAME` varchar(64) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '任务创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_approval_task_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_approval_task_role_relation`;
CREATE TABLE `sky_approval_task_role_relation` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TASK_ID` varchar(255) DEFAULT NULL COMMENT '审批任务编号',
  `ROLE_ID` varchar(15) DEFAULT NULL COMMENT '角色编号',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人姓名',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_approval_task_station_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_approval_task_station_relation`;
CREATE TABLE `sky_approval_task_station_relation` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TASK_ID` varchar(255) DEFAULT NULL COMMENT '审批任务编号',
  `CP_ID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `P_ID` varchar(15) DEFAULT NULL COMMENT '项目编号',
  `ST_ID` varchar(30) DEFAULT NULL COMMENT '站点编号',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人姓名',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_corporation_customization
-- ----------------------------
DROP TABLE IF EXISTS `sky_corporation_customization`;
CREATE TABLE `sky_corporation_customization` (
  `ID` int NOT NULL,
  `CP_ID` varchar(64) NOT NULL COMMENT '企业编号',
  `SYSTEM_ICON` varchar(255) DEFAULT NULL COMMENT '系统icon',
  `SYSTEM_NAME` varchar(64) DEFAULT NULL COMMENT '系统名称',
  `CREATE_USER` varchar(30) NOT NULL COMMENT '创建人',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `UPDATE_USER` varchar(30) NOT NULL COMMENT '创建人',
  `UPDATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_corporation_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_corporation_info`;
CREATE TABLE `sky_corporation_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CP_ID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `CP_NAME` varchar(255) DEFAULT NULL COMMENT '企业名称',
  `CP_NUM` varchar(24) DEFAULT NULL COMMENT '公司统一征信码',
  `CP_ADDRESS` varchar(255) DEFAULT NULL COMMENT '公司联系地址',
  `CP_PHONE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业联系电话',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `SYSTEM_ICON` varchar(255) DEFAULT NULL COMMENT '系统icon',
  `SYSTEM_NAME` varchar(64) DEFAULT NULL COMMENT '系统名称',
  `STATUS` int DEFAULT '1' COMMENT '状态(0 禁用,1启用)',
  `IS_TRIAL` int DEFAULT NULL COMMENT '是否试用(1试用,0非试用)',
  `EFFECTIVE_DATE` datetime DEFAULT NULL COMMENT '试用截止日期',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_corporation_invite_code_record
-- ----------------------------
DROP TABLE IF EXISTS `sky_corporation_invite_code_record`;
CREATE TABLE `sky_corporation_invite_code_record` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `INVITE_CODE` varchar(32) DEFAULT NULL COMMENT '邀请码',
  `CP_ID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `FAILURE_TIME` timestamp NULL DEFAULT NULL COMMENT '失效时间',
  `IS_VALID` int DEFAULT NULL COMMENT '是否生效 1生效  0失效',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) NOT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_gateway_monitor_log
-- ----------------------------
DROP TABLE IF EXISTS `sky_gateway_monitor_log`;
CREATE TABLE `sky_gateway_monitor_log` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `REQUEST_URL` varchar(1000) DEFAULT NULL COMMENT '请求路径',
  `USER_ID` varchar(15) DEFAULT NULL COMMENT '用户编号',
  `USER_NAME` varchar(64) DEFAULT NULL COMMENT '用户名',
  `USER_IP` varchar(255) DEFAULT NULL COMMENT '访问系统用户IP',
  `USER_MAC` varchar(255) DEFAULT NULL COMMENT '访问系统用户MAC地址',
  `REQUEST_PARAMS` varchar(4000) DEFAULT NULL COMMENT '请求参数',
  `REQUEST_METHODS` varchar(15) DEFAULT NULL COMMENT '请求方法',
  `REQUEST_HEADERS` varchar(9000) DEFAULT NULL COMMENT '登录模块  web  App等',
  `LOGIN_TYPE` varchar(64) DEFAULT NULL COMMENT '登录类型,用户名密码,手机验证码等',
  `REMARK` varchar(1000) DEFAULT NULL COMMENT '备注',
  `LOG_TIME` datetime DEFAULT NULL COMMENT '日志发生时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_media_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `sky_media_operation_log`;
CREATE TABLE `sky_media_operation_log` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `OPERATION_TYPE` int DEFAULT NULL COMMENT '操作类型  1新建文件夹  2复制文件  3删除文件',
  `OPERATION_PARAMS` blob COMMENT '操作参数',
  `OPERATION_SUCCESS` int DEFAULT NULL COMMENT '操作结果,是否成功  0失败 1成功',
  `OPERATION_RESULT` blob COMMENT '操作结果返回字符串',
  `OPERATION_USER_ID` varchar(255) DEFAULT NULL COMMENT '操作用户编码',
  `OPERATION_USER_NAME` varchar(255) DEFAULT NULL COMMENT '操作用户名称',
  `OPERATION_TIME` datetime DEFAULT NULL COMMENT '操作时间',
  `CP_ID` varchar(64) DEFAULT NULL COMMENT '企业唯一编号',
  `P_ID` varchar(15) DEFAULT NULL COMMENT '项目编号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_menu_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_menu_info`;
CREATE TABLE `sky_menu_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MENU_ID` varchar(15) NOT NULL COMMENT '菜单ID',
  `MENU_NAME` varchar(32) NOT NULL COMMENT '菜单名称',
  `MENU_LEVEL` int NOT NULL COMMENT '菜单层级',
  `MENU_BELONG` varchar(32) DEFAULT NULL COMMENT '菜单所属 （1表示公共菜单）',
  `MENU_ICON` varchar(255) NOT NULL DEFAULT '' COMMENT '菜单icon',
  `MENU_URL` varchar(255) NOT NULL COMMENT '菜单URL',
  `IS_VALID` int NOT NULL COMMENT '是否生效 1为有效  0为失效',
  `PARENT_MENU_ID` varchar(15) DEFAULT NULL COMMENT '父级菜单ID',
  `SORT` int DEFAULT NULL COMMENT '排序',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `COMPONENT` varchar(255) DEFAULT NULL COMMENT '菜单组件',
  `REDIRECT` varchar(255) DEFAULT NULL COMMENT '路由重定向',
  `HIDDEN` int DEFAULT NULL COMMENT '是否隐藏菜单',
  `HIDDEN_PARENT` int DEFAULT NULL COMMENT '是否隐藏父级菜单',
  `COMPONENT_NAME` varchar(255) DEFAULT NULL COMMENT '组件名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_menu_info_20230524
-- ----------------------------
DROP TABLE IF EXISTS `sky_menu_info_20230524`;
CREATE TABLE `sky_menu_info_20230524` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MENU_ID` varchar(15) NOT NULL COMMENT '菜单ID',
  `MENU_NAME` varchar(32) NOT NULL COMMENT '菜单名称',
  `MENU_LEVEL` int NOT NULL COMMENT '菜单层级',
  `MENU_BELONG` varchar(32) DEFAULT NULL COMMENT '菜单所属 (1表示公共菜单)',
  `MENU_ICON` varchar(255) NOT NULL DEFAULT '' COMMENT '菜单icon',
  `MENU_URL` varchar(255) NOT NULL COMMENT '菜单URL',
  `IS_VALID` int NOT NULL COMMENT '是否生效 1为有效  0为失效',
  `PARENT_MENU_ID` varchar(15) DEFAULT NULL COMMENT '父级菜单ID',
  `SORT` int DEFAULT NULL COMMENT '排序',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `COMPONENT` varchar(255) DEFAULT NULL COMMENT '菜单组件',
  `REDIRECT` varchar(255) DEFAULT NULL COMMENT '路由重定向',
  `HIDDEN` int DEFAULT NULL COMMENT '是否隐藏菜单',
  `HIDDEN_PARENT` int DEFAULT NULL COMMENT '是否隐藏父级菜单',
  `COMPONENT_NAME` varchar(255) DEFAULT NULL COMMENT '组件名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_menu_module_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_menu_module_info`;
CREATE TABLE `sky_menu_module_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `MODULE_ID` varchar(16) NOT NULL COMMENT '模块编号',
  `MODULE_NAME` varchar(255) DEFAULT NULL COMMENT '模块名称',
  `MODULE_DESC` varchar(1000) DEFAULT NULL COMMENT '模块描述',
  `MENU_ID` varchar(15) NOT NULL COMMENT '菜单ID',
  `MODULE_BELONG` varchar(32) DEFAULT NULL COMMENT '模块所属 (1表示公共模块)',
  `SORT` int DEFAULT NULL COMMENT '排序',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `IS_DELETE` tinyint(1) DEFAULT NULL COMMENT '逻辑删除  0 已删除  1未删除',
  `PARENT_MODULE_ID` varchar(16) DEFAULT NULL COMMENT '父模块编号',
  `MODULE_LEVEL` int DEFAULT NULL COMMENT '模块级别',
  PRIMARY KEY (`ID`,`MODULE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_mission_media_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_mission_media_file_info`;
CREATE TABLE `sky_mission_media_file_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MISSION_BATCH` varchar(50) NOT NULL COMMENT '任务批次号',
  `FTP_ADDR` varchar(64) DEFAULT NULL COMMENT 'FTP服务器地址',
  `FTP_FLOADER` varchar(255) DEFAULT NULL COMMENT '任务批次号绝对路径',
  `PICTURE_NUM` int DEFAULT NULL COMMENT '本次飞行图片数量',
  `VIDEO_NUM` int DEFAULT NULL COMMENT '本次飞行视频数量',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `FTP_PORT` int DEFAULT NULL COMMENT 'FTP服务器端口',
  `FTP_USERNAME` varchar(64) DEFAULT NULL COMMENT 'FTP服务器登录用户名',
  `FTP_PASSWORD` varchar(64) DEFAULT NULL COMMENT 'FTP服务器登录密码',
  `STORAGE_TYPE` int DEFAULT NULL COMMENT '存储库类型 1 OSS 2 FTP',
  `BUKET_NAME` varchar(255) DEFAULT NULL COMMENT '存储空间',
  `ENDPOINT` varchar(255) DEFAULT NULL COMMENT '访问域名',
  `ACCESS_KEY_ID` varchar(255) DEFAULT NULL COMMENT '访问密钥key',
  `SECRET_ACCESS_KEY` varchar(255) DEFAULT NULL COMMENT '访问密钥secret',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_mission_media_file_record
-- ----------------------------
DROP TABLE IF EXISTS `sky_mission_media_file_record`;
CREATE TABLE `sky_mission_media_file_record` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MISSION_BATCH` varchar(50) NOT NULL COMMENT '任务批次号',
  `MEDIA_TYPE` varchar(12) DEFAULT NULL COMMENT '文件类型   photo  图片   video 视频',
  `MEDIA_URL` varchar(1000) DEFAULT NULL COMMENT '文件路径',
  `MEDIA_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `MEDIA_VIEW_TYPE` varchar(15) DEFAULT NULL COMMENT '文件类型 ',
  `ABSOLUTE_ALTITUDE` double(255,6) DEFAULT NULL COMMENT '拍摄点绝对高度',
  `RELATIVE_ALTITUDE` double(255,6) DEFAULT NULL COMMENT '拍摄点相对高度',
  `SHOOT_POSITION` varchar(255) DEFAULT NULL COMMENT '拍摄点位置',
  `MEDIA_FILE_SIZE` double(255,0) DEFAULT NULL COMMENT '媒体文件大小,单位KB',
  `REMARK` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RESOLUTION` varchar(255) DEFAULT NULL COMMENT '分辨率',
  `TAKE_PHOTO_TIME` varchar(255) DEFAULT NULL COMMENT '图片拍摄时间',
  `IS_DELETE` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_role_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_role_info`;
CREATE TABLE `sky_role_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ROLE_ID` varchar(15) NOT NULL COMMENT '角色ID',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `IS_VALID` int NOT NULL DEFAULT '1' COMMENT '是否生效 1为生效 0为失效',
  `VALID_LEVEL` int NOT NULL DEFAULT '1' COMMENT '生效层级 1全部生效  2为项目级用户有效',
  `IS_UNIQUE` int NOT NULL DEFAULT '0' COMMENT '是否唯一 1表示唯一  0表示可以有多个',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) NOT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_role_menu_relation`;
CREATE TABLE `sky_role_menu_relation` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ROLE_ID` varchar(15) NOT NULL COMMENT '角色ID',
  `MENU_ID` varchar(15) NOT NULL COMMENT '菜单ID',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人姓名',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_role_menu_relation_0524
-- ----------------------------
DROP TABLE IF EXISTS `sky_role_menu_relation_0524`;
CREATE TABLE `sky_role_menu_relation_0524` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ROLE_ID` varchar(15) NOT NULL COMMENT '角色ID',
  `MENU_ID` varchar(15) NOT NULL COMMENT '菜单ID',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人姓名',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for sky_role_module_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_role_module_relation`;
CREATE TABLE `sky_role_module_relation` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `ROLE_ID` varchar(15) NOT NULL COMMENT '角色ID',
  `MODULE_ID` varchar(16) NOT NULL COMMENT '模块编号',
  `CREATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_share_page_record
-- ----------------------------
DROP TABLE IF EXISTS `sky_share_page_record`;
CREATE TABLE `sky_share_page_record` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '用户编号',
  `MISSION_BATCH` varchar(255) DEFAULT NULL COMMENT '任务批次号',
  `SHARE_ID` varchar(64) DEFAULT NULL COMMENT '分享链接唯一编号',
  `SHARE_URL` varchar(255) DEFAULT NULL COMMENT '分享链接',
  `IS_DELETE` tinyint(1) DEFAULT NULL COMMENT '是否删除 1删除 ',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER_ID` varchar(64) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_sms_verify_record
-- ----------------------------
DROP TABLE IF EXISTS `sky_sms_verify_record`;
CREATE TABLE `sky_sms_verify_record` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PHONE_NUM` varchar(11) NOT NULL COMMENT '电话号码',
  `SMS_TEMPLATE_TYPE` varchar(20) NOT NULL COMMENT 'register 注册短信模板  login   登陆短信模板',
  `SMS_VERIFY_CODE` int NOT NULL COMMENT '短信验证码',
  `SEND_STATUS` tinyint(1) NOT NULL COMMENT '0 发送失败   1发送成功',
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `SEND_TIME` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_system_message_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_system_message_info`;
CREATE TABLE `sky_system_message_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `MSG_ID` varchar(16) DEFAULT NULL COMMENT '信息编号 M_00001',
  `TITLE` varchar(64) DEFAULT NULL COMMENT '主题编号',
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '消息内容',
  `MSG_TYPE` int DEFAULT NULL COMMENT '消息类型   1 权限审批',
  `IS_DELETE` tinyint(1) DEFAULT NULL COMMENT '逻辑删除  0 已删除  1未删除',
  `CREATE_USER_ID` varchar(30) NOT NULL COMMENT '创建人编号',
  `CREATE_USER_NAME` varchar(30) DEFAULT NULL COMMENT '创建人姓名',
  `UPDATE_USER_ID` varchar(30) DEFAULT NULL COMMENT '更新人编号',
  `UPDATE_USER_NAME` varchar(30) DEFAULT NULL COMMENT '更新人姓名',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_task_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_task_info`;
CREATE TABLE `sky_task_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TASK_ID` varchar(64) DEFAULT NULL COMMENT '任务编号',
  `TASK_NAME` varchar(128) DEFAULT NULL COMMENT '任务名称',
  `MISSION_ID` varchar(64) DEFAULT NULL COMMENT '航线编码',
  `SITE_ID` varchar(64) DEFAULT NULL COMMENT '站点编号',
  `UAV_ID` varchar(64) DEFAULT NULL COMMENT '无人机编号',
  `SITE_NAME` varchar(255) DEFAULT NULL COMMENT '站点名称',
  `UAV_START_ALTITUDE` float DEFAULT NULL COMMENT '无人机起飞高度',
  `GLOBAL_CRUISE_ALTITUDE` float DEFAULT NULL COMMENT '全局巡航高度',
  `GLOBAL_CRUISE_SPEED` float DEFAULT NULL COMMENT '全局巡航速度',
  `LOST_EXITS_TASK` tinyint DEFAULT NULL COMMENT '失联是否退出任务  0不退出  1退出',
  `TO_FIRST_POINT_MODE` tinyint DEFAULT NULL COMMENT '去往第一航点的模式  1斜飞   2拉高',
  `EXECUTE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '执行人用户名',
  `EXECUTE_USER_ID` varchar(15) DEFAULT NULL COMMENT '执行人用户编码',
  `STATUS` tinyint DEFAULT NULL COMMENT '状态（0 未发布 1未执行 2执行中 3 已执行）',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人用户名',
  `CREATE_TIME` datetime(6) NOT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人用户名',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `MiSSION_NAME` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `EXECUTE_TIME` datetime(6) DEFAULT NULL COMMENT '执行任务时间',
  `IS_DELETE` tinyint DEFAULT NULL COMMENT '是否删除',
  `MISSION_BATCH` varchar(50) DEFAULT NULL COMMENT '任务批次号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for sky_user_corporation_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_corporation_relation`;
CREATE TABLE `sky_user_corporation_relation` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(15) NOT NULL COMMENT '用户iD',
  `CP_ID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `CREATE_USER` varchar(30) NOT NULL COMMENT '创建人',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_user_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_info`;
CREATE TABLE `sky_user_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `USER_ID` varchar(15) NOT NULL COMMENT '用户id',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `USER_PASSWORD` varchar(255) DEFAULT NULL COMMENT '密码',
  `IDCARD_NAME` varchar(256) DEFAULT NULL COMMENT '真实姓名',
  `IDCARD_NUM` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `USER_MOBILE` varchar(15) DEFAULT NULL COMMENT '手机号',
  `USER_AVATER` varchar(255) DEFAULT NULL COMMENT '图像信息',
  `USER_EMAIL` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `USER_TYPE` int DEFAULT NULL COMMENT '用户类型 1-个人用户 2-企业用户',
  `IS_VALID` int unsigned NOT NULL DEFAULT '1' COMMENT '是否生效 1为有效 0为失效',
  `CP_ID` varchar(20) DEFAULT NULL COMMENT '用户所属企业ID',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人名称',
  `CREATE_TIME` datetime(6) NOT NULL COMMENT '创建时间',
  `UPDATE_USER_ID` varchar(15) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_USER_NAME` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `UPDATE_TIME` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `NICK_NAME` varchar(255) DEFAULT NULL COMMENT '绑定微信名称',
  `OPEN_ID` varchar(255) DEFAULT NULL COMMENT '微信唯一标识',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_login_log`;
CREATE TABLE `sky_user_login_log` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LOG_CONTENT` varchar(1000) DEFAULT NULL COMMENT '日志内容',
  `USER_ID` varchar(15) DEFAULT NULL COMMENT '用户编号',
  `USER_NAME` varchar(64) DEFAULT NULL COMMENT '用户名',
  `USER_IP` varchar(255) DEFAULT NULL COMMENT '访问系统用户IP',
  `USER_MAC` varchar(255) DEFAULT NULL COMMENT '访问系统用户MAC地址',
  `FUNC_URL` varchar(255) DEFAULT NULL COMMENT '访问功能路径',
  `LOGIN_MODE` varchar(64) DEFAULT NULL COMMENT '登录模块  web  App等',
  `LOGIN_TYPE` varchar(64) DEFAULT NULL COMMENT '登录类型,用户名密码,手机验证码等',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  `LOG_TIME` datetime DEFAULT NULL COMMENT '日志发生时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_user_message_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_message_relation`;
CREATE TABLE `sky_user_message_relation` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `MSG_ID` varchar(16) DEFAULT NULL COMMENT '信息编号',
  `STATUS` int DEFAULT NULL COMMENT '0 未读  1已读',
  `NOTICE_USER_ID` varchar(30) DEFAULT NULL COMMENT '消息通知人编号',
  `NOTICE_USER_NAME` varchar(30) DEFAULT NULL COMMENT '消息通知人名称',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `IS_DELETE` tinyint(1) DEFAULT NULL COMMENT '逻辑删除  0 已删除  1未删除',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_user_project_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_project_relation`;
CREATE TABLE `sky_user_project_relation` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `USER_ID` varchar(15) NOT NULL COMMENT '用户ID',
  `PID` varchar(15) NOT NULL COMMENT '项目num  Pnum',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人姓名',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `IS_EXPIRE` int unsigned DEFAULT '0' COMMENT '是否试用到期(1到期,0未到期)',
  PRIMARY KEY (`ID`),
  KEY `idx_user_id` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for sky_user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_role_relation`;
CREATE TABLE `sky_user_role_relation` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `USER_ID` varchar(15) NOT NULL COMMENT '用户ID',
  `ROLE_ID` varchar(15) NOT NULL COMMENT '角色ID',
  `CREATE_USER_ID` varchar(15) NOT NULL COMMENT '创建人ID',
  `CREATE_USER_NAME` varchar(255) NOT NULL COMMENT '创建人姓名',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `IS_EXPIRE` int unsigned DEFAULT '0' COMMENT '是否试用到期(1到期,0未到期)',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `userId` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_user_station_relation
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_station_relation`;
CREATE TABLE `sky_user_station_relation` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(15) NOT NULL COMMENT '用户ID',
  `ST_ID` varchar(30) NOT NULL COMMENT '站点编号',
  `CREATE_USER` varchar(30) NOT NULL COMMENT '创建人',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `IS_EXPIRE` int unsigned DEFAULT '0' COMMENT '是否试用到期(1到期,0未到期)',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sky_user_station_relation_test
-- ----------------------------
DROP TABLE IF EXISTS `sky_user_station_relation_test`;
CREATE TABLE `sky_user_station_relation_test` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(15) NOT NULL COMMENT '用户ID',
  `ST_ID` varchar(20) NOT NULL COMMENT '站点编号',
  `CREATE_USER` varchar(30) NOT NULL COMMENT '创建人',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for station_info
-- ----------------------------
DROP TABLE IF EXISTS `station_info`;
CREATE TABLE `station_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STID` varchar(15) NOT NULL COMMENT '站点编号',
  `SName` varchar(30) NOT NULL,
  `SAddress` varchar(50) DEFAULT NULL,
  `hiveID` varchar(20) DEFAULT NULL,
  `UAVID` varchar(30) DEFAULT NULL,
  `PNum` varchar(15) DEFAULT NULL,
  `SAltitude` float(7,2) DEFAULT '0.00',
  `SWorkingZone` multipoint DEFAULT NULL,
  `isDelete` tinyint(1) NOT NULL DEFAULT '0',
  `chargePerson` varchar(25) DEFAULT NULL,
  `createUser` varchar(25) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateUser` varchar(25) DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL,
  `latWGS` double(20,15) DEFAULT NULL,
  `lonWGS` double(20,15) DEFAULT NULL,
  `SSafeLocation` geometry DEFAULT NULL,
  `SOptionLocation` geometry DEFAULT NULL,
  `SLocation` geometry DEFAULT NULL,
  `UAVVideoID` varchar(30) DEFAULT NULL,
  `HIVEVideoID` varchar(30) DEFAULT NULL,
  `SUAVRHAltitude` float(5,2) DEFAULT NULL,
  `VideoPushDoM` varchar(50) DEFAULT NULL,
  `VideoPullDoM` varchar(50) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `MSDKMode` tinyint(1) DEFAULT '0',
  `deploymentMode` tinyint(1) DEFAULT NULL,
  `bgUrl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `SID_INDEX` (`STID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user_socketioauths_info
-- ----------------------------
DROP TABLE IF EXISTS `user_socketioauths_info`;
CREATE TABLE `user_socketioauths_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` varchar(30) NOT NULL,
  `accessKeyId` varchar(20) NOT NULL,
  `accessKeySecret` varchar(255) NOT NULL,
  `connectCount` smallint NOT NULL DEFAULT '1',
  `namespace` varchar(20) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL,
  `createUser` varchar(30) DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL,
  `updateUser` varchar(30) DEFAULT NULL,
  `isDelete` tinyint(1) DEFAULT '0',
  `type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
