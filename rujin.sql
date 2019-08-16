/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : rujin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2017-09-11 14:34:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `buycontract`
-- ----------------------------
DROP TABLE IF EXISTS `buycontract`;
CREATE TABLE `buycontract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL COMMENT '采购合同编号',
  `provideid` int(11) DEFAULT NULL COMMENT '供应商id',
  `providername` varchar(20) DEFAULT NULL COMMENT '供应商',
  `dt` date DEFAULT NULL COMMENT '签订日期',
  `providperson` varchar(20) DEFAULT NULL COMMENT '供应人员',
  `materialname` varchar(20) DEFAULT NULL COMMENT '物料名称',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `changeplacenumber` varchar(20) DEFAULT NULL COMMENT '坯布流转编号',
  `userid` int(11) DEFAULT NULL COMMENT '员工id',
  `type` int(11) DEFAULT NULL COMMENT '类型0-物料合同 1-印染合同 2-加工合同 3-运输合同',
  `materialid` int(11) DEFAULT NULL COMMENT '物料id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buycontract
-- ----------------------------
INSERT INTO `buycontract` VALUES ('1', '123', null, '苹果', '2016-03-17', '123', '苹果10', '1.00', '2.00', '1.00', '1', null, '1', '1');
INSERT INTO `buycontract` VALUES ('2', '1', null, null, '2016-03-21', null, null, null, '2.00', null, '1', '2', null, null);

-- ----------------------------
-- Table structure for `buyinvoice`
-- ----------------------------
DROP TABLE IF EXISTS `buyinvoice`;
CREATE TABLE `buyinvoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cnumber` varchar(20) DEFAULT NULL COMMENT '采购合同编号',
  `number` varchar(20) DEFAULT NULL COMMENT '采购发票号码',
  `provider` varchar(20) DEFAULT NULL COMMENT '供应商',
  `dt` date DEFAULT NULL COMMENT '票据日期',
  `materialid` int(11) DEFAULT NULL COMMENT '物料id',
  `materialname` varchar(20) DEFAULT NULL COMMENT '物料名称',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `tax` decimal(10,2) DEFAULT NULL COMMENT '税额',
  `backtax` decimal(10,2) DEFAULT NULL COMMENT '退税额',
  `realback` decimal(10,2) DEFAULT NULL COMMENT '退税实收',
  `backdate` date DEFAULT NULL COMMENT '退税日期',
  `unbacktax` decimal(10,2) DEFAULT NULL COMMENT '未退税额',
  `customsnumber` varchar(20) DEFAULT NULL COMMENT '海关单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buyinvoice
-- ----------------------------
INSERT INTO `buyinvoice` VALUES ('1', '123', '123', 'rujin', '2016-03-17', '1', '苹果10', '1.00', '2.00', '1.00', '1.00', '1.00', '1.00', '2016-03-16', '0.00', '00A');

-- ----------------------------
-- Table structure for `buypayapply`
-- ----------------------------
DROP TABLE IF EXISTS `buypayapply`;
CREATE TABLE `buypayapply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `changeplacenumber` varchar(20) DEFAULT NULL COMMENT '坯布流转编号',
  `number` varchar(20) DEFAULT NULL COMMENT '付款申请单号',
  `unit` varchar(20) DEFAULT NULL COMMENT '收款单位',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `reason` varchar(50) DEFAULT NULL COMMENT '事由',
  `applyman` varchar(20) DEFAULT NULL COMMENT '申请人',
  `approveman` varchar(20) DEFAULT NULL COMMENT '核准人',
  `type` int(11) DEFAULT NULL COMMENT '付款方式0-现金 1-现金转账支票 2-银行转账支票 3-电子银行转账 4-协议转账 5-其他',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buypayapply
-- ----------------------------
INSERT INTO `buypayapply` VALUES ('1', '13', '123', '如锦', '1.00', '卖', '我', '你', '2');
INSERT INTO `buypayapply` VALUES ('2', '13', '1', '天诺', '2.50', '无', '我', '你', '0');
INSERT INTO `buypayapply` VALUES ('3', '13', '2', null, '10.00', null, null, null, null);

