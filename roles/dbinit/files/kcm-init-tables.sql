USE kcm;
#################################  区域表 begin  ################################

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
`id` char(32) NOT NULL COMMENT 'ID',
`name` varchar(100) NOT NULL COMMENT '区域名称',
`cn` varchar(100) NOT NULL COMMENT 'unique名称',
`pid` char(32) DEFAULT NULL COMMENT '父节点ID',
`order` int(10) unsigned NOT NULL COMMENT '显示顺序',
`created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
`created_by_user_name` varchar(100) NOT NULL COMMENT '创建用户名',
`creation_time` datetime NOT NULL COMMENT '创建时间',
`comment` varchar(600) DEFAULT NULL COMMENT '备注',
`is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '删除状态 0: 未删除 1: 已删除',
`path_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '路径ID',
`path` varchar(100) DEFAULT NULL COMMENT '区域路径',
`ipa_unique_id` varchar(64) DEFAULT NULL COMMENT 'kim全局唯一标识',
PRIMARY KEY (`id`),
UNIQUE KEY `cn_UNIQUE` (`cn`),
UNIQUE KEY `path_id_UNIQUE` (`path_id`),
UNIQUE KEY `area_ipa_unique_id_uindex` (`ipa_unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域表';
/*!40101 SET character_set_client = @saved_cs_client */;


#################################  区域表 end  ##################################


#################################  区域-IP规则关联表 begin  ################################

