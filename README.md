## 关于StartApi

StartApi是一款基于php+mysql的简易接口文档编写生成工具,通过输入主要数据,快捷生成接口文档以供查阅和直接测试

## 如何部署

* 首先机器环境需支持php+mysql运行
* 在mysql中导入startapi.sql文件,创建项目需要表数据及测试数据
* 在conn.php数据库配置文件中修改数据库连接信息
```php
return array(
	'host' => 'localhost', //数据库地址
	'dbname' => 'startapi', //数据库名
	'user' => 'root', //用户名
	'passwd' => '', //密码
	'port' => '3306'
);
```

## 如何使用

* 1，首先设置接口文档基本信息及域名配置
* 2，新建接口分类及分类下接口
* 3，点击发布即生成接口文档api.html，上传到服务器或者直接复制发送都可

## 一些截图

首页
![首页](http://ww2.sinaimg.cn/large/525a24a4gw1f2uf5ru4q2j20xq082glq.jpg)
文档设置
![设置](http://ww1.sinaimg.cn/large/525a24a4gw1f2uf5uludhj20yb0lgt9n.jpg)
接口更新
![接口更新](http://ww4.sinaimg.cn/large/525a24a4gw1f2uf5rkzohj20xq0p875f.jpg)
生成文档
![生成文档](http://ww1.sinaimg.cn/large/525a24a4gw1f2uf5tnkjrj21100qywfj.jpg)