-- ----------------------------
-- Table structure for `changeplace`
-- ----------------------------
DROP TABLE IF EXISTS `changeplace`;
CREATE TABLE `changeplace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL COMMENT '坯布流转编号',
  `factory` varchar(20) DEFAULT NULL COMMENT '受托工厂',
  `materialid` int(11) DEFAULT NULL COMMENT '物料id',
  `materialname` varchar(20) DEFAULT NULL COMMENT '物料名称',
  `deal` decimal(10,2) DEFAULT NULL COMMENT '约定数量',
  `elongation` float(10,2) DEFAULT NULL COMMENT '伸长率',
  `real` decimal(10,2) DEFAULT NULL COMMENT '实际数量',
  `cnumber` varchar(20) DEFAULT NULL COMMENT '采购合同编号',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of changeplace
-- ----------------------------
INSERT INTO `changeplace` VALUES ('1', '13', '123', '1', '苹果10', '1.00', '1.00', '1.00', '123', null);
INSERT INTO `changeplace` VALUES ('2', '1', null, null, null, null, null, '2.00', '123', '1');

-- ----------------------------
-- Table structure for `costs`
-- ----------------------------
DROP TABLE IF EXISTS `costs`;
CREATE TABLE `costs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL COMMENT '日期',
  `name` varchar(20) DEFAULT NULL COMMENT '费用名称',
  `style` varchar(20) DEFAULT NULL COMMENT '计量单位',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `cnumber` varchar(20) DEFAULT NULL COMMENT '销售合同编号',
  `type` int(2) DEFAULT '0' COMMENT '0-成本费用 1-特殊费用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of costs
-- ----------------------------
INSERT INTO `costs` VALUES ('1', '2016-03-19', '采购', '吨', '1.00', '1.00', '1.23', '666666', '0');
INSERT INTO `costs` VALUES ('2', '2016-03-19', '买菜', null, null, null, '1.00', null, '1');
INSERT INTO `costs` VALUES ('3', '2016-03-26', '运费', '车', '1.50', '2.00', '3.00', '666666', '0');

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `tel` varchar(50) DEFAULT NULL COMMENT '电话',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  `file` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '天诺', '潍坊', '123456', 'perssoft', null);

-- ----------------------------
-- Table structure for `material`
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL COMMENT '物资材料编码',
  `name` varchar(255) DEFAULT NULL COMMENT '物资材料名称',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('1', '123', '苹果10', '即将上市');

-- ----------------------------
-- Table structure for `moneytype`
-- ----------------------------
DROP TABLE IF EXISTS `moneytype`;
CREATE TABLE `moneytype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '外币代码',
  `name` varchar(255) DEFAULT NULL COMMENT '外币名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moneytype
-- ----------------------------
INSERT INTO `moneytype` VALUES ('1', 'my', '美元');
INSERT INTO `moneytype` VALUES ('2', 'oy', '欧元');

-- ----------------------------
-- Table structure for `outroom`
-- ----------------------------
DROP TABLE IF EXISTS `outroom`;
CREATE TABLE `outroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productnumber` varchar(20) DEFAULT NULL COMMENT '货号',
  `productid` int(11) DEFAULT NULL COMMENT '产品id',
  `productname` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `style` varchar(20) DEFAULT NULL COMMENT '计量单位',
  `inch` decimal(10,2) DEFAULT NULL COMMENT '英寸',
  `mount` int(11) DEFAULT NULL COMMENT '数量',
  `boxmount` int(11) DEFAULT NULL COMMENT '箱数',
  `boxin` int(11) DEFAULT NULL COMMENT '箱入（条）',
  `netweight` decimal(10,2) DEFAULT NULL COMMENT '净重（kg）',
  `gw` decimal(10,2) DEFAULT NULL COMMENT '毛重(kg)',
  `boxstyle` varchar(20) DEFAULT NULL COMMENT '纸箱尺寸',
  `boxnumber` varchar(10) DEFAULT NULL COMMENT '箱号',
  `borrow` varchar(10) DEFAULT NULL COMMENT '借用',
  `number` varchar(20) DEFAULT NULL COMMENT '出库单编号',
  `snumber` varchar(20) DEFAULT NULL COMMENT '入库单编号',
  `dt` date DEFAULT NULL COMMENT '日期',
  `left` varchar(50) DEFAULT NULL COMMENT '产品剩余',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of outroom
-- ----------------------------
INSERT INTO `outroom` VALUES ('1', '1', '1', '上衣', '1', '1.00', '1', '1', '1', '1.00', '1.00', '1', '1', '1', '123', '123', '2016-03-19', null, null);

-- ----------------------------
-- Table structure for `paytype`
-- ----------------------------
DROP TABLE IF EXISTS `paytype`;
CREATE TABLE `paytype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '结算方式',
  `code` varchar(255) DEFAULT NULL COMMENT '代码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paytype
