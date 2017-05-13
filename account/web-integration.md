### 网站应用接入指南

### 注册接入

* 1. 用户点击注册时, 自动跳转到用户中心统一注册地址, 并携带redirect_url参数, 表明回跳地址, 如
`https://demo.com/oauth2/signup?redirect_url=https://yourseit.com/redirect/path`
* 2. 用户注册成功, 会自动回跳回来, 即注册成功跳转到本网站的登录处

### 登录接入

* 1. 用户点击登录, 跳转到**用户中心**的登录地址, `/oauth2/auth`
* 2. 请求授权码(authorization_code), 见  [授权码模式](code-pattern)
* 3. 通过拿到的授权码, 获取访问令牌(access_token) 见  [授权码模式](code-pattern)
* 4. 通过令牌访问用户信息, 获取union_id
* 5. 通过union_id判断用户是否存在, 若用户存在记录, 则自动登录; 若不存在, 则执行注册+登录
*  6. union_id需要存储在服务端, 以便知道用户是否登录过, 如使用`user_auth`表存储, 表结构

| 字段  | 类型  | 备注  |   例子|
|:-:|---|---|---|
|  id |  int(11) |  主键 |  10 |
|  user_id | int(11)  | 用户ID  |  3 |
| source  |  varchar(255) |  来源  | lianluo  |
| source_id  |  varchar(255) | union_id  | AQAe4DrBlhnISCKKfNB791OPI8lBf-c-| 

### 针对PHP中 Yii2框架的认证组件

* 使用composer 安装: `composer require zacksleo/yii2-authclient` 
* 更多内容见 https://packagist.org/packages/zacksleo/yii2-authclient


## 服务端认证流程

分为两种情况, 分别为授权码模式和密码模式

## OAuth2中的几种认证方式

用户中心地址为: `https://mops-ucenter.lianluo.com/ `

### [授权码模式](code-pattern)

### [客户端模式](client-pattern)

#### [刷新令牌](refresh-token)

### [密码模式](password-pattern)
