<!-- --- title: 快速上手 -->

## 为什么对接用户中心

* 按照以往的做法, 每个项目会有一套自己的账号体系, 彼此之间没有联络, 用户使用时, 需要在每个项目上单独注册账号, 管理个人信息
* 使用用户中心可以实现统一认证, 统一授权, 统一管理
* 用户只注册一次, 即可使用联络旗下所有产品, 无需重复注册
* 快速登录, 用户登录了一个应用, 其他应用无需重复登录, 可以做到一键登录
* 用户信息只存放在一处, 便于统一管理和安全性维护
* 用户信息安全,  风险管控, 信息管理统一由用户中心处理, 其他项目无需重复开发, 降低开发成本
* 还可以绑定QQ, 微信, 微博等社交绑定, 进行快速登录

## Web如何接入用户中心

### 注册

* 1. 用户点击注册时, 自动跳转到用户中心统一注册地址, 并携带redirect_url参数, 表明回跳地址, 如
`https://mops-dev-usercenter.lianluo.com:882/oauth2/signup?redirect_url=https://mops-dev.lianluo.com/site/login`
* 2. 用户注册成功, 会自动回跳回来, 即注册成功跳转到本网站的登录处

### 登录

* 1. 在登录(site/login)处, 自动跳转到OAuth2登录地址, 如`site/auth`
* 2. 请求授权码(authorization_code), 见  [授权码模式](design)
* 3. 通过拿到的授权码, 获取访问令牌(access_token) 见  [授权码模式](design)
* 4. 通过令牌访问用户信息, 获取union_id
* 5. 通过union_id判断用户是否存在, 若用户存在记录, 则自动登录; 若不存在, 则执行注册+登录
*  6. union_id需要存储在服务端, 以便知道用户是否登录过, 如使用`user_auth`表存储, 表结构

| 字段  | 类型  | 备注  |   例子|
|:-:|---|---|---|
|  id |  int(11) |  主键 |  10 |
|  user_id | int(11)  | 用户ID  |  3 |
| source  |  varchar(255) |  来源  | lianluo  |
| source_id  |  varchar(255) | union_id  | AQAe4DrBlhnISCKKfNB791OPI8lBf-c-| 

## APP如何接入用户中心

APP端访问用户中心的接口, 均需要使用访问令牌进行认证, 见[客户端模式](design)

获取到访问令牌后, 所有接口URL中应该携带access_token字段, 用户中心会自动进行认证

如果在调用下面的接口时, 出现认证失败(状态码为401, 提示信息为You are requesting with an invalid credential.), 此时令牌失效, 应该重新获取令牌

### 注册

* 1.  获取手机验证码
*  2. 调用注册接口

### 修改密码

* 1. 调用修改密码接口

### 重置密码

* 1.  获取手机验证码
* 2. 调用重置密码接口

### 针对PHP中 Yii2框架的认证组件

* 使用composer 安装: `composer require zacksleo/yii2-authclient` 
 * 更多内容见 https://packagist.org/packages/zacksleo/yii2-authclient


接口详细见[接口文档](api)