-- ----------------------------
INSERT INTO `paytype` VALUES ('1', '现金', 'xj');

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL COMMENT '产品编码',
  `name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '001', '上衣', '一等品，霸占市场');

-- ----------------------------
-- Table structure for `provider`
-- ----------------------------
DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) DEFAULT NULL COMMENT '供应商编号',
  `name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `tel` varchar(50) DEFAULT NULL COMMENT '电话',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of provider
-- ----------------------------
INSERT INTO `provider` VALUES ('1', null, '苹果', 'America', '123456', '死鬼');

-- ----------------------------
-- Table structure for `receipt`
-- ----------------------------
DROP TABLE IF EXISTS `receipt`;
CREATE TABLE `receipt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL COMMENT '收料单编号',
  `providerid` int(11) DEFAULT NULL COMMENT '供应商id',
  `providername` varchar(20) DEFAULT NULL COMMENT '供应商',
  `materialid` int(11) DEFAULT NULL COMMENT '物料id',
  `materialname` varchar(20) DEFAULT NULL COMMENT '物料名称',
  `style` varchar(20) DEFAULT NULL COMMENT '计量单位',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `meters` decimal(10,2) DEFAULT NULL COMMENT '数量（米）',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量（件）',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `dt` date DEFAULT NULL COMMENT '日期',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of receipt
-- ----------------------------
INSERT INTO `receipt` VALUES ('1', '123', '1', '苹果', '1', '苹果10', '个', '1.00', '1.20', '2.00', '1.00', '2016-03-19', null);

-- ----------------------------
-- Table structure for `samples`
-- ----------------------------
DROP TABLE IF EXISTS `samples`;
CREATE TABLE `samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL COMMENT '客户id',
  `customername` varchar(20) DEFAULT NULL COMMENT '客户',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `sendtype` varchar(20) DEFAULT NULL COMMENT '运送方式',
  `transfee` decimal(10,2) DEFAULT NULL COMMENT '运费',
  `type` varchar(20) DEFAULT NULL COMMENT '样品归类',
  `number` varchar(20) DEFAULT NULL COMMENT '样品编号',
  `dt` date DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of samples
-- ----------------------------
INSERT INTO `samples` VALUES ('1', '1', '天诺', '1.00', '飞机', '1.00', '很好', '123', '2016-03-19');

-- ----------------------------
-- Table structure for `sellcontract`
-- ----------------------------
DROP TABLE IF EXISTS `sellcontract`;
CREATE TABLE `sellcontract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL COMMENT '合同编号',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `dt` date DEFAULT NULL COMMENT '交货日期',
  `signdate` date DEFAULT NULL COMMENT '签订日期',
  `sellperson` varchar(20) DEFAULT NULL COMMENT '销售人员',
  `customername` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `customerid` int(11) DEFAULT NULL COMMENT '客户id',
  `cnumber` varchar(20) DEFAULT NULL COMMENT '翻单',
  `userid` int(11) DEFAULT NULL COMMENT '用户ID',
  `productid` int(11) DEFAULT NULL COMMENT '产品id',
  `productname` varchar(255) DEFAULT NULL COMMENT '产品名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sellcontract
-- ----------------------------
INSERT INTO `sellcontract` VALUES ('4', '666666', '1.00', '1.00', '1.00', '2016-03-23', '2016-03-22', '我', '天诺', '1', null, '1', '1', '上衣');

-- ----------------------------
-- Table structure for `sellinvoice`
-- ----------------------------
DROP TABLE IF EXISTS `sellinvoice`;
CREATE TABLE `sellinvoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL COMMENT '销售发票编号',
  `cnumber` varchar(20) DEFAULT NULL COMMENT '销售合同编号',
  `productid` int(11) DEFAULT NULL COMMENT '产品id',
  `productname` varchar(30) DEFAULT NULL COMMENT '产品名称',
  `dt` date DEFAULT NULL COMMENT '票据日期',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `tax` decimal(10,2) DEFAULT NULL COMMENT '税额',
  `type` int(11) DEFAULT NULL COMMENT '发票类型0-普通发票 1-专用发票',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sellinvoice
