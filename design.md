<!-- --- title: 设计思路 -->

[[_TOC_]]

## 设计思路

* 1.统一注册和认证, 用户信息放在一处托管
* 2.可使用 用户名/手机号/邮箱 其中任何一个作为认证**username**
* 3.会员通过union_id字段来实现ID的统一
* 4.接口授权遵循OAuth2.0规范
* 5.接口实现遵循RESTful规范

## 准备工作 
1.  在用户中心由创建应用ID并申请应用密钥

## 名词解释

### 客户端模式

客户端模式（Client Credentials Grant）指客户端以自己的名义，而不是以用户的名义，向"服务提供商"进行认证。严格地说，客户端模式并不属于OAuth框架所要解决的问题。在这种模式中，用户直接向客户端注册，客户端以自己的名义要求"服务提供商"提供服务，其实不存在授权问题。

### 访问令牌

用于授权的口令, 与用户的密码不同。用户可以在登录的时候，指定授权层令牌的权限范围和有效期。


### union_id

一段32位的字符串, 用于识别用户, 与平台无关,  唯一且保证通用
可根据union_id获取用户的基本信息，包括昵称、头像、性别、手机、邮箱等信息

###  username

用户名/手机号/邮箱 其中的任何一个, 其中用户名至少6位, 且必须有一个字母; 手机号为11位数字;



## 参考资料

* [理解OAuth 2.0](http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html)

* [理解RESTful架构](http://www.ruanyifeng.com/blog/2011/09/restful.html)

* [RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)

* [RESTful 接口规范](http://139.198.9.76:4567/guideline/RESTful%E6%8E%A5%E5%8F%A3%E8%A7%84%E8%8C%83)



