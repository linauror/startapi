-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.17 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 startapi 的数据库结构
CREATE DATABASE IF NOT EXISTS `startapi` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `startapi`;


-- 导出  表 startapi.api 结构
CREATE TABLE IF NOT EXISTS `api` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属分类',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '接口名称',
  `uri` char(50) NOT NULL DEFAULT '' COMMENT 'URI',
  `method_type` char(4) NOT NULL DEFAULT 'get' COMMENT '请求类型 get post',
  `desc` text NOT NULL COMMENT '接口描述',
  `request_param` text NOT NULL COMMENT '请求参数',
  `result_param` text NOT NULL COMMENT '返回参数',
  `request_code` text NOT NULL COMMENT '请求代码示例',
  `result_code` text NOT NULL COMMENT '返回代码示例',
  `is_authed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要授权',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序，数字越大越靠前',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '删除标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='接口列表';

-- 正在导出表  startapi.api 的数据：0 rows
/*!40000 ALTER TABLE `api` DISABLE KEYS */;
INSERT INTO `api` (`id`, `type_id`, `title`, `uri`, `method_type`, `desc`, `request_param`, `result_param`, `request_code`, `result_code`, `is_authed`, `sort`, `deleted`) VALUES
	(1, 1, '获取最新的公共微博', 'statuses/public_timeline', 'get', '返回最新的公共微博', '[{"field":"access_token","data_type":"string","is_required":1,"default":"","desc":"采用OAuth授权方式为必填参数，OAuth授权后获得。"},{"field":"count","data_type":"int","default":"50","desc":"单页返回的记录条数，默认为50。","is_required":0},{"field":"page","data_type":"int","default":"1","desc":"返回结果的页码，默认为1。","is_required":0}]', '[{"field":"created_at","data_type":"string","default":"","desc":"微博创建时间","is_required":0},{"field":"id","data_type":"int","default":"","desc":"微博ID","is_required":0},{"field":"mid","data_type":"int","default":"","desc":"微博MID","is_required":0},{"field":"idstr","data_type":"string","default":"","desc":"字符串型的微博ID","is_required":0},{"field":"text","data_type":"string","default":"","desc":"微博信息内容","is_required":0}]', '', '{\r\n    "statuses": [\r\n        {\r\n            "created_at": "Tue May 31 17:46:55 +0800 2011",\r\n            "id": 11488058246,\r\n            "text": "求关注。"，\r\n            "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",\r\n            "favorited": false,\r\n            "truncated": false,\r\n            "in_reply_to_status_id": "",\r\n            "in_reply_to_user_id": "",\r\n            "in_reply_to_screen_name": "",\r\n            "geo": null,\r\n            "mid": "5612814510546515491",\r\n            "reposts_count": 8,\r\n            "comments_count": 9,\r\n            "annotations": [],\r\n            "user": {\r\n                "id": 1404376560,\r\n                "screen_name": "zaku",\r\n                "name": "zaku",\r\n                "province": "11",\r\n                "city": "5",\r\n                "location": "北京 朝阳区",\r\n                "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",\r\n                "url": "http://blog.sina.com.cn/zaku",\r\n                "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",\r\n                "domain": "zaku",\r\n                "gender": "m",\r\n                "followers_count": 1204,\r\n                "friends_count": 447,\r\n                "statuses_count": 2908,\r\n                "favourites_count": 0,\r\n                "created_at": "Fri Aug 28 00:00:00 +0800 2009",\r\n                "following": false,\r\n                "allow_all_act_msg": false,\r\n                "remark": "",\r\n                "geo_enabled": true,\r\n                "verified": false,\r\n                "allow_all_comment": true,\r\n                "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",\r\n                "verified_reason": "",\r\n                "follow_me": false,\r\n                "online_status": 0,\r\n                "bi_followers_count": 215\r\n            }\r\n        },\r\n        ..\r\n    ],\r\n    "previous_cursor": 0,\r\n    "next_cursor": 11488013766,\r\n    "total_number": 81655\r\n}', 1, 0, 0),
	(2, 1, '获取关注用户最新微博', 'statuses/friends_timeline', 'get', '获取当前登录用户及其所关注（授权）用户的最新微博', '[{"field":"access_token","data_type":"string","is_required":1,"default":"","desc":"采用OAuth授权方式为必填参数，OAuth授权后获得。"},{"field":"since_id","data_type":"int","default":"0","desc":"若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。","is_required":0},{"field":"max_id","data_type":"int","default":"0","desc":"若指定此参数，则返回ID小于或等于max_id的微博，默认为0。","is_required":0}]', '[{"field":"created_at","data_type":"string","default":"","desc":"微博创建时间","is_required":0},{"field":"id","data_type":"int","default":"","desc":"微博ID","is_required":0},{"field":"mid","data_type":"int","default":"","desc":"微博MID","is_required":0},{"field":"idstr","data_type":"string","default":"","desc":"字符串型的微博ID","is_required":0},{"field":"text","data_type":"string","default":"","desc":"微博信息内容","is_required":0}]', '', '{\r\n    "statuses": [\r\n        {\r\n            "created_at": "Tue May 31 17:46:55 +0800 2011",\r\n            "id": 11488058246,\r\n            "text": "求关注。"，\r\n            "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",\r\n            "favorited": false,\r\n            "truncated": false,\r\n            "in_reply_to_status_id": "",\r\n            "in_reply_to_user_id": "",\r\n            "in_reply_to_screen_name": "",\r\n            "geo": null,\r\n            "mid": "5612814510546515491",\r\n            "reposts_count": 8,\r\n            "comments_count": 9,\r\n            "annotations": [],\r\n            "user": {\r\n                "id": 1404376560,\r\n                "screen_name": "zaku",\r\n                "name": "zaku",\r\n                "province": "11",\r\n                "city": "5",\r\n                "location": "北京 朝阳区",\r\n                "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",\r\n                "url": "http://blog.sina.com.cn/zaku",\r\n                "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",\r\n                "domain": "zaku",\r\n                "gender": "m",\r\n                "followers_count": 1204,\r\n                "friends_count": 447,\r\n                "statuses_count": 2908,\r\n                "favourites_count": 0,\r\n                "created_at": "Fri Aug 28 00:00:00 +0800 2009",\r\n                "following": false,\r\n                "allow_all_act_msg": false,\r\n                "remark": "",\r\n                "geo_enabled": true,\r\n                "verified": false,\r\n                "allow_all_comment": true,\r\n                "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",\r\n                "verified_reason": "",\r\n                "follow_me": false,\r\n                "online_status": 0,\r\n                "bi_followers_count": 215\r\n            }\r\n        },\r\n        ...\r\n    ],\r\n    "ad": [\r\n        {\r\n            "id": 3366614911586452,\r\n            "mark": "AB21321XDFJJK"\r\n        },\r\n        ...\r\n    ],\r\n    "previous_cursor": 0,      // 暂时不支持\r\n    "next_cursor": 11488013766,     // 暂时不支持\r\n    "total_number": 81655\r\n}', 1, 0, 0),
	(3, 2, '统一下单', 'pay/unifiedorder', 'post', '除被扫支付场景以外，商户系统先调用该接口在微信支付服务后台生成预支付交易单，返回正确的预支付交易回话标识后再按扫码、JSAPI、APP等不同场景生成交易串调起支付。', '[{"field":"appid","data_type":"string","is_required":1,"default":"","desc":"微信分配的公众账号ID（企业号corpid即为此appId）"},{"field":"mch_id","data_type":"string","is_required":1,"default":"","desc":"微信支付分配的商户号"},{"field":"device_info","data_type":"string","default":"","desc":"终端设备号(门店号或收银设备ID)，注意：PC网页或公众号内支付请传"WEB"","is_required":0},{"field":"nonce_str","data_type":"string","is_required":1,"default":"","desc":"随机字符串，不长于32位。推荐随机数生成算法"},{"field":"sign","data_type":"string","is_required":1,"default":"","desc":"签名，详见签名生成算法"}]', '[{"field":"trade_type","data_type":"string","is_required":1,"default":"","desc":"调用接口提交的交易类型，取值如下：JSAPI，NATIVE，APP，详细说明见参数规定"},{"field":"prepay_id","data_type":"string","is_required":1,"default":"","desc":"微信生成的预支付回话标识，用于后续接口调用中使用，该值有效期为2小时"},{"field":"code_url","data_type":"string","default":"","desc":"trade_type为NATIVE是有返回，可将该参数值生成二维码展示出来进行扫码支付","is_required":0}]', '<xml>\r\n   <appid>wx2421b1c4370ec43b</appid>\r\n   <attach>支付测试</attach>\r\n   <body>JSAPI支付测试</body>\r\n   <mch_id>10000100</mch_id>\r\n   <nonce_str>1add1a30ac87aa2db72f57a2375d8fec</nonce_str>\r\n   <notify_url>http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php</notify_url>\r\n   <openid>oUpF8uMuAJO_M2pxb1Q9zNjWeS6o</openid>\r\n   <out_trade_no>1415659990</out_trade_no>\r\n   <spbill_create_ip>14.23.150.211</spbill_create_ip>\r\n   <total_fee>1</total_fee>\r\n   <trade_type>JSAPI</trade_type>\r\n   <sign>0CB01533B8C1EF103065174F50BCA001</sign>\r\n</xml>', '<xml>\r\n   <return_code><![CDATA[SUCCESS]]></return_code>\r\n   <return_msg><![CDATA[OK]]></return_msg>\r\n   <appid><![CDATA[wx2421b1c4370ec43b]]></appid>\r\n   <mch_id><![CDATA[10000100]]></mch_id>\r\n   <nonce_str><![CDATA[IITRi8Iabbblz1Jc]]></nonce_str>\r\n   <sign><![CDATA[7921E432F65EB8ED0CE9755F0E86D72F]]></sign>\r\n   <result_code><![CDATA[SUCCESS]]></result_code>\r\n   <prepay_id><![CDATA[wx201411101639507cbf6ffd8b0779950874]]></prepay_id>\r\n   <trade_type><![CDATA[JSAPI]]></trade_type>\r\n</xml>', 0, 0, 0),
	(4, 2, '查询订单', 'pay/orderquery', 'post', '该接口提供所有微信支付订单的查询，商户可以通过该接口主动查询订单状态，完成下一步的业务逻辑。', '[{"field":"appid","data_type":"string","is_required":1,"default":"","desc":"微信分配的公众账号ID（企业号corpid即为此appId）"},{"field":"mch_id","data_type":"string","is_required":1,"default":"","desc":"微信支付分配的商户号"},{"field":"transaction_id","data_type":"string","is_required":1,"default":"","desc":"微信的订单号，优先使用"},{"field":"out_trade_no","data_type":"string","is_required":1,"default":"","desc":"商户系统内部的订单号，当没提供transaction_id时需要传这个。"},{"field":"nonce_str","data_type":"string","is_required":1,"default":"","desc":"随机字符串，不长于32位。推荐随机数生成算法"},{"field":"sign","data_type":"string","is_required":1,"default":"","desc":"签名，详见签名生成算法"}]', '[{"field":"device_info","data_type":"string","default":"","desc":"微信支付分配的终端设备号","is_required":0},{"field":"openid","data_type":"string","is_required":1,"default":"","desc":"用户在商户appid下的唯一标识"},{"field":"is_subscribe","data_type":"string","default":"Y","desc":"用户是否关注公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效","is_required":0},{"field":"trade_type","data_type":"string","is_required":1,"default":"JSAPI","desc":"调用接口提交的交易类型，取值如下：JSAPI，NATIVE，APP，MICROPAY，详细说明见参数规定"}]', '<xml>\r\n   <appid>wx2421b1c4370ec43b</appid>\r\n   <mch_id>10000100</mch_id>\r\n   <nonce_str>ec2316275641faa3aacf3cc599e8730f</nonce_str>\r\n   <transaction_id>1008450740201411110005820873</transaction_id>\r\n   <sign>FDD167FAA73459FD921B144BAF4F4CA2</sign>\r\n</xml>', '<xml>\r\n   <return_code><![CDATA[SUCCESS]]></return_code>\r\n   <return_msg><![CDATA[OK]]></return_msg>\r\n   <appid><![CDATA[wx2421b1c4370ec43b]]></appid>\r\n   <mch_id><![CDATA[10000100]]></mch_id>\r\n   <device_info><![CDATA[1000]]></device_info>\r\n   <nonce_str><![CDATA[TN55wO9Pba5yENl8]]></nonce_str>\r\n   <sign><![CDATA[BDF0099C15FF7BC6B1585FBB110AB635]]></sign>\r\n   <result_code><![CDATA[SUCCESS]]></result_code>\r\n   <openid><![CDATA[oUpF8uN95-Ptaags6E_roPHg7AG0]]></openid>\r\n   <is_subscribe><![CDATA[Y]]></is_subscribe>\r\n   <trade_type><![CDATA[MICROPAY]]></trade_type>\r\n   <bank_type><![CDATA[CCB_DEBIT]]></bank_type>\r\n   <total_fee>1</total_fee>\r\n   <fee_type><![CDATA[CNY]]></fee_type>\r\n   <transaction_id><![CDATA[1008450740201411110005820873]]></transaction_id>\r\n   <out_trade_no><![CDATA[1415757673]]></out_trade_no>\r\n   <attach><![CDATA[订单额外描述]]></attach>\r\n   <time_end><![CDATA[20141111170043]]></time_end>\r\n   <trade_state><![CDATA[SUCCESS]]></trade_state>\r\n</xml>', 0, 0, 0);
/*!40000 ALTER TABLE `api` ENABLE KEYS */;


-- 导出  表 startapi.type 结构
CREATE TABLE IF NOT EXISTS `type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(20) NOT NULL DEFAULT '' COMMENT '分类名称',
  `desc` text NOT NULL COMMENT '分类描述',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序，数字越大越靠前',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '删除标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='接口分类';

-- 正在导出表  startapi.type 的数据：0 rows
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` (`id`, `title`, `desc`, `sort`, `deleted`) VALUES
	(1, '微博接口', '', 0, 0),
	(2, '微信支付', '', 0, 0);
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
