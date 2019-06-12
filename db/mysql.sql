/*
 Navicat Premium Data Transfer

 Source Server         : 测试环境
 Source Server Type    : MySQL
 Source Server Version : 50642
 Source Host           : 192.168.2.157:3306
 Source Schema         : sven-fast

 Target Server Type    : MySQL
 Target Server Version : 50642
 File Encoding         : 65001

 Date: 10/06/2019 10:24:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE,
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------


-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_locks` VALUES (''RenrenScheduler'', ''STATE_ACCESS'');
INSERT INTO `qrtz_locks` VALUES (''RenrenScheduler'', ''TRIGGER_ACCESS'');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------


-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT ''任务id'',
  `bean_name` varchar(200) DEFAULT NULL COMMENT ''spring bean名称'',
  `params` varchar(2000) DEFAULT NULL COMMENT ''参数'',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT ''cron表达式'',
  `status` tinyint(4) DEFAULT NULL COMMENT ''任务状态  0：正常  1：暂停'',
  `remark` varchar(255) DEFAULT NULL COMMENT ''备注'',
  `create_time` datetime DEFAULT NULL COMMENT ''创建时间'',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT=''定时任务'';

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
BEGIN;
INSERT INTO `schedule_job` VALUES (1, ''testTask'', ''sven'', ''0 0/30 * * * ?'', 1, ''参数测试'', ''2019-06-03 13:45:32'');
COMMIT;

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT ''任务日志id'',
  `job_id` bigint(20) NOT NULL COMMENT ''任务id'',
  `bean_name` varchar(200) DEFAULT NULL COMMENT ''spring bean名称'',
  `params` varchar(2000) DEFAULT NULL COMMENT ''参数'',
  `status` tinyint(4) NOT NULL COMMENT ''任务状态    0：成功    1：失败'',
  `error` varchar(2000) DEFAULT NULL COMMENT ''失败信息'',
  `times` int(11) NOT NULL COMMENT ''耗时(单位：毫秒)'',
  `create_time` datetime DEFAULT NULL COMMENT ''创建时间'',
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `job_id` (`job_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=''定时任务日志'';

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha`;
CREATE TABLE `sys_captcha` (
  `uuid` char(36) NOT NULL COMMENT ''uuid'',
  `code` varchar(6) NOT NULL COMMENT ''验证码'',
  `expire_time` datetime DEFAULT NULL COMMENT ''过期时间'',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=''系统验证码'';

-- ----------------------------
-- Records of sys_captcha
-- ----------------------------
BEGIN;
INSERT INTO `sys_captcha` VALUES (''cd3fca5b-dc4a-44e7-8163-f136cd730492'', ''26ynm'', ''2019-06-05 10:09:41'');
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) DEFAULT NULL COMMENT ''key'',
  `param_value` varchar(2000) DEFAULT NULL COMMENT ''value'',
  `status` tinyint(4) DEFAULT ''1'' COMMENT ''状态   0：隐藏   1：显示'',
  `remark` varchar(500) DEFAULT NULL COMMENT ''备注'',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `param_key` (`param_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT=''系统配置信息表'';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES (1, ''CLOUD_STORAGE_CONFIG_KEY'', ''{\"type\":3,\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"qiniuBucketName\":\"ios-app\",\"aliyunDomain\":\"\",\"aliyunPrefix\":\"\",\"aliyunEndPoint\":\"\",\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\"}'', 0, ''云存储配置信息'');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT ''上级部门ID，一级部门为0'',
  `name` varchar(50) DEFAULT NULL COMMENT ''部门名称'',
  `order_num` int(11) DEFAULT NULL COMMENT ''排序'',
  `del_flag` tinyint(4) DEFAULT ''0'' COMMENT ''是否删除  -1：已删除  0：正常'',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT=''部门管理'';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (1, 0, ''哪都通集团'', 0, 0);
INSERT INTO `sys_dept` VALUES (2, 1, ''收货部'', 1, 0);
INSERT INTO `sys_dept` VALUES (3, 1, ''送货部'', 2, 0);
INSERT INTO `sys_dept` VALUES (4, 3, ''华东区'', 0, 0);
INSERT INTO `sys_dept` VALUES (5, 3, ''华北区'', 1, 0);
INSERT INTO `sys_dept` VALUES (6, 0, ''11'', 0, -1);
INSERT INTO `sys_dept` VALUES (7, 0, ''哈哈'', 0, -1);
INSERT INTO `sys_dept` VALUES (8, 2, ''哈哈'', 0, -1);
INSERT INTO `sys_dept` VALUES (9, 1, ''测试'', NULL, -1);
INSERT INTO `sys_dept` VALUES (10, 0, ''123'', 1, -1);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT ''字典名称'',
  `type` varchar(100) NOT NULL COMMENT ''字典类型'',
  `code` varchar(100) NOT NULL COMMENT ''字典码'',
  `value` varchar(1000) NOT NULL COMMENT ''字典值'',
  `order_num` int(11) DEFAULT ''0'' COMMENT ''排序'',
  `remark` varchar(255) DEFAULT NULL COMMENT ''备注'',
  `del_flag` tinyint(4) DEFAULT ''0'' COMMENT ''删除标记  -1：已删除  0：正常'',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `type` (`type`,`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT=''数据字典表'';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES (1, ''性别'', ''sex'', ''0'', ''女'', 0, NULL, 0);
INSERT INTO `sys_dict` VALUES (2, ''性别'', ''sex'', ''1'', ''男'', 1, NULL, 0);
INSERT INTO `sys_dict` VALUES (3, ''性别'', ''sex'', ''2'', ''未知'', 3, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `type` varchar(20) DEFAULT NULL COMMENT '日志类型',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `exception` text COMMENT '异常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT ''父菜单ID，一级菜单为0'',
  `name` varchar(50) DEFAULT NULL COMMENT ''菜单名称'',
  `url` varchar(200) DEFAULT NULL COMMENT ''菜单URL'',
  `perms` varchar(500) DEFAULT NULL COMMENT ''授权(多个用逗号分隔，如：user:list,user:create)'',
  `type` int(11) DEFAULT NULL COMMENT ''类型   0：目录   1：菜单   2：按钮'',
  `icon` varchar(50) DEFAULT NULL COMMENT ''菜单图标'',
  `order_num` int(11) DEFAULT NULL COMMENT ''排序'',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT=''菜单管理'';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (1, 0, ''系统管理'', NULL, NULL, 0, ''system'', 1);
INSERT INTO `sys_menu` VALUES (2, 41, ''用户管理'', ''sys/user'', NULL, 1, ''admin'', 1);
INSERT INTO `sys_menu` VALUES (3, 41, ''角色管理'', ''sys/role'', NULL, 1, ''role'', 2);
INSERT INTO `sys_menu` VALUES (4, 1, ''菜单管理'', ''sys/menu'', NULL, 1, ''menu'', 3);
INSERT INTO `sys_menu` VALUES (5, 42, ''SQL监控'', ''http://localhost:8080/sven-fast/druid/sql.html'', NULL, 1, ''sql'', 4);
INSERT INTO `sys_menu` VALUES (6, 1, ''定时任务'', ''job/schedule'', NULL, 1, ''job'', 5);
INSERT INTO `sys_menu` VALUES (7, 6, ''查看'', NULL, ''sys:schedule:list,sys:schedule:info'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (8, 6, ''新增'', NULL, ''sys:schedule:save'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (9, 6, ''修改'', NULL, ''sys:schedule:update'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (10, 6, ''删除'', NULL, ''sys:schedule:delete'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (11, 6, ''暂停'', NULL, ''sys:schedule:pause'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (12, 6, ''恢复'', NULL, ''sys:schedule:resume'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (13, 6, ''立即执行'', NULL, ''sys:schedule:run'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (14, 6, ''日志列表'', NULL, ''sys:schedule:log'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (15, 2, ''查看'', NULL, ''sys:user:list,sys:user:info'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (16, 2, ''新增'', NULL, ''sys:user:save,sys:role:select'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (17, 2, ''修改'', NULL, ''sys:user:update,sys:role:select'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (18, 2, ''删除'', NULL, ''sys:user:delete'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (19, 3, ''查看'', NULL, ''sys:role:list,sys:role:info'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (20, 3, ''新增'', NULL, ''sys:role:save,sys:menu:perms,sys:dept:list'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (21, 3, ''修改'', NULL, ''sys:role:update,sys:menu:perms,sys:dept:list'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (22, 3, ''删除'', NULL, ''sys:role:delete'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (23, 4, ''查看'', NULL, ''sys:menu:list,sys:menu:info'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (24, 4, ''新增'', NULL, ''sys:menu:save,sys:menu:select'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (25, 4, ''修改'', NULL, ''sys:menu:update,sys:menu:select'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (26, 4, ''删除'', NULL, ''sys:menu:delete'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (27, 1, ''参数管理'', ''sys/config'', ''sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete'', 1, ''config'', 6);
INSERT INTO `sys_menu` VALUES (29, 1, ''系统日志'', ''sys/log'', ''sys:log:list'', 1, ''log'', 7);
INSERT INTO `sys_menu` VALUES (30, 1, ''文件上传'', ''oss/oss'', ''sys:oss:all'', 1, ''oss'', 6);
INSERT INTO `sys_menu` VALUES (31, 41, ''部门管理'', ''sys/dept'', NULL, 1, ''dept'', 1);
INSERT INTO `sys_menu` VALUES (32, 31, ''查看'', NULL, ''sys:dept:list,sys:dept:info'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (33, 31, ''新增'', NULL, ''sys:dept:save,sys:dept:select'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (34, 31, ''修改'', NULL, ''sys:dept:update,sys:dept:select'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (35, 31, ''删除'', NULL, ''sys:dept:delete'', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (36, 1, ''字典管理'', ''sys/dict'', NULL, 1, ''shezhi'', 6);
INSERT INTO `sys_menu` VALUES (37, 36, ''查看'', NULL, ''sys:dict:list,sys:dict:info'', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (38, 36, ''新增'', NULL, ''sys:dict:save'', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (39, 36, ''修改'', NULL, ''sys:dict:update'', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (40, 36, ''删除'', NULL, ''sys:dict:delete'', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (41, 0, ''权限管理'', '''', '''', 0, ''safety'', 0);
INSERT INTO `sys_menu` VALUES (42, 0, ''系统监控'', '''', '''', 0, ''desktop'', 2);
COMMIT;

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT ''URL地址'',
  `create_date` datetime DEFAULT NULL COMMENT ''创建时间'',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT=''文件上传'';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT ''角色名称'',
  `remark` varchar(100) DEFAULT NULL COMMENT ''备注'',
  `dept_id` bigint(20) DEFAULT NULL COMMENT ''部门ID'',
  `create_time` datetime DEFAULT NULL COMMENT ''创建时间'',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT=''角色'';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, ''管理员'', ''管理员'', 1, ''2019-06-04 14:46:29'');
INSERT INTO `sys_role` VALUES (2, ''T99'', ''T99'', 2, ''2019-06-04 14:57:13'');
INSERT INTO `sys_role` VALUES (3, ''测试角色'', ''测试角色'', 3, ''2019-06-04 16:22:23'');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT ''角色ID'',
  `dept_id` bigint(20) DEFAULT NULL COMMENT ''部门ID'',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT=''角色与部门对应关系'';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` VALUES (13, 1, 1);
INSERT INTO `sys_role_dept` VALUES (14, 1, 2);
INSERT INTO `sys_role_dept` VALUES (15, 1, 3);
INSERT INTO `sys_role_dept` VALUES (16, 1, 4);
INSERT INTO `sys_role_dept` VALUES (17, 1, 5);
INSERT INTO `sys_role_dept` VALUES (23, 2, 2);
INSERT INTO `sys_role_dept` VALUES (28, 3, 3);
INSERT INTO `sys_role_dept` VALUES (29, 3, 4);
INSERT INTO `sys_role_dept` VALUES (30, 3, 5);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT ''角色ID'',
  `menu_id` bigint(20) DEFAULT NULL COMMENT ''菜单ID'',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT=''角色与菜单对应关系'';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (81, 1, 1);
INSERT INTO `sys_role_menu` VALUES (82, 1, 2);
INSERT INTO `sys_role_menu` VALUES (83, 1, 15);
INSERT INTO `sys_role_menu` VALUES (84, 1, 16);
INSERT INTO `sys_role_menu` VALUES (85, 1, 17);
INSERT INTO `sys_role_menu` VALUES (86, 1, 18);
INSERT INTO `sys_role_menu` VALUES (87, 1, 3);
INSERT INTO `sys_role_menu` VALUES (88, 1, 19);
INSERT INTO `sys_role_menu` VALUES (89, 1, 20);
INSERT INTO `sys_role_menu` VALUES (90, 1, 21);
INSERT INTO `sys_role_menu` VALUES (91, 1, 22);
INSERT INTO `sys_role_menu` VALUES (92, 1, 4);
INSERT INTO `sys_role_menu` VALUES (93, 1, 23);
INSERT INTO `sys_role_menu` VALUES (94, 1, 24);
INSERT INTO `sys_role_menu` VALUES (95, 1, 25);
INSERT INTO `sys_role_menu` VALUES (96, 1, 26);
INSERT INTO `sys_role_menu` VALUES (97, 1, 5);
INSERT INTO `sys_role_menu` VALUES (98, 1, 6);
INSERT INTO `sys_role_menu` VALUES (99, 1, 7);
INSERT INTO `sys_role_menu` VALUES (100, 1, 8);
INSERT INTO `sys_role_menu` VALUES (101, 1, 9);
INSERT INTO `sys_role_menu` VALUES (102, 1, 10);
INSERT INTO `sys_role_menu` VALUES (103, 1, 11);
INSERT INTO `sys_role_menu` VALUES (104, 1, 12);
INSERT INTO `sys_role_menu` VALUES (105, 1, 13);
INSERT INTO `sys_role_menu` VALUES (106, 1, 14);
INSERT INTO `sys_role_menu` VALUES (107, 1, 27);
INSERT INTO `sys_role_menu` VALUES (108, 1, 29);
INSERT INTO `sys_role_menu` VALUES (109, 1, 30);
INSERT INTO `sys_role_menu` VALUES (110, 1, 31);
INSERT INTO `sys_role_menu` VALUES (111, 1, 32);
INSERT INTO `sys_role_menu` VALUES (112, 1, 33);
INSERT INTO `sys_role_menu` VALUES (113, 1, 34);
INSERT INTO `sys_role_menu` VALUES (114, 1, 35);
INSERT INTO `sys_role_menu` VALUES (115, 1, 36);
INSERT INTO `sys_role_menu` VALUES (116, 1, 37);
INSERT INTO `sys_role_menu` VALUES (117, 1, 38);
INSERT INTO `sys_role_menu` VALUES (118, 1, 39);
INSERT INTO `sys_role_menu` VALUES (119, 1, 40);
INSERT INTO `sys_role_menu` VALUES (145, 2, 2);
INSERT INTO `sys_role_menu` VALUES (146, 2, 15);
INSERT INTO `sys_role_menu` VALUES (147, 2, 16);
INSERT INTO `sys_role_menu` VALUES (148, 2, 17);
INSERT INTO `sys_role_menu` VALUES (149, 2, 18);
INSERT INTO `sys_role_menu` VALUES (150, 2, 3);
INSERT INTO `sys_role_menu` VALUES (151, 2, 19);
INSERT INTO `sys_role_menu` VALUES (152, 2, 20);
INSERT INTO `sys_role_menu` VALUES (153, 2, 21);
INSERT INTO `sys_role_menu` VALUES (154, 2, 22);
INSERT INTO `sys_role_menu` VALUES (156, 2, 1);
INSERT INTO `sys_role_menu` VALUES (168, 3, 2);
INSERT INTO `sys_role_menu` VALUES (169, 3, 15);
INSERT INTO `sys_role_menu` VALUES (170, 3, 17);
INSERT INTO `sys_role_menu` VALUES (171, 3, 16);
INSERT INTO `sys_role_menu` VALUES (172, 3, 18);
INSERT INTO `sys_role_menu` VALUES (173, 3, 20);
INSERT INTO `sys_role_menu` VALUES (174, 3, 22);
INSERT INTO `sys_role_menu` VALUES (175, 3, 19);
INSERT INTO `sys_role_menu` VALUES (176, 3, 1);
INSERT INTO `sys_role_menu` VALUES (177, 3, 3);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT ''用户名'',
  `password` varchar(100) DEFAULT NULL COMMENT ''密码'',
  `salt` varchar(20) DEFAULT NULL COMMENT ''盐'',
  `email` varchar(100) DEFAULT NULL COMMENT ''邮箱'',
  `mobile` varchar(100) DEFAULT NULL COMMENT ''手机号'',
  `status` tinyint(4) DEFAULT NULL COMMENT ''状态  0：禁用   1：正常'',
  `dept_id` bigint(20) DEFAULT NULL COMMENT ''部门ID'',
  `create_time` datetime DEFAULT NULL COMMENT ''创建时间'',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT=''系统用户'';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, ''admin'', ''e1153123d7d180ceeb820d577ff119876678732a68eef4e6ffc0b1f06a01f91b'', ''YzcmCZNvbXocrsz9dm8e'', ''1050676672@qq.com'', ''18721391773'', 1, 1, ''2016-11-11 11:11:11'');
INSERT INTO `sys_user` VALUES (2, ''Sven'', ''6fbb3be60bf6437a1ee476f74d4526dc8a4c8839cfb75a20c81c59e1b3891315'', ''i1zECdWaWIVOXMpTqwa8'', ''1050676672@qq.com'', ''18721391773'', 1, 2, ''2019-06-04 15:18:44'');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT ''用户ID'',
  `role_id` bigint(20) DEFAULT NULL COMMENT ''角色ID'',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT=''用户与角色对应关系'';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES (4, 2, 3);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT ''token'',
  `expire_time` datetime DEFAULT NULL COMMENT ''过期时间'',
  `update_time` datetime DEFAULT NULL COMMENT ''更新时间'',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `token` (`token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=''系统用户Token'';

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_token` VALUES (1, ''9ff7a77407181bdbd55cfb4746fc996f'', ''2019-06-06 21:20:36'', ''2019-06-06 09:20:36'');
INSERT INTO `sys_user_token` VALUES (2, ''6ac5abe40b8b7d6aa4db882ddb153d30'', ''2019-06-05 04:23:01'', ''2019-06-04 16:23:01'');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