DROP TABLE IF EXISTS `area_ip_rules_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area_ip_rules_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`area_id` char(32) NOT NULL COMMENT '区域ID',
`ip_section` text NULL COMMENT 'IP规则段',
PRIMARY KEY (`id`),
UNIQUE KEY `area_id_UNIQUE` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域-IP规则关联表';

#################################  区域-IP规则关联表 end  ##################################


##############################  终端用户表 begin  ################################

DROP TABLE IF EXISTS `terminal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_user` (
`id` char(32) NOT NULL COMMENT 'ID',
`uid` varchar(100) DEFAULT NULL COMMENT '登录名',
`uid_number` varchar(100) DEFAULT NULL COMMENT '用户ID',
`gid_number` varchar(100) DEFAULT NULL COMMENT '用户组ID',
`display_name` varchar(100) DEFAULT NULL COMMENT '显示名',
`is_enabled` tinyint(4) NOT NULL DEFAULT 1 COMMENT '启用状态 0: 禁用 1: 启用',
`kim_ipa_unique_id` varchar(200) DEFAULT NULL COMMENT 'KIM全局唯一ID',
`kim_user_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
`ds_name` char(32) DEFAULT 'KCM' COMMENT '数据源类型',
PRIMARY KEY (`id`),
UNIQUE KEY `kim_ipa_unique_id_UNIQUE` (`kim_ipa_unique_id`),
UNIQUE KEY `uid_number_UNIQUE` (`uid_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='终端用户表';

###############################  终端用户表 end  #################################


##############################  终端主机表 begin  ################################

DROP TABLE IF EXISTS `terminal_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_host` (
`id` char(32) NOT NULL COMMENT 'ID',
`kim_fqdn` varchar(500) NOT NULL COMMENT 'Fully Qualified Domain Name',
`alias` varchar(500) DEFAULT NULL COMMENT '主机别名',
`devsn` varchar(150) DEFAULT NULL COMMENT '设备SN',
`kimhostserial` varchar(150) DEFAULT NULL COMMENT '主机序列号',
`kim_registry_status` tinyint(4) NOT NULL COMMENT 'KIM主机注册状态 0: 未注册 1: 已注册',
`kim_ipa_unique_id` varchar(200) DEFAULT NULL COMMENT 'KIM全局唯一ID',
`kim_host_time` datetime NOT NULL COMMENT '创建时间',
PRIMARY KEY (`id`),
UNIQUE KEY `devsn` (`devsn`),
UNIQUE KEY `kim_ipa_unique_id_UNIQUE` (`kim_ipa_unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='终端主机表';

##############################  终端主机表 end  ##################################


############################  终端用户-区域关联表 begin  ##########################

DROP TABLE IF EXISTS `terminal_user_area_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_user_area_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`terminal_user_id` char(32) NOT NULL COMMENT '终端用户ID terminal_user.id',
`area_id` char(32) NOT NULL COMMENT '区域ID area.id',
PRIMARY KEY (`id`),
UNIQUE KEY `terminal_user_id_UNIQUE` (`terminal_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='终端用户-区域关联表';

############################  终端用户-区域关联表 end  ############################


############################  终端主机-区域关联表 begin  ##########################

DROP TABLE IF EXISTS `terminal_host_area_relationships`;

CREATE TABLE IF NOT EXISTS `terminal_host_area_relationships` (
    `id` CHAR(32) NOT NULL COMMENT 'ID',
    `terminal_host_id` CHAR(32) NOT NULL COMMENT '终端主机ID, terminal_host.id',
    `area_id` CHAR(32) NOT NULL COMMENT '区域ID area.id',
    PRIMARY KEY (`id`)
)  ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=UTF8MB4 COMMENT='终端主机-区域关联表';
ALTER TABLE terminal_host_area_relationships ADD UNIQUE INDEX terminal_host_id_UNIQUE (terminal_host_id);

############################  终端主机-区域关联表 end  ############################


#################################  消息表 begin  ################################

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
`id` char(32) NOT NULL COMMENT 'ID',
`title` varchar(100) NOT NULL COMMENT '消息标题',
`description` varchar(200) NOT NULL COMMENT '消息描述',
`main_text` text NOT NULL COMMENT '消息主体',
`publish_status` int(4) DEFAULT 0 COMMENT '消息发布状态 0:正在发送 1: 发送完成 2：发送失败',
`level` tinyint(3) unsigned NOT NULL COMMENT '消息级别',
`creator` varchar(20) DEFAULT NULL COMMENT '发送人',
`creation_time` varchar(30) DEFAULT NULL COMMENT '发送时间',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

#################################  消息表 end  ################################


##############################  消息推送表 begin  ################################
# DROP TABLE IF EXISTS `message_delivery`;
# CREATE TABLE IF NOT EXISTS `message_delivery` (
#     `id` CHAR(32) NOT NULL COMMENT 'ID',
#     `message_id` CHAR(32) NOT NULL COMMENT '消息ID message.id',
#     `terminal_user_id` CHAR(32) NOT NULL COMMENT '接收用户ID terminal_user.id',
#     `terminal_host_id` CHAR(32) NOT NULL COMMENT '接收主机ID terminal_host.id',
#     `delivery_status` INT UNSIGNED NOT NULL COMMENT '消息推送状态',
#     PRIMARY KEY (`id`)
# )  ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=UTF8MB4 COMMENT='消息推送表';
##############################  消息推送表 end  #################################


############################  U盘黑白名单表 begin  ###############################

DROP TABLE IF EXISTS `flash_disk_black_and_white_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flash_disk_black_and_white_list` (
`id` char(32) NOT NULL COMMENT 'ID',
`name` varchar(100) NOT NULL COMMENT '别名',
`pid` varchar(100) NOT NULL COMMENT '产品识别码',
`vid` varchar(100) NOT NULL COMMENT '供应商ID',
`enabled_status` tinyint(4) NOT NULL COMMENT '启用状态 0: 禁用-黑名单 1: 启用-白名单',
`deleted_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '删除状态 0: 已删除 1: 未删除',
`comment` varchar(200) DEFAULT NULL COMMENT '描述',
`make` varchar(32) DEFAULT NULL COMMENT '生产厂商',
`model` varchar(32) DEFAULT NULL COMMENT '型号',
`creation_time` datetime NOT NULL COMMENT '创建时间',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='U盘黑白名单表';

############################  U盘黑白名单表 end  #################################


############################  WIFI黑白名单表 begin  ##############################

DROP TABLE IF EXISTS `wifi_black_and_white_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wifi_black_and_white_list` (
`id` char(32) NOT NULL COMMENT 'ID',
`bssid` varchar(100) NOT NULL COMMENT 'WIFI MAC地址',
`enabled_status` tinyint(4) NOT NULL COMMENT '启用状态 0: 禁用-黑名单 1: 启用-白名单',
`deleted_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '删除状态 0: 已删除 1: 未删除',
`comment` varchar(200) NOT NULL COMMENT '描述',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='WIFI黑白名单表';

############################  WIFI黑白名单表 end  ################################


#########################  黑白名单-终端主机关联表 begin  #######################

DROP TABLE IF EXISTS `black_and_white_list_terminal_host_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `black_and_white_list_terminal_host_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`restricted_object_id` char(32) NOT NULL COMMENT '受控对象ID',
`terminal_host_id` char(32) NOT NULL COMMENT '主机ID terminal_host.id',
`list_type` tinyint(4) NOT NULL COMMENT '名单类型',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='黑白名单-终端主机关联表';

#########################  黑白名单-终端主机关联表 end  #########################


###########################  管理员-区域关联表 begin  ############################

DROP TABLE IF EXISTS `admin_area_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_area_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`admin_user_id` int(11) NOT NULL COMMENT '管理员用户ID users.id',
`area_id` char(32) NOT NULL COMMENT '区域ID area.id',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员-区域关联表';

###########################  管理员-区域关联表 end  ##############################


#################################  任务表 begin  #################################

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
`id` char(32) NOT NULL COMMENT 'ID',
`name` varchar(300) NOT NULL COMMENT '任务名称',
`created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
`created_by_user_name` varchar(100) NOT NULL COMMENT '创建用户名',
`creation_time` datetime NOT NULL COMMENT '创建时间',
`execution_status` varchar(100) NOT NULL COMMENT '任务执行状态',
`type` tinyint(3) unsigned DEFAULT NULL COMMENT '任务类型 0/1:黑白名单相关任务  2:下发消息相关任务',
`area_id` char(32) DEFAULT NULL COMMENT '区域ID',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务表';

#################################  任务表 end  ###################################


###############################  任务执行表 begin  ###############################

DROP TABLE IF EXISTS `task_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_execution` (
`id` char(32) NOT NULL COMMENT 'ID',
`task_id` char(32) NOT NULL COMMENT '任务ID task.id',
`terminal_host_id` char(32) DEFAULT NULL COMMENT '主机ID terminal_host.id',
`execution_status` varchar(100) NOT NULL COMMENT '任务执行状态',
`area_id` char(32) DEFAULT NULL COMMENT '区域id',
`devsn` varchar(150) DEFAULT NULL COMMENT '设备SN',
PRIMARY KEY (`id`),
KEY `task_execution_task_id_terminal_host_id_execution_status_IDX` (`task_id`,`terminal_host_id`,`execution_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务执行表';

###############################  任务执行表 end  #################################


#################################  策略表 begin  #################################

DROP TABLE IF EXISTS `strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strategy` (
`id` char(32) NOT NULL COMMENT 'ID',
`name` varchar(300) NOT NULL COMMENT '策略名称',
`created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
`created_by_user_name` varchar(100) NOT NULL COMMENT '创建用户名',
`creation_time` datetime NOT NULL COMMENT '创建时间',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='策略表';

#################################  策略表 end  ###################################


#################################  策略配置表 begin  #############################

DROP TABLE IF EXISTS `strategy_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strategy_config` (
    `id` char(32) NOT NULL COMMENT 'ID',
    `strategy_id` char(32) DEFAULT NULL COMMENT '策略ID strategy.id',
    `config_type` int(10) unsigned NOT NULL COMMENT '策略配置类型',
    `order` int(10) unsigned DEFAULT NULL COMMENT '显示顺序',
    `created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
    `created_by_user_name` varchar(100) NOT NULL COMMENT '创建用户名',
    `modification_time` datetime NOT NULL COMMENT '修改时间',
    `mode_id` tinyint(3) unsigned DEFAULT NULL COMMENT '模板id',
    `base_object_id` varchar(32) NOT NULL COMMENT '创建该策略的基础对象',
    `base_object_type` int(10) unsigned NOT NULL COMMENT '创建该策略的基础对象类型',
    `islocked` enum('Y', 'N') NOT NULL DEFAULT 'Y' COMMENT '策略是否上锁',
    `publish` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否下发 0：未下发 1：已下发',
    `comment` varchar(100) DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '策略配置表';
#################################  策略配置表 end  ###############################


#############################  策略-对象关联表 begin  ############################

DROP TABLE IF EXISTS `strategy_object_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strategy_object_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`object_id` char(32) NOT NULL COMMENT '对象ID area.id 或 tag.id',
`strategy_id` char(32) NOT NULL COMMENT '策略ID strategy.id',
`object_type` int(10) unsigned NOT NULL COMMENT '对象类型 tag.type',
`created_by_area_order` int(10) unsigned NOT NULL COMMENT '所在区域级别',
`modification_time` datetime NOT NULL COMMENT '关联时间',
`strategy_type` int NOT NULL COMMENT '策略类型',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='策略-对象关联表';

#############################  策略-对象关联表 end  ##############################


###############################  策略任务执行表 begin  ###############################

DROP TABLE IF EXISTS `strategy_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strategy_execution` (
    `id` char(32) NOT NULL COMMENT 'ID',
    `strategy_config_id` char(32) NOT NULL COMMENT '策略ID strategy_config.id',
    `terminal_host_id` char(32) DEFAULT NULL COMMENT '主机ID terminal_host.id',
    `uuid` VARCHAR(32) NOT NULL COMMENT '策略任务uuid',
    `area_id` char(32) DEFAULT NULL COMMENT '区域id',
    `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '删除状态 0: 未删除 1: 已删除',
    PRIMARY KEY (`id`),
    KEY `strategy_execution_task_id_terminal_host_id_execution_status_IDX` (
    `strategy_config_id`,
    `terminal_host_id`,
    `uuid`
    ) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '策略任务执行表';

###############################  策略任务执行表 end  #################################


#################################  标签表 begin  #################################

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
`id` char(32) NOT NULL COMMENT 'ID',
`tag_name` varchar(300) NOT NULL COMMENT '标签名称',
`type` tinyint(4) NOT NULL COMMENT '标签类型 1: 用户 2: 主机 3: 其他',
`is_related_to_kim` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否与KIM关联 0: 否 1: 是',
`p_tag_id` char(32) DEFAULT NULL COMMENT '父标签ID tag.id',
`order` int(10) unsigned NOT NULL COMMENT '显示顺序',
`is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '删除状态 0: 未删除 1: 已删除',
`created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
`created_by_user_name` varchar(100) NOT NULL COMMENT '创建用户名',
`creation_time` datetime NOT NULL COMMENT '创建时间',
PRIMARY KEY (`id`),
UNIQUE KEY `tag_name_UNIQUE` (`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标签表';

#################################  标签表 end  ###################################


#############################  标签-对象关联表 begin  ############################

DROP TABLE IF EXISTS `tag_object_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_object_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`tag_id` char(32) NOT NULL COMMENT '标签ID tag.id',
`object_id` char(32) NOT NULL COMMENT '对象ID terminal_user.id 或 terminal_host.id',
`object_type` tinyint(4) NOT NULL COMMENT '对象类型 tag.type',
`modification_time` datetime NOT NULL COMMENT '关联时间',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标签-对象关联表';

#############################  标签-对象关联表 end  ##############################


###############################  密码策略表 begin  ###############################

DROP TABLE IF EXISTS `password_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_policy` (
`id` char(32) NOT NULL COMMENT 'ID',
`area_id` char(32) DEFAULT NULL COMMENT 'ID',
`name` varchar(100) NOT NULL COMMENT '密码策略名称 KIM中与组名相同',
`cospriority` int(10) unsigned NOT NULL COMMENT '优先级',
`min_password_life` int(10) unsigned DEFAULT NULL COMMENT '最小生存期（小时）',
`max_password_life` int(10) unsigned DEFAULT NULL COMMENT '最大生存期（天）',
`password_history_length` int(10) unsigned DEFAULT NULL COMMENT '历史大小 (密码数)',
`password_min_diff_chars` int(10) unsigned DEFAULT NULL COMMENT '字符种类',
`password_min_length` int(10) unsigned DEFAULT NULL COMMENT '最小长度',
`password_max_failure` int(10) unsigned DEFAULT NULL COMMENT '最大失败次数',
`password_failure_count_interval` int(10) unsigned DEFAULT NULL COMMENT '失败重置时间间隔 (秒)',
`password_lock_out_duration` int(10) unsigned DEFAULT NULL COMMENT '锁定时间 (秒)',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='密码策略表';

###############################  密码策略表 end  #################################


##############################  用户行为记录表 begin  ############################

DROP TABLE IF EXISTS `user_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_action_log` (
`id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
`user_id` int(11) NOT NULL COMMENT '用户id',
`user_ip` VARCHAR(100) NULL COMMENT '用户ip',
`log_type` VARCHAR(100) NULL COMMENT '日志类型',
`action` text NOT NULL COMMENT '行为',
`status` bool DEFAULT '1' COMMENT '行为成功失败标志位，0为失败，1为成功',
`creation_time` datetime NOT NULL COMMENT '创建时间',
PRIMARY KEY (id),
KEY `user_action_log_id_IDX` (`id`,`user_id`,`log_type`,`creation_time`) USING BTREE,
FULLTEXT KEY `user_action_log_action_IDX` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户行为记录表';

##############################  用户行为记录表 end  ##############################


#########################  策略&策略配置关联表 begin  ############################

DROP TABLE IF EXISTS `strategy_config_strategy_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strategy_config_strategy_relationships` (
`id` char(32) NOT NULL COMMENT 'ID',
`strategy_id` char(32) NOT NULL COMMENT '策略ID strategy.id',
`strategy_config_id` char(32) NOT NULL COMMENT '策略配置ID strategy_config.id',
`config_type` int(10) unsigned NOT NULL COMMENT '策略配置类型',
`created_by_area_order` int(10) unsigned NOT NULL COMMENT '所在区域级别',
`created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
`created_by_user_name` varchar(100) NOT NULL COMMENT '创建用户名',
`creation_time` datetime NOT NULL COMMENT '创建时间',
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='策略和策略配置关联表';

########################   策略&策略配置关联表 end  ##############################

#########################  用户登录设备记录表 begin  ############################

DROP TABLE IF EXISTS `device_login_log`;
CREATE TABLE IF NOT EXISTS `device_login_log` (
    `id`        BIGINT AUTO_INCREMENT COMMENT 'ID',
    `username`  CHAR(64) NULL COMMENT '用户名',
    `device_sn` CHAR(32) NULL COMMENT '设备SN码',
    `time`      INT      NULL COMMENT '记录时间戳',
    `action`    TEXT     NULL COMMENT '行为',
    `hostname`  VARCHAR(100) DEFAULT NULL COMMENT '主机名',
    `ip`        VARCHAR(20) DEFAULT NULL COMMENT 'ip',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '用户登录设备记录表' ;
CREATE INDEX device_login_log_username_device_sn_time_index ON `device_login_log` (username, device_sn, time);

########################   用户登录设备记录表 end  ##############################

########################   APT软件包表 begin  ###################################

DROP TABLE IF EXISTS `apt_package`;
CREATE TABLE IF NOT EXISTS `apt_package` (
`id`            INT(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
`name`          VARCHAR(100) NOT NULL COMMENT '软件包名称',
`architecture`  VARCHAR(200) DEFAULT NULL COMMENT '架构',
`version`       VARCHAR(300) DEFAULT NULL COMMENT '版本',
`priority`      VARCHAR(100) DEFAULT NULL COMMENT '优先级',
`section`       VARCHAR(100) DEFAULT NULL COMMENT '分类',
`creation_time` DATETIME NOT NULL COMMENT '创建时间',
KEY `package_name_version_IDX` (`name`,`version`) USING BTREE,
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COMMENT='APT软件包表';

########################   APT软件包表 end  #####################################

########################   主机信息表Monit02 begin  ###################################

DROP TABLE IF EXISTS `monit02`;

CREATE TABLE `monit02` (
`hostid` int(11) NOT NULL AUTO_INCREMENT,
`devsn` varchar(64) NOT NULL UNIQUE COMMENT '设备序列号',
`status` varchar(64) DEFAULT NULL COMMENT '状态',
`name` varchar(150) DEFAULT NULL COMMENT '名称',
`description` varchar(600) DEFAULT NULL COMMENT '介绍',
`posid` int(11) DEFAULT NULL,
`groupname` varchar(128) DEFAULT NULL COMMENT '所属组',
`active` tinyint(3) DEFAULT NULL COMMENT '激活状态',
`cpuframework` varchar(32) DEFAULT NULL COMMENT 'cpu架构',
PRIMARY KEY (`hostid`),
KEY `indexdevsn` (`devsn`),
KEY `indexactive` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=12571 DEFAULT CHARSET=utf8mb4 COMMENT='主机信息表 ';

########################   主机信息表Monit02 end  ###################################

########################   用户信息表users begin  ###################################
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
`user_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
`username` varchar(10) NOT NULL,
`password` char(32) DEFAULT NULL,
`role_id` tinyint(3) unsigned DEFAULT NULL,
`status` char(1) DEFAULT '1' COMMENT '用户是否禁用标志位，0为禁用，1为启用',
`name` varchar(16) DEFAULT NULL COMMENT '用户真实姓名',
`create_by_user_id` tinyint(3) NOT NULL,
PRIMARY KEY (`user_id`),
UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

########################   用户表users end  #########################################

########################   角色信息表roles start  #########################################
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
`role_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
`rolename` varchar(10) NOT NULL,
`routes` varchar(1000) DEFAULT NULL,
`introduce` varchar(20) DEFAULT NULL,
`create_by_user_id` tinyint(3) DEFAULT NULL COMMENT '用户id',
PRIMARY KEY (`role_id`),
UNIQUE KEY `rolename` (`rolename`),
UNIQUE KEY `rolename_2` (`rolename`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='角色信息表';
########################   角色信息表roles end  #########################################

########################   周期执行脚本列表 start  #########################################
DROP TABLE IF EXISTS `script_loop`;
CREATE TABLE `script_loop`(
`id` VARCHAR(32) NOT NULL primary key COMMENT 'uuid',
`main_id` VARCHAR(32) COMMENT '主任务ID',
`name` VARCHAR(40) COMMENT '脚本名称',
`devsn` VARCHAR(30) COMMENT '设备SN',
`dest` VARCHAR(100) COMMENT '文件路径',
`create_time` DATETIME COMMENT 'create time',
`delete_flag` TINYINT UNSIGNED COMMENT '删除状态0：未删除，1：已删除',
`create_admin` VARCHAR(32) COMMENT '创建人',
KEY `delete_flag_UNIQUE` (`delete_flag`),
KEY `create_admin_UNIQUE` (`create_admin`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '周期执行脚本列表';
#######################   周期执行脚本列表 end  #########################################

########################   APT软件源 start  #####################################
DROP TABLE IF EXISTS `apt_source`;
CREATE TABLE `apt_source` (
    `id` int(16) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name` varchar(100) NOT NULL COMMENT '软件源名称',
    `uri` varchar(300) DEFAULT NULL COMMENT '软件源链接',
    `comment` varchar(600) DEFAULT NULL COMMENT '备注',
    `creation_time` datetime NOT NULL COMMENT '创建时间',
    `distribute_status` varchar(100) DEFAULT NULL COMMENT '软件分发类型 0：软件分发，1：补丁分发',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8mb4 COMMENT = 'APT软件源表';
########################   APT软件源 end  #####################################

########################   APT软件源与区域关系 start  #####################################
DROP TABLE IF EXISTS `apt_source_device_group_relationship`;
CREATE TABLE `apt_source_device_group_relationship` (
    `id` int(16) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `apt_source_id` int(16) NOT NULL COMMENT '软件源id apt_source.id',
    `group_id` int(11) DEFAULT NULL COMMENT '设备分组id device_group.id',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 21 DEFAULT CHARSET = utf8mb4 COMMENT = 'APT软件源-设备分组关联表';
########################   APT软件源与区域关系 end  #####################################

########################   APT软件源与包关系 start  #####################################
DROP TABLE IF EXISTS `apt_source_package_relationship`;
CREATE TABLE `apt_source_package_relationship` (
    `id` int(16) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `source_id` int(16) NOT NULL COMMENT '软件源id',
    `package_id` int(16) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `source_package_index` (`source_id`, `package_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COMMENT = 'APT软件源与软件包关联表';
########################   APT软件源与包关系 end  #####################################

#######################   服务器异常 Start  #########################################
-- kcm.server_exception definition
DROP TABLE IF EXISTS `server_exception`;
CREATE TABLE `server_exception` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '服务器异常主键',
    `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常类型',
    `level` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常等级',
    `comment` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常内容',
    `created_time` datetime NOT NULL COMMENT '创建时间',
    `ip` varchar(32) NOT NULL COMMENT 'ip',
    `hostname` varchar(32) DEFAULT NULL COMMENT '服务器主机名',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '服务器指标异常记录';
#######################   服务器异常 End  #########################################

#######################   设备分组表 Start  #########################################
DROP TABLE IF EXISTS `device_group`;
CREATE TABLE `device_group` (
`id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分组id',
`name` varchar(64) NOT NULL COMMENT '分组名称',
`comment` varchar(600) DEFAULT NULL COMMENT '备注',
`creation_time` datetime NOT NULL COMMENT '创建时间',
`created_by_id` int(11) NOT NULL COMMENT '创建人ID',
`created_by_name` varchar(64) NOT NULL COMMENT '创建人名称',
`modification_time` datetime NOT NULL COMMENT '修改时间',
`modified_by_id` int(11) NOT NULL COMMENT '修改人ID',
`modified_by_name` varchar(64) NOT NULL COMMENT '修改人名称',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='设备分组表';
#######################  设备分组表 End  ###########################################

#######################  监控项表  Start  ##########################################
DROP TABLE IF EXISTS `monit04`;
CREATE TABLE `monit04` (
`itemid` int(11) NOT NULL AUTO_INCREMENT COMMENT '监控项ID',
`objectname` varchar(128) DEFAULT NULL COMMENT ' 对象名称',
`objectgroup` text DEFAULT NULL COMMENT '对象组',
`type` varchar(128) DEFAULT NULL COMMENT '类型',
`name` varchar(128) DEFAULT NULL COMMENT '监控项名称',
`value` varchar(200) DEFAULT NULL COMMENT '值',
`valuetype` varchar(45) DEFAULT NULL COMMENT '模板属性',
`status` varchar(45) DEFAULT NULL COMMENT '状态',
`templatename` varchar(45) DEFAULT NULL COMMENT '模板名称',
`triggername` varchar(45) DEFAULT NULL COMMENT '触发器名称',
`update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
`valuekey` varchar(200) DEFAULT NULL COMMENT '有效性验证值',
`implement` text DEFAULT NULL COMMENT '推送命令详情',
PRIMARY KEY (`itemid`),
KEY `monit04_objectname_index` (`objectname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='监控项';

#######################  监控项表  End    ##########################################
#######################   详细策略与关联对象关系表 START    ################################
-- kcm.strategy_config_object_relations definition
DROP TABLE IF EXISTS `strategy_config_object_relations`;
CREATE TABLE `strategy_config_object_relations` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `strategy_config_id` char(32) NOT NULL COMMENT '策略配置id',
    `object_type` int(10) unsigned NOT NULL COMMENT '关联对象类型',
    `object_id` char(32) NOT NULL COMMENT '关联对象id',
    `modification` datetime NOT NULL COMMENT '关联时间',
    `config_type` int(10) unsigned NOT NULL COMMENT '策略code',
    `version` varchar(16) NULL COMMENT '策略下发版本',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
#######################   详细策略与关联对象关系表 END    ################################
#######################   策略模板表 START    ################################
-- kcm.mode definition
DROP TABLE IF EXISTS `mode`;
-- kcm.mode definition
CREATE TABLE `mode` (
    `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板id',
    `name` varchar(32) NOT NULL COMMENT '模板名称',
    `name_client` varchar(32) NULL COMMENT '客户端所需模板英文名称',
    PRIMARY KEY (`id`),
    UNIQUE KEY `name_client_UN` (`name_client`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COMMENT = '模板表';
#######################   策略模板表 END    ################################

#######################   主机分组表 START    ################################
DROP TABLE IF EXISTS `terminal_host_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_host_group` (
    `id` char(32) NOT NULL COMMENT 'ID',
    `name` varchar(500) NOT NULL COMMENT '主机分组名称',
    `pid` varchar(32) DEFAULT NULL COMMENT '父节点ID',
    `order` int(10) unsigned NOT NULL COMMENT '显示顺序',
    `path_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '路径ID',
    `path` varchar(100) DEFAULT NULL COMMENT '分组路径',
    `created_by_user_id` int(10) unsigned NOT NULL COMMENT '创建用户ID',
    `creation_time` datetime(3) NOT NULL COMMENT '创建时间',
    `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '删除状态 0: 未删除 1: 已删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `path_id_UNIQUE` (`path_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '主机分组表';
#######################   主机分组表 END    ################################

#######################   终端主机-分组关联表 START    ################################
DROP TABLE IF EXISTS `terminal_host_group_relationships`;
CREATE TABLE IF NOT EXISTS `terminal_host_group_relationships` (
    `id` CHAR(32) NOT NULL COMMENT 'ID',
    `terminal_host_id` CHAR(32) NOT NULL COMMENT '终端主机ID, terminal_host.id',
    `group_id` CHAR(32) NOT NULL COMMENT '主机分组ID group.id',
    PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4 COMMENT = '终端主机-分组关联表';
#######################   终端主机-分组关联表 END    ################################

#######################   管理员-终端分组关联表 START    ################################
DROP TABLE IF EXISTS `admin_group_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_group_relationships` (
    `id` char(32) NOT NULL COMMENT 'ID',
    `admin_user_id` int(11) NOT NULL COMMENT '管理员用户ID users.id',
    `group_id` char(32) NOT NULL COMMENT '终端分组ID group.id',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '管理员-终端分组关联表';
insert INTO
terminal_host_group
values
(
    '1',
    'root',
    null,
    0,
    '1',
    ',1',
    0,
    now(),
    0
);
#######################   管理员-终端分组关联表 END    ################################
#######################   级联表 START    ################################
DROP TABLE IF EXISTS `stairs_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `stairs_app` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '级联表自增主键',
`name` varchar(40) NOT NULL COMMENT '级联节点名称',
`url` varchar(40) NOT NULL COMMENT '级联节点url',
`port` int(10) unsigned NOT NULL COMMENT '级联节点端口',
`app_type` enum('down', 'up') NOT NULL COMMENT '级联节点类型（down:下级节点，up：上级节点）',
`status` enum('default', 'passed', 'refused', 'delete') NOT NULL DEFAULT 'default' COMMENT '级联节点类型（low:下级节点，high：上级节点）',
`created_time` datetime NOT NULL COMMENT '申请时间',
`key` enum('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '是否拥有秘钥',
`controllable` enum('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '是否可控制',
`comment` varchar(256) DEFAULT NULL COMMENT '备注',
`app_uid` varchar(32) NOT NULL COMMENT '请求唯一标识',
`aes_key` varchar(32) DEFAULT NULL COMMENT '用于信息堆成加密的key',
`points` int(10) unsigned NOT NULL COMMENT '审批的激活点数',
PRIMARY KEY (`id`),
UNIQUE KEY `name_unique` (`name`),
UNIQUE KEY `ip_unique` (`url`),
KEY `app_type_unique` (`app_type`)
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8mb4 COMMENT = '级联表';
#######################   级联表 END    ################################
#######################   数据源表 START    ################################
DROP TABLE IF EXISTS `data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `data_source` (
`id` TINYINT(4) unsigned NOT NULL AUTO_INCREMENT COMMENT '数据源表表自增主键',
`ds_name` char(32) NOT NULL COMMENT '数据源名称',
`ds_adress` varchar(100)  COMMENT '数据源地址',
`ds_port` int(10) COMMENT '数据源地址',
`admin_DN` varchar(255) NOT NULL COMMENT '管理员DN',
`password` CHAR(10) NOT NULL COMMENT '密码',
`search_rule` varchar(255) COMMENT '搜索规则',
`basic_DN` varchar(255) COMMENT '基础DN',
`sync_interval` varchar(32) COMMENT '同步周期',
`ds_type` int(4) COMMENT '数据源类型，例如：ldap、windwosAD。',
`status` char(1) NOT NULL COMMENT '同步协议状态',
`principal` char(64) COMMENT '查询主体',
PRIMARY KEY (`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COMMENT = '数据源表';
#######################   数据源表 END    ################################
########################   周期执行脚本列表 start  #########################################
DROP TABLE IF EXISTS `script_loop`;
CREATE TABLE `script_loop`(
`id` VARCHAR(32) NOT NULL primary key COMMENT 'uuid',
`main_id` VARCHAR(32) COMMENT '主任务ID',
`name` VARCHAR(40) COMMENT '脚本名称',
`devsn` VARCHAR(30) COMMENT '设备SN',
`dest` VARCHAR(100) COMMENT '文件路径',
`create_time` DATETIME COMMENT 'create time',
`delete_flag` TINYINT UNSIGNED COMMENT '删除状态0：未删除，1：已删除',
`create_admin` VARCHAR(32) COMMENT '创建人',
KEY `delete_flag_UNIQUE` (`delete_flag`),
KEY `create_admin_UNIQUE` (`create_admin`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '周期执行脚本列表';
--
-- Table structure for table `search_time`
--

DROP TABLE IF EXISTS `search_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_time` (
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '唯一标识id',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '指定查询的数据类别',
  `query_start_time` datetime NOT NULL COMMENT '增量同步查询的开始时间',
  `update_start_time` datetime DEFAULT NULL COMMENT '更新的开始查询时间',
  `delete_start_time` datetime DEFAULT NULL COMMENT '删除操作开始查询时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `search_time_type_uindex` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='增量查询时间表';
/*!40101 SET character_set_client = @saved_cs_client */;

#######################   周期执行脚本列表 end  #########################################

########################   windows_sync表 start  #########################################
DROP TABLE IF EXISTS `windows_sync_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `windows_sync_protocol` (
    `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '唯一标识',
    `protocolName` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '同步协议名称',
    `hostname` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '同步的主机',
    `adminPassword` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '远程用户dn的密码',
    `cert` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'kim服务器上ad证书的路径',
    `dn` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '远程的用户dn',
    `mode` int(11) NOT NULL COMMENT '0为自动同步，1为手动同步',
    `endTime` datetime DEFAULT NULL COMMENT '自动同步截止时间',
    `forward` int(11) DEFAULT NULL COMMENT '是否转发认证，0是，1否',
    `userPassword` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '不做转发认证时的默认密码',
    `interval` int(11) DEFAULT NULL COMMENT '自动同步间隔时间',
    `createTime` datetime DEFAULT NULL COMMENT '同步协议创建时间',
    `syncTime` datetime DEFAULT NULL COMMENT '最近一次的同步时间',
    `directory` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '要同步的组织目录',
    `user_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
    `certContent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'AD证书',
    PRIMARY KEY (`id`),
    UNIQUE KEY `windows_sync_protocol_host_uindex` (`hostname`),
    UNIQUE KEY `windows_sync_protocol_id_uindex` (`id`),
    UNIQUE KEY `windows_sync_protocol_name_uindex` (`protocolName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='windowsAD同步协议配置表';
#######################   windows_sync表 end  #########################################

#######################   终端主机在线表 START    ################################
--
-- Table structure for table `terminal_host_online`
--
DROP TABLE IF EXISTS `terminal_host_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terminal_host_online` (
    `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `terminal_host_id` char(32) NOT NULL COMMENT '终端主机UUID',
    `last_online_time` datetime DEFAULT NULL COMMENT '最后在线时间',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '终端主机在线表';
ALTER TABLE
    terminal_host_online
ADD
    UNIQUE INDEX terminal_host_id_UNIQUE (terminal_host_id);

#######################   终端主机在线表 END    ################################