-- ----------------------------
INSERT INTO `sellinvoice` VALUES ('1', '123', '666666', '1', '上衣', '2016-03-17', '1.00', '2.00', '1.00', '1.00', '0');
INSERT INTO `sellinvoice` VALUES ('2', '1', '666666', '1', '上衣', '2016-03-21', '1.00', '2.00', '2.00', '0.00', '1');

-- ----------------------------
-- Table structure for `sellpay`
-- ----------------------------
DROP TABLE IF EXISTS `sellpay`;
CREATE TABLE `sellpay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unitname` varchar(20) DEFAULT NULL COMMENT '付款单位',
  `number` varchar(20) DEFAULT NULL COMMENT '单据号码',
  `cnumber` varchar(20) DEFAULT NULL COMMENT '销售合同编号',
  `dt` date DEFAULT NULL COMMENT '日期',
  `foreignmoney` decimal(10,2) DEFAULT NULL COMMENT '外币金额',
  `money` decimal(10,2) DEFAULT NULL COMMENT '人民币',
  `banknumber` varchar(10) DEFAULT NULL COMMENT '银行业务编号',
  `moneytypeid` int(11) DEFAULT NULL COMMENT '外币类型id',
  `moneytypename` varchar(255) DEFAULT NULL COMMENT '外币名称',
  `paytype` int(11) DEFAULT NULL COMMENT '结算方式0-现金 1-现金转账支票 2-银行转账支票 3-电子银行转账 4-协议转账 5-其他',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sellpay
-- ----------------------------
INSERT INTO `sellpay` VALUES ('1', '如锦', '123', '666666', '2016-03-17', '123.00', '123.00', '123', '1', '美元', '2');
INSERT INTO `sellpay` VALUES ('2', '如锦', null, '666666', null, null, '10.00', null, null, null, '0');

-- ----------------------------
-- Table structure for `send`
-- ----------------------------
DROP TABLE IF EXISTS `send`;
CREATE TABLE `send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL COMMENT '日期',
  `factory` varchar(20) DEFAULT NULL COMMENT '加工厂',
  `materialid` int(11) DEFAULT NULL COMMENT '物料id',
  `materialname` varchar(20) DEFAULT NULL COMMENT '物料名称',
  `take` decimal(10,2) DEFAULT NULL COMMENT '领用数量（米）',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '开剪数量',
  `borrow` decimal(10,2) DEFAULT NULL COMMENT '借用',
  `number` varchar(20) DEFAULT NULL COMMENT '发料单编号',
  `rnumber` varchar(20) DEFAULT NULL COMMENT '收料单编号',
  `dh` varchar(20) DEFAULT NULL COMMENT '单耗（米/件）',
  `left` varchar(50) DEFAULT NULL COMMENT '物料剩余',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of send
-- ----------------------------
INSERT INTO `send` VALUES ('1', '2016-03-19', '我', '1', '苹果10', '1.00', '3.00', '0.00', '123', '123', '1/件', '20米', null);

-- ----------------------------
-- Table structure for `storage`
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL COMMENT '时间',
  `factory` varchar(20) DEFAULT NULL COMMENT '加工厂',
  `productid` int(11) DEFAULT NULL COMMENT '产品id',
  `productname` varchar(20) DEFAULT NULL COMMENT '产品名称',
  `style` varchar(20) DEFAULT NULL COMMENT '计量单位',
  `mount` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `number` varchar(20) DEFAULT NULL COMMENT '编号',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES ('1', '2016-03-19', '天诺', '1', '上衣', '1/个', '1.00', '123', null);

-- ----------------------------
-- Table structure for `xt_admin`
-- ----------------------------
DROP TABLE IF EXISTS `xt_admin`;
CREATE TABLE `xt_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(255) DEFAULT NULL,
  `lastlogintime` datetime DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `isforbidden` int(11) DEFAULT NULL,
  `isdelete` int(11) DEFAULT NULL,
  `pym` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xt_admin
