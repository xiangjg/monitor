/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50546
Source Host           : localhost:3306
Source Database       : numysql

Target Server Type    : MYSQL
Target Server Version : 50546
File Encoding         : 65001

Date: 2017-01-10 16:15:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('0b28c0ef033647668635d10e87f3142f', 'xiangjg', '66de523df6272e5a56fd0d80c71ba65c6faf4902', '向敬光', '', '2', '2017-01-10 16:00:21', '0:0:0:0:0:0:0:1', '0', '', 'default', '1991887681@qq.com', '9', '18984898929');
INSERT INTO `sys_user` VALUES ('1', 'admin', 'de41b7fb99201d8334c23c014db35ecd92df81bc', '系统管理员', '1133671055321055258374707980945218933803269864762743594642571294', '1', '2017-01-10 14:49:42', '0:0:0:0:0:0:0:1', '0', '最高统治者', 'default', 'admin@main.com', '001', '18788888888');
INSERT INTO `sys_user` VALUES ('347b39bd1835435b9cbfdf08ba87060c', 'lxy', 'ed17fa39091630cd78635a0afacbc84ca01793ca', '李兴艳', '', 'df14e12c0fbf4f82835ac600a72b4394', '2016-11-16 16:47:35', '0:0:0:0:0:0:0:1', '0', '', 'default', '524232045@qq.com', '001', '13765081624');
