/*
 Navicat Premium Data Transfer

 Source Server         : 小分队测试服务
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : 101.34.229.221:3306
 Source Schema         : jkz_fcs

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 30/06/2023 23:02:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ftp_station_config
-- ----------------------------
DROP TABLE IF EXISTS `ftp_station_config`;
CREATE TABLE `ftp_station_config` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ST_ID` varchar(32) NOT NULL DEFAULT '' COMMENT '站点编号',
  `HOST_NAME` varchar(32) DEFAULT NULL COMMENT 'ftp地址',
  `PORT` int DEFAULT NULL COMMENT 'ftp端口号',
  `USER_NAME` varchar(255) DEFAULT NULL COMMENT 'ftp用户名',
  `PASSWORD` varchar(255) DEFAULT NULL COMMENT 'ftp密码',
  `BASE_PATH` varchar(255) DEFAULT NULL COMMENT 'ftp根目录地址',
  `IS_DELETE` int DEFAULT '0' COMMENT '逻辑删除 1删除',
  `PROTOCOL` varchar(32) DEFAULT NULL COMMENT '协议(参数:FTP 或者FTPS)',
  `ENCRYPTION` varchar(32) DEFAULT NULL COMMENT '加密方式(参数:show 显示加密  implicit 隐式加密)',
  `CHARACTER_STR` varchar(32) DEFAULT NULL COMMENT '字符集(默认:UTF-8)',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `ST_ID` (`ST_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点FTP配置信息表';

-- ----------------------------
-- Table structure for private_video_record_info
-- ----------------------------
DROP TABLE IF EXISTS `private_video_record_info`;
CREATE TABLE `private_video_record_info` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `VIDEO_TYPE` varchar(32) DEFAULT NULL COMMENT '视频类型(ch表示第一视角,cam表示第三视角,in表示内视视角)',
  `DURATION` decimal(20,0) DEFAULT NULL COMMENT '视频时长',
  `MISSION_BATCH` varchar(32) DEFAULT NULL COMMENT '任务批次号',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `STATUS` int DEFAULT NULL COMMENT '状态(0无效,1有效)',
  `VIDEO_URI` varchar(255) DEFAULT NULL COMMENT '视频URI',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `MISSION_BATCH` (`MISSION_BATCH`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='历史视频记录表';

-- ----------------------------
-- Table structure for sky_mission_media_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sky_mission_media_file_info`;
CREATE TABLE `sky_mission_media_file_info` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MISSION_BATCH` varchar(64) NOT NULL COMMENT '任务批次号',
  `FTP_ADDR` varchar(64) DEFAULT NULL COMMENT 'FTP服务器地址',
  `FTP_FLOADER` varchar(255) DEFAULT NULL COMMENT '任务批次号绝对路径',
  `PICTURE_NUM` int DEFAULT NULL COMMENT '本次飞行图片数量',
  `VIDEO_NUM` int DEFAULT NULL COMMENT '本次飞行视频数量',
  `CREATE_USER_ID` varchar(32) DEFAULT NULL COMMENT '创建人ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务成果信息表';

-- ----------------------------
-- Table structure for sky_mission_media_file_record
-- ----------------------------
DROP TABLE IF EXISTS `sky_mission_media_file_record`;
CREATE TABLE `sky_mission_media_file_record` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MISSION_BATCH` varchar(64) NOT NULL COMMENT '任务批次号',
  `MEDIA_TYPE` varchar(32) DEFAULT NULL COMMENT '文件类型   photo  图片   video 视频',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务成果文件明细表';

-- ----------------------------
-- Table structure for tb_UAV_1685410158389_202306
-- ----------------------------
DROP TABLE IF EXISTS `tb_UAV_1685410158389_202306`;
CREATE TABLE `tb_UAV_1685410158389_202306` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '''序号''',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `createUser` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '操作人',
  `creatorID` int NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `updatorID` int DEFAULT NULL COMMENT '操作人ID',
  `missionBatch` varchar(64) NOT NULL,
  `missionID` varchar(32) NOT NULL,
  `UAVID` varchar(32) NOT NULL,
  `SDRemainingCapacity` int NOT NULL,
  `waypointIndex` int NOT NULL,
  `GPSCount` tinyint NOT NULL,
  `GPSLevel` tinyint(1) NOT NULL,
  `SN` varchar(32) NOT NULL,
  `aliveTime` int NOT NULL,
  `altitude` float(5,2) NOT NULL,
  `azimuth` int NOT NULL,
  `batteryPercentGH` int DEFAULT NULL,
  `cellular` int DEFAULT NULL,
  `channel` int DEFAULT NULL,
  `compassState` tinyint(1) DEFAULT NULL,
  `distanceStart` double DEFAULT NULL,
  `downLink` int DEFAULT NULL,
  `upLink` int DEFAULT NULL,
  `flightMode` varchar(40) DEFAULT NULL,
  `flightTime` int DEFAULT NULL,
  `frequency` tinyint(1) DEFAULT NULL,
  `gimbalPitch` int DEFAULT NULL,
  `gimbalRoll` int DEFAULT NULL,
  `gimbalYaw` int DEFAULT NULL,
  `horizontalSpeed` float(5,2) DEFAULT NULL,
  `verticalSpeed` float(5,2) DEFAULT NULL,
  `isGSOnline` tinyint(1) DEFAULT NULL,
  `isOSDKAvailable` tinyint(1) DEFAULT NULL,
  `isUAVOnline` tinyint(1) DEFAULT NULL,
  `isSocketConnected` tinyint(1) DEFAULT NULL,
  `isRecording` tinyint(1) DEFAULT NULL,
  `latitudeWGS` double(15,8) DEFAULT NULL,
  `latitudeHomeGCJ` double(15,8) DEFAULT NULL,
  `longitudeHomeGCJ` double(15,8) DEFAULT NULL,
  `longitudeWGS` double(15,8) DEFAULT NULL,
  `missionName` varchar(32) DEFAULT NULL,
  `model` varchar(32) DEFAULT NULL,
  `osdkHeartBeatCode` int DEFAULT NULL,
  `remainingBatteryTime` int DEFAULT NULL,
  `state` int DEFAULT NULL,
  `subState` int DEFAULT NULL,
  `timestamp` varchar(32) DEFAULT NULL,
  `timestampUTC` bigint DEFAULT NULL,
  `versionCode` int DEFAULT NULL,
  `versionName` varchar(32) DEFAULT NULL,
  `zoom` float(5,2) DEFAULT NULL,
  `hdmiMode` tinyint DEFAULT NULL,
  `cameraNum` int DEFAULT NULL,
  `displayMode` tinyint DEFAULT NULL,
  `displayModeConfig` tinyint DEFAULT NULL,
  `vfov` float(5,2) DEFAULT NULL,
  `hfov` float(5,2) DEFAULT NULL,
  `cameraType` varchar(32) DEFAULT NULL,
  `theIT2AT` float(5,2) DEFAULT NULL,
  `theIDATRMax` float(5,2) DEFAULT NULL,
  `theIDATRMin` float(5,2) DEFAULT NULL,
  `theIDATLocation` varchar(64) DEFAULT NULL,
  `laserTargetLocation` varchar(64) DEFAULT NULL,
  `launchError` json DEFAULT NULL,
  `djiError` json DEFAULT NULL,
  `launchState` varchar(150) DEFAULT NULL,
  `isGimbalFollow` tinyint(1) DEFAULT NULL,
  `isAisleUse` tinyint(1) DEFAULT NULL,
  `isMotorOn` tinyint(1) DEFAULT NULL,
  `angleArrival` float(5,2) DEFAULT NULL,
  `UAVPitch` int DEFAULT NULL,
  `UAVRoll` int DEFAULT NULL,
  `UAVYaw` int DEFAULT NULL,
  `batteries` json DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for tb_UAV_16869924196929_202306
-- ----------------------------
DROP TABLE IF EXISTS `tb_UAV_16869924196929_202306`;
CREATE TABLE `tb_UAV_16869924196929_202306` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '''序号''',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `createUser` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '操作人',
  `creatorID` int NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `updatorID` int DEFAULT NULL COMMENT '操作人ID',
  `missionBatch` varchar(64) NOT NULL,
  `missionID` varchar(32) NOT NULL,
  `UAVID` varchar(32) NOT NULL,
  `SDRemainingCapacity` int NOT NULL,
  `waypointIndex` int NOT NULL,
  `GPSCount` tinyint NOT NULL,
  `GPSLevel` tinyint(1) NOT NULL,
  `SN` varchar(32) NOT NULL,
  `aliveTime` int NOT NULL,
  `altitude` float(5,2) NOT NULL,
  `azimuth` int NOT NULL,
  `batteryPercentGH` int DEFAULT NULL,
  `cellular` int DEFAULT NULL,
  `channel` int DEFAULT NULL,
  `compassState` tinyint(1) DEFAULT NULL,
  `distanceStart` double DEFAULT NULL,
  `downLink` int DEFAULT NULL,
  `upLink` int DEFAULT NULL,
  `flightMode` varchar(40) DEFAULT NULL,
  `flightTime` int DEFAULT NULL,
  `frequency` tinyint(1) DEFAULT NULL,
  `gimbalPitch` int DEFAULT NULL,
  `gimbalRoll` int DEFAULT NULL,
  `gimbalYaw` int DEFAULT NULL,
  `horizontalSpeed` float(5,2) DEFAULT NULL,
  `verticalSpeed` float(5,2) DEFAULT NULL,
  `isGSOnline` tinyint(1) DEFAULT NULL,
  `isOSDKAvailable` tinyint(1) DEFAULT NULL,
  `isUAVOnline` tinyint(1) DEFAULT NULL,
  `isSocketConnected` tinyint(1) DEFAULT NULL,
  `isRecording` tinyint(1) DEFAULT NULL,
  `latitudeWGS` double(15,8) DEFAULT NULL,
  `latitudeHomeGCJ` double(15,8) DEFAULT NULL,
  `longitudeHomeGCJ` double(15,8) DEFAULT NULL,
  `longitudeWGS` double(15,8) DEFAULT NULL,
  `missionName` varchar(32) DEFAULT NULL,
  `model` varchar(32) DEFAULT NULL,
  `osdkHeartBeatCode` int DEFAULT NULL,
  `remainingBatteryTime` int DEFAULT NULL,
  `state` int DEFAULT NULL,
  `subState` int DEFAULT NULL,
  `timestamp` varchar(32) DEFAULT NULL,
  `timestampUTC` bigint DEFAULT NULL,
  `versionCode` int DEFAULT NULL,
  `versionName` varchar(32) DEFAULT NULL,
  `zoom` float(5,2) DEFAULT NULL,
  `hdmiMode` tinyint DEFAULT NULL,
  `cameraNum` int DEFAULT NULL,
  `displayMode` tinyint DEFAULT NULL,
  `displayModeConfig` tinyint DEFAULT NULL,
  `vfov` float(5,2) DEFAULT NULL,
  `hfov` float(5,2) DEFAULT NULL,
  `cameraType` varchar(32) DEFAULT NULL,
  `theIT2AT` float(5,2) DEFAULT NULL,
  `theIDATRMax` float(5,2) DEFAULT NULL,
  `theIDATRMin` float(5,2) DEFAULT NULL,
  `theIDATLocation` varchar(64) DEFAULT NULL,
  `laserTargetLocation` varchar(64) DEFAULT NULL,
  `launchError` json DEFAULT NULL,
  `djiError` json DEFAULT NULL,
  `launchState` varchar(150) DEFAULT NULL,
  `isGimbalFollow` tinyint(1) DEFAULT NULL,
  `isAisleUse` tinyint(1) DEFAULT NULL,
  `isMotorOn` tinyint(1) DEFAULT NULL,
  `angleArrival` float(5,2) DEFAULT NULL,
  `UAVPitch` int DEFAULT NULL,
  `UAVRoll` int DEFAULT NULL,
  `UAVYaw` int DEFAULT NULL,
  `batteries` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for tb_cron_missions
-- ----------------------------
DROP TABLE IF EXISTS `tb_cron_missions`;
CREATE TABLE `tb_cron_missions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CMID` varchar(32) NOT NULL COMMENT '计划任务ID',
  `missionID` varchar(32) NOT NULL COMMENT '任务ID',
  `missionName` varchar(64) NOT NULL COMMENT '任务模式',
  `mode` tinyint(1) DEFAULT NULL COMMENT '1-一次 2-每天 3-每周 4-每月',
  `min` tinyint DEFAULT NULL COMMENT '分钟',
  `hour` tinyint DEFAULT NULL COMMENT '小时',
  `day` json DEFAULT NULL COMMENT '日',
  `weekDay` json DEFAULT NULL COMMENT '每周星期几',
  `excuteTime` int DEFAULT NULL COMMENT '执行时间',
  `state` tinyint(1) DEFAULT NULL COMMENT '1-未执行 2-生效中 3-已执行',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `isDelete` tinyint(1) DEFAULT NULL,
  `content` text COMMENT '内容',
  `startDate` int DEFAULT NULL COMMENT '生效开始日期',
  `endDate` int DEFAULT NULL COMMENT '生效结束日期',
  `siteID` varchar(32) DEFAULT NULL,
  `day1` json DEFAULT NULL COMMENT '日',
  `weekDay1` json DEFAULT NULL COMMENT '每周星期几',
  `CPID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `createUser` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updateUser` varchar(64) DEFAULT NULL COMMENT '更新者',
  `PLATID` int DEFAULT NULL COMMENT '平台id',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `updatorID` int DEFAULT NULL COMMENT '更信任ID',
  `endSiteID` varchar(32) DEFAULT NULL COMMENT '降落站点ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `CMID` (`CMID`) USING BTREE,
  KEY `missionID` (`missionID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='计划任务信息表';

-- ----------------------------
-- Table structure for tb_cron_missions_works
-- ----------------------------
DROP TABLE IF EXISTS `tb_cron_missions_works`;
CREATE TABLE `tb_cron_missions_works` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CMID` varchar(32) NOT NULL COMMENT '计划任务ID',
  `excuteTime` int NOT NULL COMMENT '执行时间',
  `isDelete` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `isExcute` tinyint DEFAULT NULL COMMENT '是否执行',
  `content` varchar(255) DEFAULT NULL COMMENT '描述',
  `isDisabled` tinyint(1) DEFAULT '0' COMMENT '是否禁止掉1-是 0-否',
  `createUser` varchar(64) DEFAULT NULL,
  `updateUser` varchar(64) DEFAULT NULL,
  `siteID` varchar(32) DEFAULT NULL COMMENT '站点编号',
  `state` tinyint(1) DEFAULT NULL,
  `UAVEXStartTime` varchar(64) DEFAULT NULL,
  `UAVEXEndTime` varchar(64) DEFAULT NULL,
  `endSiteID` varchar(32) DEFAULT NULL COMMENT '降落站点ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `CMID` (`CMID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='计划任务执行明细表';

-- ----------------------------
-- Table structure for tb_device_batteries
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_batteries`;
CREATE TABLE `tb_device_batteries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batterySN` varchar(32) NOT NULL COMMENT '电池SN',
  `brand` varchar(32) NOT NULL COMMENT '无人机生产制造商',
  `model` varchar(32) NOT NULL COMMENT '型号',
  `cycleCount` int NOT NULL DEFAULT '0' COMMENT '电池循环次数',
  `UAVID` varchar(32) DEFAULT NULL COMMENT '绑定当前的无人机编号',
  `createTime` varchar(32) NOT NULL,
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `content` text COMMENT '备注',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0',
  `createUser` varchar(64) DEFAULT NULL,
  `updateUser` varchar(64) DEFAULT NULL,
  `CPID` varchar(64) NOT NULL COMMENT '企业编号',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `creatorID` int DEFAULT NULL,
  `updatorID` int DEFAULT NULL,
  `PLATID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for tb_device_ecs
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_ecs`;
CREATE TABLE `tb_device_ecs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ECID` varchar(32) NOT NULL COMMENT '边缘计算机ID',
  `MAC` char(20) DEFAULT NULL COMMENT 'mac地址xxxxxxxxxxxx',
  `model` varchar(32) NOT NULL COMMENT '型号',
  `system` varchar(255) NOT NULL COMMENT 'android,ubuntn,windows',
  `brand` varchar(255) NOT NULL COMMENT '生产制造商',
  `state` tinyint(1) NOT NULL COMMENT '1-库存,2-使用中,3-报废',
  `lastOnlineTime` varchar(32) NOT NULL COMMENT '最后一次在线时间',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `createTime` varchar(32) NOT NULL COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `remark` text COMMENT '备注',
  `IPAddre` varchar(32) DEFAULT NULL COMMENT 'IP地址',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新人',
  `CPID` varchar(64) NOT NULL COMMENT '企业编号',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `password` varchar(255) DEFAULT NULL COMMENT '边缘计算机登录密码',
  `EName` varchar(64) DEFAULT NULL,
  `siteID` varchar(64) DEFAULT NULL COMMENT '关联的站点编号',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `updatorID` int DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='边缘计算机信息表';

-- ----------------------------
-- Table structure for tb_device_hive_errors
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_hive_errors`;
CREATE TABLE `tb_device_hive_errors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `errorCode` int DEFAULT NULL COMMENT '错误码',
  `errorMsg` varchar(255) DEFAULT NULL COMMENT '错误信息',
  `state` tinyint(1) DEFAULT NULL COMMENT '是否有效 1-是 0-否',
  `content` text CHARACTER SET utf8mb4,
  `createTime` timestamp NULL DEFAULT NULL,
  `createUser` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`errorCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机库错误日志表';

-- ----------------------------
-- Table structure for tb_device_hives
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_hives`;
CREATE TABLE `tb_device_hives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hiveID` varchar(32) NOT NULL COMMENT '机库编号',
  `hiveName` varchar(64) NOT NULL COMMENT '机库名称',
  `hiveType` tinyint(1) NOT NULL COMMENT '机库类型 1-固定机库 2-移动机库',
  `ModelID` int NOT NULL COMMENT '型号ID,模型表外键',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除  0未删除 1已删除',
  `siteID` varchar(32) DEFAULT NULL COMMENT '机库所属站点编号,站点表外键',
  `remark` text COMMENT '备注',
  `hiveFLVURL` varchar(255) DEFAULT NULL COMMENT '内窥视角flv',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 1入库 2在役 3故障 4报废',
  `CPID` varchar(64) NOT NULL COMMENT '企业编号',
  `productTime` varchar(64) DEFAULT NULL COMMENT '出厂时间',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机库信息表';

-- ----------------------------
-- Table structure for tb_device_operate_logs_2023
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_operate_logs_2023`;
CREATE TABLE `tb_device_operate_logs_2023` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `createUser` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '操作人',
  `creatorID` int NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `updatorID` int DEFAULT NULL COMMENT '操作人ID',
  `msgID` varchar(255) NOT NULL,
  `siteID` varchar(64) NOT NULL,
  `deviceID` varchar(32) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `isMission` tinyint(1) NOT NULL,
  `missionBatch` varchar(64) NOT NULL,
  `operateCode` int NOT NULL,
  `message` json DEFAULT NULL,
  `resultCode` int NOT NULL,
  `result` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for tb_device_payloads
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_payloads`;
CREATE TABLE `tb_device_payloads` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `payloadName` varchar(255) NOT NULL COMMENT '负载名称',
  `payloadCode` varchar(64) NOT NULL COMMENT '负载编号',
  `payloadSN` varchar(64) NOT NULL COMMENT '负载出厂SN',
  `payloadType` tinyint NOT NULL COMMENT '负载类型 1相机 2喊话器 3探照灯  4电池 5其他',
  `useStartTime` varchar(64) DEFAULT NULL COMMENT '负载投入使用日期',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除  0已删除 1未删除',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1入库 2在役 3故障 4报废',
  `productTime` varchar(64) DEFAULT NULL COMMENT '出厂时间',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='负载设备信息表';

-- ----------------------------
-- Table structure for tb_device_uavs
-- ----------------------------
DROP TABLE IF EXISTS `tb_device_uavs`;
CREATE TABLE `tb_device_uavs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UAVID` varchar(32) NOT NULL COMMENT '无人机编号',
  `UAVName` varchar(64) NOT NULL COMMENT '无人机名称',
  `modelID` int NOT NULL COMMENT '模型ID,模型表外键',
  `FCSN` varchar(64) NOT NULL COMMENT '无人机飞控SN',
  `SN` varchar(64) NOT NULL COMMENT '无人机机身SN',
  `siteID` varchar(64) DEFAULT NULL COMMENT '站点编号,站点表外键',
  `remark` text COMMENT '备注信息',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除  0未删除 1已删除',
  `UAVFLVURL` varchar(255) DEFAULT NULL COMMENT '第一视角flv地址',
  `flightMileageSum` double(10,2) unsigned DEFAULT '0.00' COMMENT '飞行总里程',
  `flightTimeSum` int DEFAULT '0' COMMENT '飞行总时间',
  `photoSum` int DEFAULT NULL COMMENT '拍照总数量',
  `videoSum` int DEFAULT NULL COMMENT '视频总数量',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `CPID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `insuranceInfo` text COMMENT '保险相关信息',
  `productTime` varchar(64) DEFAULT NULL COMMENT '出厂时间',
  `status` tinyint DEFAULT NULL COMMENT '状态   1入库  2在役  3维修 4废弃',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  `isHaveComputer` tinyint NOT NULL DEFAULT '2' COMMENT '是否配置边缘计算机:1:已配置 2:未配置',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `siteID` (`siteID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='无人机信息表';

-- ----------------------------
-- Table structure for tb_flight_flows
-- ----------------------------
DROP TABLE IF EXISTS `tb_flight_flows`;
CREATE TABLE `tb_flight_flows` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `missionBatch` varchar(32) NOT NULL COMMENT '任务批次号',
  `missionID` varchar(32) NOT NULL COMMENT '任务编号',
  `siteID` varchar(32) NOT NULL COMMENT '起始站编号',
  `UAVID` varchar(32) NOT NULL COMMENT '无人机编号',
  `returnMode` tinyint(1) NOT NULL COMMENT '返航方式 1-起始站 2-其他站',
  `endSiteID` varchar(32) NOT NULL COMMENT '终点站编号',
  `flowState` tinyint(1) NOT NULL COMMENT '流程状态',
  `flowStateInfo` varchar(255) DEFAULT NULL COMMENT '流程状态描述',
  `flowSubState` tinyint DEFAULT NULL COMMENT '流程子状态',
  `flowSubStateInfo` varchar(255) DEFAULT NULL COMMENT '流程子状态描述',
  `UAVStartOffTime` varchar(32) DEFAULT NULL COMMENT '无人机起飞时间',
  `UAVLandTime` varchar(32) DEFAULT NULL COMMENT '无人机降落时间',
  `flightParams` longblob COMMENT '航线任务',
  `missionType` tinyint DEFAULT NULL COMMENT '任务类型',
  `missionSource` tinyint DEFAULT NULL COMMENT '任务源 1-祺云下发,2-祺云定时任务,3-三方平台',
  `missionName` varchar(64) DEFAULT NULL COMMENT '任务名称',
  `CPID` varchar(64) DEFAULT NULL,
  `PID` varchar(32) DEFAULT NULL,
  `excuteTime` int DEFAULT NULL COMMENT '定时任务执行时间',
  `missionStartTime` varchar(32) DEFAULT NULL COMMENT '航线任务开始时间',
  `senceId` int DEFAULT NULL COMMENT '场景类型ID',
  `taskId` int DEFAULT NULL COMMENT '巡检作业类型ID',
  `missionEndTime` varchar(32) DEFAULT NULL COMMENT '航线任务结束时间',
  `isExcute` tinyint(1) DEFAULT NULL COMMENT '是否立即执行 1-是 0-否',
  `missionBatchState` tinyint(1) DEFAULT NULL COMMENT '任务批次状态 0-未执行 1-执行中',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  `startHiveID` varchar(32) DEFAULT NULL COMMENT '起点机库编号',
  `endHiveID` varchar(32) DEFAULT NULL COMMENT '终点机库编号',
  `isDelete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `UAVFlightMileage` double(10,2) DEFAULT NULL COMMENT '无人机飞行总里程',
  `UAVFlightTime` int DEFAULT NULL COMMENT '无人机飞行总时间',
  `params1` varchar(32) DEFAULT NULL COMMENT '备用参数1',
  `siteName` varchar(64) DEFAULT NULL COMMENT '站点名称',
  `UAVStartOffPower` tinyint DEFAULT NULL COMMENT '无人机起飞时电量',
  `UAVLandPower` tinyint DEFAULT NULL COMMENT '无人机着陆时电量',
  `UAVBatCCount` int DEFAULT NULL COMMENT '无人机电池循环次数',
  `landSpot` varchar(64) DEFAULT NULL COMMENT '无人机降落点坐标',
  `CMID` varchar(32) DEFAULT NULL COMMENT '计划任务编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `siteID` (`siteID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='执行中任务记录表';

-- ----------------------------
-- Table structure for tb_flight_schedules
-- ----------------------------
DROP TABLE IF EXISTS `tb_flight_schedules`;
CREATE TABLE `tb_flight_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `missionBatch` varchar(64) NOT NULL COMMENT '任务批次号',
  `missionID` varchar(40) NOT NULL COMMENT '任务ID',
  `missionName` varchar(64) DEFAULT NULL COMMENT '任务名称',
  `siteID` varchar(32) DEFAULT NULL COMMENT '站点ID',
  `siteName` varchar(64) DEFAULT NULL COMMENT '站点名称',
  `UAVID` varchar(32) NOT NULL COMMENT '无人机编号',
  `startHiveID` varchar(32) DEFAULT NULL COMMENT '起点机库编号',
  `endHiveID` varchar(32) DEFAULT NULL COMMENT '终点机库编号',
  `UAVStartTime` varchar(32) DEFAULT NULL COMMENT '无人机起飞时间',
  `UAVEndTime` varchar(32) DEFAULT NULL COMMENT '无人机降落时间',
  `state` tinyint(1) DEFAULT NULL COMMENT '状态  ',
  `finishAction` tinyint(1) DEFAULT NULL COMMENT '完成动作 1自动返航 4终点站',
  `landSpot` varchar(64) DEFAULT NULL COMMENT '降落点',
  `remark` text COMMENT '备注',
  `endSiteID` varchar(32) DEFAULT NULL COMMENT '终点站编号',
  `missionEndTime` varchar(32) DEFAULT NULL COMMENT '航线任务结束时间',
  `UAVFlightMileage` double(10,2) DEFAULT '0.00' COMMENT '无人机飞行里程 -米',
  `UAVFlightTime` int DEFAULT '0' COMMENT '无人机飞行时间 -秒',
  `isDelete` tinyint unsigned DEFAULT '0' COMMENT '是否删除',
  `params1` varchar(10) DEFAULT NULL COMMENT '用于查询飞行报文辅助字段',
  `isAutoCP` tinyint(1) DEFAULT '0' COMMENT '是否自动完成',
  `missionSource` tinyint(1) DEFAULT '1' COMMENT '任务源 1-祺云库立即下发,2-祺云系统计划任务 3-三方平台 默认1',
  `flightParams` longblob COMMENT '三方平台任务存储',
  `CPID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `CMID` varchar(32) DEFAULT NULL COMMENT '计划任务编号',
  `photoSum` int DEFAULT NULL COMMENT '拍照总数量',
  `videoSum` int DEFAULT NULL COMMENT '视频总数量',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(64) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(64) DEFAULT NULL COMMENT '更新用户',
  `UAVStartOffPower` tinyint DEFAULT NULL COMMENT '无人机起飞时电量',
  `UAVLandPower` tinyint DEFAULT NULL COMMENT '无人机着陆时电量',
  `UAVBatCCount` int DEFAULT NULL COMMENT '无人机电池循环次数',
  `isExistResult` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否存在成果  0 不存在  1 存在',
  `senceId` int DEFAULT '0' COMMENT '巡检场景类型ID',
  `taskId` int DEFAULT '0' COMMENT '巡检作业类型ID',
  `missionStartTime` varchar(32) DEFAULT NULL COMMENT '航线任务开始时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `missionBatch_index` (`missionBatch`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='飞行任务历史记录表';

-- ----------------------------
-- Table structure for tb_layer_geometries
-- ----------------------------
DROP TABLE IF EXISTS `tb_layer_geometries`;
CREATE TABLE `tb_layer_geometries` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `layerID` int NOT NULL COMMENT '图层ID',
  `shapeType` tinyint(1) NOT NULL DEFAULT '0' COMMENT '形状类型 1:圆形、2:多边形',
  `circularLoc` json DEFAULT NULL COMMENT '圆形时-圆心坐标(WGS84)[经度,纬度]',
  `circularRad` float(8,2) DEFAULT NULL COMMENT '圆形时-半径长度(米)',
  `polygonParams` json DEFAULT NULL COMMENT '多边形界点坐标[[经度,纬度],[经度,纬度]]',
  `creatorID` int NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图层拥有图形信息表';

-- ----------------------------
-- Table structure for tb_layers
-- ----------------------------
DROP TABLE IF EXISTS `tb_layers`;
CREATE TABLE `tb_layers` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `createUser` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '操作人',
  `creatorID` int NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `updatorID` int DEFAULT NULL COMMENT '操作人ID',
  `layerName` varchar(32) NOT NULL DEFAULT '' COMMENT '图层名称',
  `layerType` tinyint(1) NOT NULL DEFAULT '1' COMMENT '图层类型 1:禁飞区、2:限飞区、3:授权空域、4:作业区 ',
  `validType` tinyint(1) NOT NULL DEFAULT '1' COMMENT '生效类型 1:永久、2:临时',
  `validStartDate` int DEFAULT NULL COMMENT '临时-生效开始日期(时间戳)',
  `validEndDate` int DEFAULT NULL COMMENT '临时-生效结束日期(时间戳)',
  `validDate` varchar(32) DEFAULT NULL COMMENT '生效日期范围',
  `validStartTime` int DEFAULT NULL COMMENT '临时-生效开始时间(当日时间戳偏移量)',
  `validEndTime` int DEFAULT NULL COMMENT '临时-生效结束时间(当日时间戳偏移量)',
  `validTime` varchar(32) DEFAULT NULL COMMENT '生效时间范围',
  `maxHeight` float(8,2) DEFAULT NULL COMMENT '最大飞行高度(米)',
  `minHeight` float(8,2) DEFAULT NULL COMMENT '最小飞行高度(米)',
  `isValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '有效状态 1:有效、2:无效',
  `siteID` varchar(32) DEFAULT NULL COMMENT '关联站点',
  `PID` varchar(32) DEFAULT NULL COMMENT '项目ID',
  `CPID` varchar(32) DEFAULT NULL COMMENT '企业ID',
  `platId` int DEFAULT NULL COMMENT '平台ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图层信息表';

-- ----------------------------
-- Table structure for tb_missions
-- ----------------------------
DROP TABLE IF EXISTS `tb_missions`;
CREATE TABLE `tb_missions` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `missionID` varchar(32) NOT NULL COMMENT '任务编号',
  `missionName` varchar(64) NOT NULL COMMENT '任务名称',
  `missionType` tinyint(1) NOT NULL COMMENT '任务类型 1-路点巡航 2-拼图航拍 3-倾斜航拍',
  `UAVModelID` int NOT NULL COMMENT '无人机型号 Matrice 300 RTK',
  `siteID` varchar(32) NOT NULL COMMENT '站点编号',
  `flightParams` longblob COMMENT '航线参数',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除 默认值0',
  `CPID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `cameraModelID` int DEFAULT NULL COMMENT '相机型号',
  `thumbnailBase64` longblob COMMENT '航线缩略图',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='航线信息表';

-- ----------------------------
-- Table structure for tb_oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `tb_oauth_access_tokens`;
CREATE TABLE `tb_oauth_access_tokens` (
  `userID` int NOT NULL,
  `actionName` varchar(64) DEFAULT NULL,
  `token` text CHARACTER SET utf8mb4,
  `expiresAt` varchar(64) DEFAULT NULL,
  `clientIP` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户权限认证Token记录表';

-- ----------------------------
-- Table structure for tb_sites
-- ----------------------------
DROP TABLE IF EXISTS `tb_sites`;
CREATE TABLE `tb_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteID` varchar(32) NOT NULL COMMENT '站点编号',
  `siteMode` tinyint(1) NOT NULL COMMENT '站点模式 1-固定机库+射频基站 2-射频基站 3-单兵中枢 4-移动机库 5-无人机遥控器 6-天枢',
  `siteAddress` varchar(255) DEFAULT NULL COMMENT '站点地址',
  `siteName` varchar(64) DEFAULT NULL COMMENT '站点名称',
  `siteLocLongitude` double(15,10) DEFAULT NULL COMMENT '站点位置 WGS-84,经度',
  `siteLocLatitude` double(15,10) DEFAULT NULL COMMENT '站点位置 WGS-84,纬度',
  `siteOptionLocLongitude` double(15,10) DEFAULT NULL COMMENT '站点备降位置 WGS-84,经度',
  `siteOptionLocLatitude` double(15,10) DEFAULT NULL COMMENT '站点备降位置 WGS-84 纬度',
  `siteSafeLocLongitude` double(15,10) DEFAULT NULL COMMENT '站点安全位置 WGS-84 经度',
  `siteSafeLocLatitude` double(15,10) DEFAULT NULL COMMENT '站点安全位置 WGS-84 纬度',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除  1删除 0不删除',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间' COMMENT '创建时间',
  `updateTime` varchar(64) DEFAULT NULL COMMENT '更新时间',
  `siteAltitude` float(6,2) DEFAULT NULL COMMENT '站点相对地面高度',
  `siteHAltitude` float(6,2) DEFAULT NULL COMMENT '站点海拔高度',
  `siteEllipsAltitude` float(6,2) DEFAULT NULL COMMENT '站点椭球高度',
  `videoPullDomain` varchar(32) DEFAULT NULL COMMENT '站点拉流域名',
  `siteRHAltitude` float(6,2) DEFAULT NULL COMMENT '站点无人机返航高度',
  `UAVSTAltitude` float DEFAULT NULL COMMENT '无人机起飞高度',
  `siteFLVURI` varchar(255) DEFAULT NULL COMMENT '站点第三视角flv地址',
  `siteRHHeading` float(5,2) DEFAULT NULL COMMENT '站点无人机降落朝向',
  `siteRHHoverAltitude` float(6,2) DEFAULT NULL COMMENT '站点无人机返航降落悬停高度',
  `siteOptionAltitude` float(6,2) DEFAULT NULL COMMENT '站点无人机备降相对地面高度',
  `siteOptionHAltitude` float(6,2) DEFAULT NULL COMMENT '备降点海拔高度',
  `siteOptionEllipsAltitude` float(6,2) DEFAULT NULL COMMENT '备降点椭球高度',
  `siteOptionHoverAltitude` float(6,2) DEFAULT NULL COMMENT '站点无人机备降悬停高度',
  `siteOptionHeading` float(5,2) DEFAULT NULL COMMENT '站点备降朝向',
  `siteFlightMode` tinyint(1) NOT NULL COMMENT '站点飞行模式  1-孤岛模式 2-跳棋模式',
  `createUser` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updateUser` varchar(64) DEFAULT NULL COMMENT '更新者',
  `CPID` varchar(64) DEFAULT NULL COMMENT '企业编号',
  `PID` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `videoPushDomain` varchar(32) DEFAULT NULL COMMENT '推流域名',
  `flightWay` tinyint(1) NOT NULL COMMENT '支持的飞行方式 1普通飞行 2精细化飞',
  `isSiteType` tinyint(1) NOT NULL COMMENT '站点类型  1站点类型(带机库) 0单机',
  `UAVCPV` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'uav终端程序版本 1孤岛 2新版协议 3网联飞行',
  `HIVECPV` tinyint(1) NOT NULL COMMENT 'hive终端程序版本 1老版本 2新版协议',
  `siteBkgUrl` varchar(255) DEFAULT NULL COMMENT '站点背景图url',
  `networkMode` tinyint(1) DEFAULT '3' COMMENT '网络模式  1-互联网  2-局域网',
  `isComputer` tinyint(1) DEFAULT '0' COMMENT '类型5除外,其他类型是否配置机载计算机 默认是否 0',
  `creatorID` bigint DEFAULT NULL COMMENT '创建人ID',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人ID',
  `siteOptionRHAltitude` float(6,2) DEFAULT NULL COMMENT '站点备降点返航高度',
  `actionControlMode` tinyint(1) DEFAULT NULL COMMENT '站点动作控制模式 1-生产模式  2-维护模式',
  `mediaUploadType` tinyint(1) NOT NULL DEFAULT '3' COMMENT '0手动上传 1自动上传 2定时上传 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `siteID` (`siteID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点信息表';

-- ----------------------------
-- Table structure for tb_socketio_configs
-- ----------------------------
DROP TABLE IF EXISTS `tb_socketio_configs`;
CREATE TABLE `tb_socketio_configs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL COMMENT '用户ID',
  `IPAddress` varchar(64) DEFAULT NULL,
  `accessKeyId` varchar(64) DEFAULT NULL,
  `accessKeySecret` varchar(255) DEFAULT NULL,
  `namespace` varchar(32) DEFAULT NULL,
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户Socket信息配置表';

-- ----------------------------
-- Table structure for tb_sys_device_models
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_device_models`;
CREATE TABLE `tb_sys_device_models` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '型号名称',
  `modelCode` varchar(64) NOT NULL COMMENT '模型编号',
  `brand` varchar(255) DEFAULT NULL COMMENT '生产厂家',
  `appearanceUrl` varchar(255) DEFAULT NULL COMMENT '外形图预览url',
  `modelType` tinyint(1) NOT NULL COMMENT '类型 1无人机  2机库 3相机',
  `modelProperty` json DEFAULT NULL COMMENT '模型属性信息',
  `status` tinyint(1) NOT NULL COMMENT '状态信息 1启用 0禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设备模型信息表';

-- ----------------------------
-- Table structure for tb_sys_hive_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_hive_platforms`;
CREATE TABLE `tb_sys_hive_platforms` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PLATID` int DEFAULT NULL COMMENT '平台编号',
  `hiveID` varchar(32) DEFAULT NULL COMMENT '机库编号',
  `createUser` varchar(45) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机库与平台关联关系表';

-- ----------------------------
-- Table structure for tb_sys_logs
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_logs`;
CREATE TABLE `tb_sys_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT NULL COMMENT '类型',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `reqPar` text COMMENT '请求参数描述',
  `createUser` varchar(64) DEFAULT NULL COMMENT '创建人',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间' COMMENT '创建时间',
  `resPar` text COMMENT '响应参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统请求日志表';

-- ----------------------------
-- Table structure for tb_sys_platform
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_platform`;
CREATE TABLE `tb_sys_platform` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PLATCode` varchar(32) DEFAULT NULL,
  `PLATName` varchar(64) DEFAULT NULL,
  `PLATAccessWebsite` varchar(255) DEFAULT NULL COMMENT '平台访问网址',
  `PLATMappedAddress` varchar(255) DEFAULT NULL COMMENT '平台映射地址',
  `PLATLogoUrl` varchar(255) DEFAULT NULL COMMENT '平台logoUrl',
  `description` varchar(255) DEFAULT NULL,
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  `createUser` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updateUser` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新操作人',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `updatorID` int NOT NULL DEFAULT 0 COMMENT '最后更新操作人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='平台信息表';

-- ----------------------------
-- Table structure for tb_sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_resource`;
CREATE TABLE `tb_sys_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL COMMENT '父节点id',
  `type` tinyint NOT NULL COMMENT '1:菜单路由；2:资源(按钮等)',
  `status` int NOT NULL COMMENT '状态；1:可用,-1:禁用',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `code` varchar(255) DEFAULT NULL COMMENT '菜单路由为path,其他为唯一标识',
  `weight` int DEFAULT NULL COMMENT '权重顺序',
  `meta` varchar(2000) DEFAULT NULL COMMENT '元数据',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL,
  `updateUser` varchar(32) DEFAULT NULL,
  `createTime` varchar(64) NOT NULL,
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='资源表';

-- ----------------------------
-- Table structure for tb_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role`;
CREATE TABLE `tb_sys_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `name` varchar(64) NOT NULL COMMENT '角色名称',
  `code` varchar(64) NOT NULL COMMENT '角色code',
  `status` tinyint DEFAULT NULL COMMENT '状态(0无效,1有效)',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `type` tinyint NOT NULL COMMENT '类型:1:公共角色；2:特殊角色',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- ----------------------------
-- Table structure for tb_sys_role_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role_platforms`;
CREATE TABLE `tb_sys_role_platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `roleID` bigint NOT NULL COMMENT '角色ID',
  `PLATID` bigint NOT NULL COMMENT '平台编号',
  `createUser` varchar(45) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色与平台关联关系表';

-- ----------------------------
-- Table structure for tb_sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role_resource`;
CREATE TABLE `tb_sys_role_resource` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `roleID` bigint NOT NULL,
  `resourceID` bigint NOT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(45) DEFAULT NULL,
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色资源关联表';

-- ----------------------------
-- Table structure for tb_sys_sence_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_sence_platforms`;
CREATE TABLE `tb_sys_sence_platforms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `senceID` int NOT NULL COMMENT '场景ID',
  `PLATID` varchar(255) NOT NULL COMMENT '平台编号',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='平台与场景关联关系表';

-- ----------------------------
-- Table structure for tb_sys_sences
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_sences`;
CREATE TABLE `tb_sys_sences` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `senceCode` varchar(32) NOT NULL COMMENT '场景编号 例如 S_0001',
  `senceName` varchar(64) NOT NULL COMMENT '场景名称',
  `isDelete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除 0未删除 1删除',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` int DEFAULT NULL COMMENT '操作人ID',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_SenceCode` (`senceCode`) USING BTREE COMMENT '场景类型Code唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='场景类型表';

-- ----------------------------
-- Table structure for tb_sys_site_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_site_platforms`;
CREATE TABLE `tb_sys_site_platforms` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PLATID` int DEFAULT NULL COMMENT '平台编号',
  `siteID` int DEFAULT NULL COMMENT '站点编号',
  `createUser` varchar(45) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点与平台关联关系表';

-- ----------------------------
-- Table structure for tb_sys_task_types
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_task_types`;
CREATE TABLE `tb_sys_task_types` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `taskCode` varchar(32) NOT NULL COMMENT '作业类型编号 例如 T_0001',
  `taskName` varchar(64) NOT NULL COMMENT '作业类型名称',
  `isDelete` tinyint NOT NULL COMMENT '是否删除 0未删除 1删除',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `senceID` int NOT NULL COMMENT '场景表外键',
  `createTime` varchar(64) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建人',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` int DEFAULT NULL COMMENT '操作人ID',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_TaskCode` (`taskCode`) USING BTREE COMMENT '作业类型唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='无人机作业类型表';

-- ----------------------------
-- Table structure for tb_sys_uav_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_uav_platforms`;
CREATE TABLE `tb_sys_uav_platforms` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PLATID` int DEFAULT NULL COMMENT '平台编号',
  `UAVID` varchar(32) DEFAULT NULL COMMENT '无人机ID,无人机信息表外键',
  `createUser` varchar(32) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='无人机与平台关联关系表';

-- ----------------------------
-- Table structure for tb_sys_user_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_user_platforms`;
CREATE TABLE `tb_sys_user_platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `userID` bigint NOT NULL COMMENT '账号id',
  `PLATID` bigint NOT NULL COMMENT '平台编号',
  `createUser` varchar(45) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户与平台关联关系表';

-- ----------------------------
-- Table structure for tb_sys_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_user_roles`;
CREATE TABLE `tb_sys_user_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `userID` bigint NOT NULL COMMENT '账号id',
  `roleID` bigint NOT NULL COMMENT '角色id',
  `createUser` varchar(45) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  `isDefault` tinyint(1) DEFAULT '0' COMMENT '是否为默认角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账号角色关联表';

-- ----------------------------
-- Table structure for tb_sys_version_platforms
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_version_platforms`;
CREATE TABLE `tb_sys_version_platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `versionID` bigint NOT NULL COMMENT '版本ID',
  `PLATID` bigint NOT NULL COMMENT '平台编号',
  `status` tinyint(1) DEFAULT NULL COMMENT '平台状态  1当前版本   2以往版本',
  `createUser` varchar(45) DEFAULT NULL,
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createTime` varchar(32) NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='平台版本信息表';

-- ----------------------------
-- Table structure for tb_sys_versions
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_versions`;
CREATE TABLE `tb_sys_versions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `versionCode` varchar(32) DEFAULT NULL COMMENT '版本编号',
  `publishTime` varchar(64) DEFAULT NULL COMMENT '发布日期',
  `funcDesc` text COMMENT '功能描述',
  `status` tinyint DEFAULT NULL COMMENT '状态   1有效 0无效',
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统版本信息表';

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) DEFAULT NULL,
  `pass` varchar(64) DEFAULT NULL,
  `user_avater` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `token` varchar(64) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `realName` varchar(64) DEFAULT NULL,
  `createTime` varchar(64) NOT NULL COMMENT '创建时间',
  `creatorID` int NOT NULL DEFAULT 0 COMMENT '创建人ID',
  `createUser` varchar(32) NOT NULL COMMENT '创建用户',
  `updateTime` varchar(32) NOT NULL DEFAULT '' COMMENT '最后更新时间',
  `updatorID` bigint DEFAULT NULL COMMENT '更新人编号',
  `updateUser` varchar(32) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

-- ----------------------------
-- Table structure for video_stream_config
-- ----------------------------
DROP TABLE IF EXISTS `video_stream_config`;
CREATE TABLE `video_stream_config` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ST_ID` varchar(11) NOT NULL COMMENT '站点编号',
  `VIDEO_VIEW_ANGLE` varchar(64) DEFAULT NULL COMMENT '视角选择(uav,cam,in)',
  `VIDEO_PUSH_URL` varchar(255) DEFAULT NULL COMMENT '推流地址',
  `VIDEO_PULL_URL` varchar(255) DEFAULT NULL COMMENT '拉流地址',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(255) DEFAULT NULL COMMENT '创建人',
  `RECORD_STORAGE_ADDRESS` varchar(255) DEFAULT NULL COMMENT '视频回放存储URL',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `ST_ID` (`ST_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点视频流配置信息表';

SET FOREIGN_KEY_CHECKS = 1;