-- ----------------------------
INSERT INTO `xt_admin` VALUES ('1', 'admin', '2013-09-10 10:39:14', '202CB962AC59075B964B07152D234B70', '管理员', '0', '0', 'admin');
INSERT INTO `xt_admin` VALUES ('2', 'lisi', null, '202CB962AC59075B964B07152D234B70', '李四', '0', '0', 'lisi');
INSERT INTO `xt_admin` VALUES ('21', '6666', null, 'FAE0B27C451C728867A567E8C1BB4E53', '6666', '1', '0', null);
INSERT INTO `xt_admin` VALUES ('22', '12112', null, '202CB962AC59075B964B07152D234B70', '12112', '0', '0', null);
INSERT INTO `xt_admin` VALUES ('23', '1335', null, '202CB962AC59075B964B07152D234B70', '3555', '1', '0', null);

-- ----------------------------
-- Table structure for `xt_admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `xt_admin_role`;
CREATE TABLE `xt_admin_role` (
  `adminid` int(11) NOT NULL DEFAULT '0',
  `roleid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`adminid`,`roleid`),
  KEY `FKA7735425F61A73DF` (`roleid`),
  KEY `FKA773542536403BA1` (`adminid`),
  KEY `FK2902EF662CAF43AA` (`roleid`),
  KEY `FK2902EF66D2456536` (`adminid`),
  CONSTRAINT `xt_admin_role_ibfk_1` FOREIGN KEY (`adminid`) REFERENCES `xt_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `xt_admin_role_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `xt_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xt_admin_role
-- ----------------------------
INSERT INTO `xt_admin_role` VALUES ('1', '1');
INSERT INTO `xt_admin_role` VALUES ('21', '1');
INSERT INTO `xt_admin_role` VALUES ('22', '1');
INSERT INTO `xt_admin_role` VALUES ('2', '2');
INSERT INTO `xt_admin_role` VALUES ('23', '2');

-- ----------------------------
-- Table structure for `xt_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `xt_dictionary`;
CREATE TABLE `xt_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descn` varchar(255) DEFAULT NULL,
  `isdelete` int(11) DEFAULT '0',
  `isleaf` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1AA57096DCC558BE` (`parentid`),
  CONSTRAINT `FK1AA57096DCC558BE` FOREIGN KEY (`parentid`) REFERENCES `xt_dictionary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xt_dictionary
-- ----------------------------
INSERT INTO `xt_dictionary` VALUES ('1', null, '0', '0', '采购合同类型', '1', null);
INSERT INTO `xt_dictionary` VALUES ('2', null, '0', null, '物料合同', null, '1');
INSERT INTO `xt_dictionary` VALUES ('3', null, '0', null, '印染合同', null, '1');
INSERT INTO `xt_dictionary` VALUES ('4', null, '0', null, '加工合同', null, '1');
INSERT INTO `xt_dictionary` VALUES ('5', null, '0', null, '运输合同', null, '1');
INSERT INTO `xt_dictionary` VALUES ('6', null, '0', null, '发票类型', '2', null);
INSERT INTO `xt_dictionary` VALUES ('7', null, '0', null, '专用发票', null, '6');
INSERT INTO `xt_dictionary` VALUES ('8', null, '0', null, '普通发票', null, '6');
INSERT INTO `xt_dictionary` VALUES ('9', null, '0', null, '付款方式', '3', null);
INSERT INTO `xt_dictionary` VALUES ('10', null, '0', null, '现金', null, '9');
INSERT INTO `xt_dictionary` VALUES ('11', null, '0', null, '现金转账支票', null, '9');
INSERT INTO `xt_dictionary` VALUES ('12', null, '0', null, '银行转账支票', null, '9');
INSERT INTO `xt_dictionary` VALUES ('13', null, '0', null, '电子银行转账', null, '9');
INSERT INTO `xt_dictionary` VALUES ('14', null, '0', null, '协议转账', null, '9');
INSERT INTO `xt_dictionary` VALUES ('15', null, '0', null, '其它', null, '9');

