/*
MySQL Data Transfer
Source Host: localhost
Source Database: perssoftweb
Target Host: localhost
Target Database: perssoftweb
Date: 2014/7/30 8:42:12
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for admin
-- ----------------------------
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `lastloginip` varchar(255) DEFAULT NULL,
  `lastlogintime` datetime DEFAULT NULL,
  `isdelete` int(11) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
CREATE TABLE `admin_role` (
  `adminid` int(11) NOT NULL DEFAULT '0',
  `roleid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`adminid`,`roleid`),
  KEY `FKA7735425F61A73DF` (`roleid`),
  KEY `FKA773542536403BA1` (`adminid`),
  KEY `FK2902EF662CAF43AA` (`roleid`),
  KEY `FK2902EF66D2456536` (`adminid`),
  CONSTRAINT `admin_role_ibfk_1` FOREIGN KEY (`adminid`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admin_role_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descn` varchar(255) DEFAULT NULL,
  `isdelete` int(11) DEFAULT NULL,
  `isleaf` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1AA57096DCC558BE` (`parentid`),
  CONSTRAINT `FK1AA57096DCC558BE` FOREIGN KEY (`parentid`) REFERENCES `dictionary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for resource
-- ----------------------------
CREATE TABLE `resource` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `restype` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `resstring` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `descn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pid` int(10) DEFAULT NULL,
  `ordernum` int(10) NOT NULL,
  `leaf` int(10) DEFAULT NULL,
  `openType` varchar(10) DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1A51B40E38C5B4F1` (`pid`) USING BTREE,
  KEY `FKEBABC40E7587A73C` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE `role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `descn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
CREATE TABLE `role_resource` (
  `roleid` int(10) NOT NULL,
  `resourceid` int(10) NOT NULL,
  PRIMARY KEY (`roleid`,`resourceid`),
  KEY `FK_ROLERESOURCE_RESOURCE1` (`resourceid`) USING BTREE,
  KEY `FKB5684F61A73DF` (`roleid`) USING BTREE,
  KEY `FKAEE599B72CAF43AA` (`roleid`) USING BTREE,
  KEY `FKAEE599B72550FB5A` (`resourceid`) USING BTREE,
  CONSTRAINT `role_resource_ibfk_3` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_resource_ibfk_4` FOREIGN KEY (`resourceid`) REFERENCES `resource` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '202CB962AC59075B964B07152D234B70', '张三', '0', null, null, '0', null);
INSERT INTO `admin` VALUES ('8', 'zhangsan', '202CB962AC59075B964B07152D234B70', 'zhangsan', '0', null, null, '0', '1111');
INSERT INTO `admin` VALUES ('9', '11', '202CB962AC59075B964B07152D234B70', '11', '0', null, null, '1', '11');
INSERT INTO `admin` VALUES ('10', '11111', '202CB962AC59075B964B07152D234B70', '111', '0', null, null, '0', '11');
INSERT INTO `admin_role` VALUES ('1', '1');
INSERT INTO `admin_role` VALUES ('8', '2');
INSERT INTO `admin_role` VALUES ('9', '2');
INSERT INTO `admin_role` VALUES ('10', '3');
INSERT INTO `dictionary` VALUES ('41', '俄我', '0', '0', '计量单位', '1', null);
INSERT INTO `dictionary` VALUES ('42', null, '1', '1', '千克', null, '41');
INSERT INTO `dictionary` VALUES ('43', null, '0', '1', '箱', null, '41');
INSERT INTO `dictionary` VALUES ('44', null, '0', '1', '盒', null, '41');
INSERT INTO `dictionary` VALUES ('45', '去去去', '0', '0', '客户类别', '2', null);
INSERT INTO `dictionary` VALUES ('46', null, '0', '1', '格林豪泰', '1', '45');
INSERT INTO `dictionary` VALUES ('47', null, '0', '0', '合作模式', '3', null);
INSERT INTO `dictionary` VALUES ('48', null, '0', '1', '现款', '1', '47');
INSERT INTO `dictionary` VALUES ('49', null, '0', '1', '经营模式', '4', null);
INSERT INTO `dictionary` VALUES ('50', null, '0', '1', '现款', '1', '49');
INSERT INTO `dictionary` VALUES ('51', null, '0', '0', '商品类型', '5', null);
INSERT INTO `dictionary` VALUES ('52', null, '1', '1', '保健品', '1', '51');
INSERT INTO `dictionary` VALUES ('53', null, '0', '1', '职务', '6', null);
INSERT INTO `dictionary` VALUES ('54', null, '0', '1', '店长', '1', '53');
INSERT INTO `dictionary` VALUES ('55', null, '0', '1', '高级值班经理', '2', '53');
INSERT INTO `dictionary` VALUES ('56', null, '0', '1', '会计', '3', '53');
INSERT INTO `dictionary` VALUES ('57', null, '0', '1', '银行名称', '7', null);
INSERT INTO `dictionary` VALUES ('58', null, '0', '1', '中国银行', '1', '57');
INSERT INTO `dictionary` VALUES ('59', null, '0', '1', '资金科目', '8', null);
INSERT INTO `dictionary` VALUES ('60', null, '1', '1', '办公用品', '1', '59');
INSERT INTO `dictionary` VALUES ('61', null, '1', null, '条', null, '41');
INSERT INTO `dictionary` VALUES ('62', null, '0', null, '个', null, '41');
INSERT INTO `dictionary` VALUES ('63', null, '0', '0', '体积', '9', null);
INSERT INTO `dictionary` VALUES ('64', '约30cm*30cm*30cm', '0', '1', '30cm*30cm*30cm', '1', '63');
INSERT INTO `dictionary` VALUES ('65', '50cm*50cm*50cm', '0', '1', '50cm*50cm*50cm', '2', '63');
INSERT INTO `dictionary` VALUES ('66', null, '1', '1', '3㎡', '3', '63');
INSERT INTO `dictionary` VALUES ('67', null, '0', '0', '重量', '10', null);
INSERT INTO `dictionary` VALUES ('68', null, '0', '1', '1-10KG', '1', '67');
INSERT INTO `dictionary` VALUES ('69', null, '0', '1', '11-20KG', '1', '67');
INSERT INTO `dictionary` VALUES ('70', null, '1', null, '电子产品', null, '51');
INSERT INTO `dictionary` VALUES ('71', null, '0', null, '科技产品', null, '51');
INSERT INTO `dictionary` VALUES ('72', null, '0', null, '办公用品', null, '51');
INSERT INTO `dictionary` VALUES ('73', null, '0', null, '洗化用品', null, '51');
INSERT INTO `dictionary` VALUES ('74', null, '0', null, '箱包', null, '51');
INSERT INTO `dictionary` VALUES ('75', null, '0', null, '总经理', null, '53');
INSERT INTO `dictionary` VALUES ('76', null, '0', null, '锦江之星', null, '45');
INSERT INTO `dictionary` VALUES ('77', null, '0', null, '汉庭', null, '45');
INSERT INTO `dictionary` VALUES ('78', null, '0', null, '七天', null, '45');
INSERT INTO `dictionary` VALUES ('79', null, '0', null, '代销', null, '49');
INSERT INTO `dictionary` VALUES ('80', '2周账期', '0', null, '账期一', null, '47');
INSERT INTO `dictionary` VALUES ('81', '账期1个月', '1', null, '账期二', null, '47');
INSERT INTO `dictionary` VALUES ('82', '押一付一', '0', null, '账期二', null, '47');
INSERT INTO `dictionary` VALUES ('83', null, '0', null, '中国建设银行', null, '57');
INSERT INTO `dictionary` VALUES ('84', null, '0', null, '中国农业银行', null, '57');
INSERT INTO `dictionary` VALUES ('85', null, '0', null, '招商银行', null, '57');
INSERT INTO `dictionary` VALUES ('86', '采购', '0', null, '固定资产', null, '59');
INSERT INTO `dictionary` VALUES ('87', null, '0', null, '采购（商品）', null, '59');
INSERT INTO `dictionary` VALUES ('88', null, '0', '0', '业务类别', '11', null);
INSERT INTO `dictionary` VALUES ('89', '商品、现款商品、物料等——回款', '0', null, '销售', null, '88');
INSERT INTO `dictionary` VALUES ('90', '商品、现款商品、办公用品、物料等——支出', '0', null, '采购', null, '88');
INSERT INTO `dictionary` VALUES ('91', '商品、现款商品、办公用品、物料等——收入', '0', null, '退货', null, '88');
INSERT INTO `dictionary` VALUES ('92', null, '0', null, '套', null, '41');
INSERT INTO `dictionary` VALUES ('93', null, '0', null, '辆', null, '41');
INSERT INTO `dictionary` VALUES ('94', null, '0', null, '双', null, '41');
INSERT INTO `dictionary` VALUES ('95', null, '0', null, '把', null, '41');
INSERT INTO `dictionary` VALUES ('96', null, '0', null, '袋', null, '41');
INSERT INTO `dictionary` VALUES ('97', null, '0', null, '瓶', null, '41');
INSERT INTO `dictionary` VALUES ('98', null, '0', null, '支', null, '41');
INSERT INTO `dictionary` VALUES ('99', null, '0', null, '副', null, '41');
INSERT INTO `dictionary` VALUES ('100', null, '0', null, '银座佳驿', null, '45');
INSERT INTO `dictionary` VALUES ('101', null, '0', null, '如家', null, '45');
INSERT INTO `dictionary` VALUES ('102', null, '0', null, '本地', null, '45');
INSERT INTO `dictionary` VALUES ('103', null, '0', null, '生活用品', null, '51');
INSERT INTO `dictionary` VALUES ('104', null, '0', null, '汽车用品', null, '51');
INSERT INTO `dictionary` VALUES ('105', null, '0', null, '礼品', null, '51');
INSERT INTO `dictionary` VALUES ('106', null, '1', null, '礼品', null, '51');
INSERT INTO `dictionary` VALUES ('107', null, '0', null, '玩具', null, '51');
INSERT INTO `dictionary` VALUES ('108', null, '0', null, '内勤', null, '53');
INSERT INTO `dictionary` VALUES ('109', null, '0', null, '经理', null, '53');
INSERT INTO `dictionary` VALUES ('110', null, '0', null, '业主', null, '53');
INSERT INTO `dictionary` VALUES ('111', null, '0', null, '中国工商银行', null, '57');
INSERT INTO `dictionary` VALUES ('112', null, '0', null, '山东农商银行', null, '57');
INSERT INTO `dictionary` VALUES ('113', null, '0', null, '交通银行', null, '57');
INSERT INTO `dictionary` VALUES ('114', null, '0', null, '中信银行', null, '57');
INSERT INTO `dictionary` VALUES ('115', null, '0', null, '民生银行', null, '57');
INSERT INTO `dictionary` VALUES ('116', null, '0', null, '中国邮政储蓄银行', null, '57');
INSERT INTO `dictionary` VALUES ('117', null, '0', null, '上海浦发银行', null, '57');
INSERT INTO `dictionary` VALUES ('118', null, '0', null, '其他', null, '57');
INSERT INTO `dictionary` VALUES ('119', '用于采购办公用品', '0', null, '办公费用', null, '59');
INSERT INTO `dictionary` VALUES ('120', null, '0', null, '管理费', null, '59');
INSERT INTO `dictionary` VALUES ('121', 'A-C之间的交易，或者是零售。', '1', null, '现款（商品）', null, '59');
INSERT INTO `dictionary` VALUES ('122', 'A-B之间交易', '0', null, '销售（商品）', null, '59');
INSERT INTO `dictionary` VALUES ('123', '员工、会计', '0', null, '人力资源费用', null, '59');
INSERT INTO `dictionary` VALUES ('124', 'A-B之间的交易', '1', null, '现款（物料）', null, '59');
INSERT INTO `dictionary` VALUES ('125', null, '0', null, '广告费用', null, '59');
INSERT INTO `dictionary` VALUES ('126', null, '0', null, '退货（商品）', null, '59');
INSERT INTO `dictionary` VALUES ('127', '利息等', '1', null, '非销售盈利', null, '59');
INSERT INTO `dictionary` VALUES ('128', '快递费、物流费、包车费等', '0', null, '运费', null, '59');
INSERT INTO `dictionary` VALUES ('129', null, '1', null, '采购（物料）', null, '59');
INSERT INTO `dictionary` VALUES ('130', null, '0', null, '采购（物料）', null, '59');
INSERT INTO `dictionary` VALUES ('131', null, '0', null, '销售（物料）', null, '59');
INSERT INTO `dictionary` VALUES ('132', null, '0', null, '采购（礼品）', null, '59');
INSERT INTO `dictionary` VALUES ('133', null, '0', null, '销售（礼品）', null, '59');
INSERT INTO `dictionary` VALUES ('134', null, '0', null, '采购（现款商品）', null, '59');
INSERT INTO `dictionary` VALUES ('135', '回款', '0', null, '销售（现款商品）', null, '59');
INSERT INTO `dictionary` VALUES ('136', null, '1', null, '报损（商品）', null, '88');
INSERT INTO `dictionary` VALUES ('137', null, '0', null, '退货（物料）', null, '59');
INSERT INTO `dictionary` VALUES ('138', null, '0', null, '退货（礼品）', null, '59');
INSERT INTO `dictionary` VALUES ('139', null, '0', null, '销售退货（现款商品）', null, '59');
INSERT INTO `dictionary` VALUES ('140', '一个月账期', '0', null, '账期三', null, '47');
INSERT INTO `dictionary` VALUES ('141', null, '1', null, '税款', null, '59');
INSERT INTO `dictionary` VALUES ('142', null, '0', null, '21-30KG', null, '67');
INSERT INTO `dictionary` VALUES ('143', null, '1', null, '销售（办公用品）', null, '88');
INSERT INTO `dictionary` VALUES ('144', null, '1', null, '采购（办公用品）', null, '88');
INSERT INTO `dictionary` VALUES ('145', null, '1', null, '销售（礼品）', null, '88');
INSERT INTO `dictionary` VALUES ('146', null, '1', null, '采购（礼品）', null, '88');
INSERT INTO `dictionary` VALUES ('147', null, '0', null, '家用电器', null, '51');
INSERT INTO `dictionary` VALUES ('148', null, '0', null, '总经理助理', null, '53');
INSERT INTO `dictionary` VALUES ('149', '商品、现款商品、办公用品、物料等——指客户退回的业务', '0', null, '销售退货', null, '88');
INSERT INTO `dictionary` VALUES ('150', '指客户退回的商品', '0', null, '销售退货（商品）', null, '59');
INSERT INTO `dictionary` VALUES ('151', null, '0', null, '其他', null, '59');
INSERT INTO `dictionary` VALUES ('152', null, '0', null, '其他', null, '88');
INSERT INTO `dictionary` VALUES ('153', null, '1', null, '采购（物料）', null, '88');
INSERT INTO `dictionary` VALUES ('154', null, '1', null, '销售（物料）', null, '88');
INSERT INTO `dictionary` VALUES ('155', null, '0', null, '非营业支出', null, '88');
INSERT INTO `dictionary` VALUES ('156', '利息等', '0', null, '非营业收入', null, '88');
INSERT INTO `dictionary` VALUES ('157', '运费等——支出', '0', null, '运营成本', null, '88');
INSERT INTO `dictionary` VALUES ('158', '1', null, null, '1', null, '41');
INSERT INTO `dictionary` VALUES ('159', '22', null, null, '22', null, '41');
INSERT INTO `dictionary` VALUES ('160', '1', null, null, '1', null, '41');
INSERT INTO `dictionary` VALUES ('161', '11', null, null, '11', null, '41');
INSERT INTO `dictionary` VALUES ('162', '11', '1', null, '111', null, '41');
INSERT INTO `dictionary` VALUES ('163', '1', '1', null, '1', null, '41');
INSERT INTO `resource` VALUES ('1', '系统维护', 'url', null, null, null, '9', '0', null, null);
INSERT INTO `resource` VALUES ('2', '账号信息', 'url', 'system/admin.do', null, '1', '3', '1', 'tab', null);
INSERT INTO `resource` VALUES ('3', '角色管理', 'url', 'system/role.do', null, '1', '4', '1', 'tab', null);
INSERT INTO `resource` VALUES ('6', '数据字典', 'url', 'system/dictionary.do', null, '1', '6', '1', 'tab', null);
INSERT INTO `role` VALUES ('1', '超级管理员', '负责整个系统的管理');
INSERT INTO `role` VALUES ('2', '加盟商管理员', '不可删除');
INSERT INTO `role` VALUES ('3', '零售商管理员', '不可删除');
INSERT INTO `role` VALUES ('4', '啊', '啊');
INSERT INTO `role_resource` VALUES ('1', '1');
INSERT INTO `role_resource` VALUES ('2', '1');
INSERT INTO `role_resource` VALUES ('1', '2');
INSERT INTO `role_resource` VALUES ('2', '2');
INSERT INTO `role_resource` VALUES ('1', '3');
INSERT INTO `role_resource` VALUES ('2', '3');
INSERT INTO `role_resource` VALUES ('1', '6');
INSERT INTO `role_resource` VALUES ('2', '6');