-- ----------------------------
-- Table structure for `xt_resource`
-- ----------------------------
DROP TABLE IF EXISTS `xt_resource`;
CREATE TABLE `xt_resource` (
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of xt_resource
-- ----------------------------
INSERT INTO `xt_resource` VALUES ('1', '系统维护', 'url', null, null, null, '6', '0', 'tab', 'images/icon06.png');
INSERT INTO `xt_resource` VALUES ('2', '账号信息', 'url', 'system/admin.do', null, '1', '3', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('3', '角色管理', 'url', 'system/role.do', null, '1', '4', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('6', '菜单管理', 'url', 'system/resource.do', null, '1', '6', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('16', '数据字典', 'url', 'system/dictionary.do', null, '1', '3', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('21', '员工管理', 'url', 'manager/worker.do', null, '1', '1', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('24', '销售模块', 'url', null, null, null, '2', '0', 'tab', 'images/icon02.png');
INSERT INTO `xt_resource` VALUES ('25', '采购模块', 'url', null, null, null, '3', '0', 'tab', 'images/icon03.png');
INSERT INTO `xt_resource` VALUES ('26', '物资收发', 'url', null, null, null, '4', '0', 'tab', 'images/icon04.png');
INSERT INTO `xt_resource` VALUES ('27', '成本费用', 'url', null, null, null, '5', '0', 'tab', 'images/icon05.png');
INSERT INTO `xt_resource` VALUES ('28', '销售合同管理', 'url', 'manager/sellcontract.do', null, '24', '1', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('29', '销售发票管理', 'url', 'manager/sellinvoice.do', null, '24', '2', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('30', '货款回收管理', 'url', 'manager/sellpay.do', null, '24', '3', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('31', '采购合同管理', 'url', 'manager/buycontract.do', null, '25', '1', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('32', '采购发票管理', 'url', 'manager/buyinvoice.do', null, '25', '2', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('33', '坯布流转管理', 'url', 'manager/changeplace.do', null, '25', '3', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('34', '付款申请单', 'url', 'manager/buypayapply.do', null, '25', '4', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('35', '收料单管理', 'url', 'manager/receipt.do', null, '26', '1', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('36', '发料单管理', 'url', 'manager/send.do', null, '26', '2', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('37', '入库单管理', 'url', 'manager/storage.do', null, '26', '3', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('38', '出库单管理', 'url', 'manager/out.do', null, '26', '4', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('39', '成本费用', 'url', 'manager/cost.do', null, '27', '1', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('40', '特殊费用', 'url', 'manager/cost/specialJSP.do', null, '27', '2', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('41', '样品发送', 'url', 'manager/sample.do', null, '26', '5', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('42', '基础数据', 'url', null, null, null, '1', '0', 'tab', 'images/icon01.png');
INSERT INTO `xt_resource` VALUES ('43', '客户管理', 'url', 'manager/customer.do', null, '42', '1', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('44', '供应商管理', 'url', 'manager/provider.do', null, '42', '2', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('45', '产成品管理', 'url', 'manager/product.do', null, '42', '3', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('46', '物资材料管理', 'url', 'manager/material.do', null, '42', '4', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('47', '外币种类管理', 'url', 'manager/moneytype.do', null, '42', '5', '1', 'tab', null);
INSERT INTO `xt_resource` VALUES ('49', '文件上传', 'url', 'manager/upload.do', null, '42', '6', '1', 'tab', null);

-- ----------------------------
-- Table structure for `xt_role`
-- ----------------------------
DROP TABLE IF EXISTS `xt_role`;
CREATE TABLE `xt_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `descn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of xt_role
-- ----------------------------
INSERT INTO `xt_role` VALUES ('1', '超级管理员', '负责整个系统的管理');
INSERT INTO `xt_role` VALUES ('2', '普通用户', '负责系统业务管理');

-- ----------------------------
-- Table structure for `xt_role_resource`
-- ----------------------------
DROP TABLE IF EXISTS `xt_role_resource`;
CREATE TABLE `xt_role_resource` (
  `roleid` int(10) NOT NULL,
  `resourceid` int(10) NOT NULL,
  PRIMARY KEY (`roleid`,`resourceid`),
  KEY `FK_ROLERESOURCE_RESOURCE1` (`resourceid`) USING BTREE,
  KEY `FKB5684F61A73DF` (`roleid`) USING BTREE,
  KEY `FKAEE599B72CAF43AA` (`roleid`) USING BTREE,
  KEY `FKAEE599B72550FB5A` (`resourceid`) USING BTREE,
  CONSTRAINT `xt_role_resource_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `xt_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `xt_role_resource_ibfk_2` FOREIGN KEY (`resourceid`) REFERENCES `xt_resource` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of xt_role_resource
-- ----------------------------
INSERT INTO `xt_role_resource` VALUES ('1', '1');
INSERT INTO `xt_role_resource` VALUES ('1', '2');
INSERT INTO `xt_role_resource` VALUES ('1', '3');
INSERT INTO `xt_role_resource` VALUES ('1', '6');
INSERT INTO `xt_role_resource` VALUES ('1', '16');
INSERT INTO `xt_role_resource` VALUES ('1', '21');
INSERT INTO `xt_role_resource` VALUES ('1', '24');
INSERT INTO `xt_role_resource` VALUES ('2', '24');
INSERT INTO `xt_role_resource` VALUES ('1', '25');
INSERT INTO `xt_role_resource` VALUES ('2', '25');
INSERT INTO `xt_role_resource` VALUES ('1', '26');
INSERT INTO `xt_role_resource` VALUES ('2', '26');
INSERT INTO `xt_role_resource` VALUES ('1', '27');
INSERT INTO `xt_role_resource` VALUES ('2', '27');
INSERT INTO `xt_role_resource` VALUES ('1', '28');
INSERT INTO `xt_role_resource` VALUES ('2', '28');
INSERT INTO `xt_role_resource` VALUES ('1', '29');
INSERT INTO `xt_role_resource` VALUES ('2', '29');
INSERT INTO `xt_role_resource` VALUES ('1', '30');
INSERT INTO `xt_role_resource` VALUES ('2', '30');
INSERT INTO `xt_role_resource` VALUES ('1', '31');
INSERT INTO `xt_role_resource` VALUES ('2', '31');
INSERT INTO `xt_role_resource` VALUES ('1', '32');
INSERT INTO `xt_role_resource` VALUES ('2', '32');
INSERT INTO `xt_role_resource` VALUES ('1', '33');
INSERT INTO `xt_role_resource` VALUES ('2', '33');
INSERT INTO `xt_role_resource` VALUES ('1', '34');
INSERT INTO `xt_role_resource` VALUES ('2', '34');
INSERT INTO `xt_role_resource` VALUES ('1', '35');
INSERT INTO `xt_role_resource` VALUES ('2', '35');
INSERT INTO `xt_role_resource` VALUES ('1', '36');
INSERT INTO `xt_role_resource` VALUES ('2', '36');
INSERT INTO `xt_role_resource` VALUES ('1', '37');
INSERT INTO `xt_role_resource` VALUES ('2', '37');
INSERT INTO `xt_role_resource` VALUES ('1', '38');
INSERT INTO `xt_role_resource` VALUES ('2', '38');
INSERT INTO `xt_role_resource` VALUES ('1', '39');
INSERT INTO `xt_role_resource` VALUES ('2', '39');
INSERT INTO `xt_role_resource` VALUES ('1', '40');
INSERT INTO `xt_role_resource` VALUES ('2', '40');
INSERT INTO `xt_role_resource` VALUES ('1', '41');
INSERT INTO `xt_role_resource` VALUES ('2', '41');
INSERT INTO `xt_role_resource` VALUES ('1', '42');
INSERT INTO `xt_role_resource` VALUES ('1', '43');
INSERT INTO `xt_role_resource` VALUES ('1', '44');
INSERT INTO `xt_role_resource` VALUES ('1', '45');
INSERT INTO `xt_role_resource` VALUES ('1', '46');
INSERT INTO `xt_role_resource` VALUES ('1', '47');
INSERT INTO `xt_role_resource` VALUES ('1', '49');

-- ----------------------------
-- Table structure for `yw_worker`
-- ----------------------------
DROP TABLE IF EXISTS `yw_worker`;
CREATE TABLE `yw_worker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gh` varchar(255) DEFAULT NULL COMMENT '员工编号',
  `tel` varchar(255) DEFAULT NULL COMMENT '电话',
  `sex` int(11) DEFAULT NULL COMMENT '性别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yw_worker
-- ----------------------------
INSERT INTO `yw_worker` VALUES ('5', '测试', '17', '123', '123', '1');
