<!-- --- title: 设计思路 -->

[[_TOC_]]

## 设计思路

* 1.统一注册和认证, 用户信息放在一处托管
* 2.可使用 用户名/手机号/邮箱 其中任何一个作为认证**username**
* 3.会员通过union_id字段来实现ID的统一
* 4.接口授权遵循OAuth2.0规范
* 5.接口实现遵循RESTful规范

## 准备工作 
1.  在用户中心由管理员分配应用ID和应用密钥

以下是测试账号:

| #  |应用名称   |  应用ID |  应用密钥 | 授权类型  |
|:-:|---|---|---|---|
|  1 | 联络推送  |  4f5d7cb8-a8f2-33ab-95b1-e8ddca748a35 |  AxPwnCn3HNwHyXNtUuCjtLbdxRoRV2ha | authorization_code  |
| 2  | 联络忻风  |  d21f5491-3cfd-3fdc-b922-f4cabd658c82 |  Mdg9YBjGoYXDOVQrVcd2ELr59y0u6Rt1 | client_credentials password  |
| 3  |  联络智能 | fa21b49c-aa3b-37c3-852f-51b41cd6bc25  | a1BvrfQoOVKO7cLwtskRJrfA-6Cm7lCo  |  client_credentials password |


## APP端认证流程

* 1. 首先通过**客户端模式**（client_credentials） 授权方式获取**访问令牌**（access_token）
* 2. 凭访问令牌访问相关接口

## 服务端认证流程

分为两种情况, 分别为授权码模式和密码模式

## 认证方式

用户中心地址为: `https://mops-dev-usercenter.lianluo.com:882/ `

### 1. 授权码模式
该模式用于页面中交互授权，如PC端登陆，假设当前网站地址为 `https://demo.com`, 流程如下

####  第一步, 用户点击登陆
#### 第二步, 跳转到用户中心获取授权码页面

 + 入口地址 /oauth2/auth
 + client_id: 客户端ID, 在用户中心后台申请,
  +  redirect_uri  回跳地址 
  +  xoauth_displayname  显示名称
  +  state 自定义状态编码

  示例: 
```
https://mops-dev-usercenter.lianluo.com:882/oauth2/auth?client_id=4f5d7cb8-a8f2-33dab-95b1-e8ddca748a35&response_type=code&redirect_uri=https://demo.com/site/auth?authclient=lianluo&xoauth_displayname=联络推送&state=86a1f0d67c5633ab23d0c1ff8968d810ac6f77e8de7d420b7d496e81821ea34f
```

### 第三步, 获取成功后，浏览器会自动跳转回来，链接中会携带授权码, 如


  +  回跳地址 https://demo.com/site/auth?authclient=lianluos
  +  code:  授权码, 用于获取访问令牌
  +  state 自定义状态编码

示例: 

```
https://demo.com/site/auth?authclient=lianluos&code=a8ca2ab5f6ff657bfea2dd9f97be748b3c646276&state=9cf922d0943687e35c38a54d0b5eda42862926d55eb92bb5205bad917d978be4
```

#### 第四步, 用授权码换取访问令牌

  + ` POST [/oauth2/token]`

  + Request (application/json)  

        {
            "client_id" : "在用户中心申请的应用ID",
            "client_secret' :  '应用密钥",
            "code" : "上一步获取的授权码",
            "grant_type" :  "授权类型, 这里为: authorization_code",
            "redirect_uri" : "回跳地址, 可选择, https://mops-dev.lianluo.com/site/auth?authclient=lianluo"
        }


#### 第五步, 用访问令牌获取用户信息，包括union_id和username

 +  ` GET  /api/oauth2/v1/users?access_token=b22f5fa1d35d2df2bd969b77fc99251fb3cc154b`

 + Response 201 (application/json)   

        {
          "union_id": "AQAe4DrBlhnISCKKfNB791OPI8lBf-c-",
          "avatar": null,
          "username": "zacksleo",
          "email": "zacksleo@gmail.com",
          "phone": "17002108009"
        }


#### 第六步, 判断该用户是否在本地注册，如果有对应记录，自动登陆；如果没有记录，则自动注册并登录

### 2. 客户端模式

统一入口地址为: `https://mops-dev.lianluo.com/account/v1/`

该模式常用于APP接口中，服务端需调用用户中心的接口，如获取验证码, 注册, 修改密码, 重置密码

流程如下：

####  第一步, APP从用户中心获取访问令牌

+ `POST  /tokens`

+ Attributes
  + client_id  (string, required) 应用ID
  + client_secret (string, required) 应用密钥
  + grant_type (string, required) 授权类型, 这里为client_credentials

+ Request (application/json)  

        {
            "client_id":  "fa21b49c-aa3b-37c3-852f-51b41cd6bc25-c-",
            "client_secret": "a1BvrfQoOVKO7cLwtskRJrfA-6Cm7lCo",
            "grant_type": "client_credentials"
        }

+ Response 201 (application/json)    

        {
          "access_token": "461526b1dad2cff2e48599ae5c848a5740fda71f",
          "expires_in": 86400,
          "token_type": "Bearer",
          "scope": null
        }


####  第二步, 拿到令牌后，调用相关接口, 接口URL最后加上access_token参数


#### 刷新令牌

为保证使用较新和token, 可以使用refresh_token来刷新获取新的令牌

+ `POST  /tokens`

+ Attributes
  + client_id  (string, required) 应用ID
  + client_secret (string, required) 应用密钥
  + grant_type (string, required) 授权类型, 这里为refresh_token
  + refresh_token (string, required) 刷新令牌的令牌

+ Request (application/json)  

        {
            "client_id":  "fa21b49c-aa3b-37c3-852f-51b41cd6bc25-c-",
            "client_secret": "a1BvrfQoOVKO7cLwtskRJrfA-6Cm7lCo",
            "grant_type": "client_credentials",
            "refresh_token": "ec473b1ce714aa52595f3f405a2fa0c09c115241"
        }

+ Response 201 (application/json)    

        {
          "access_token": "461526b1dad2cff2e48599ae5c848a5740fda71f",
          "expires_in": 86400,
          "token_type": "Bearer",
          "scope": null,
          "refresh_token": "ec473b1ce714aa52595f3f405a2fa0c09c115241"
        }



### 3. 密码模式

该模式用于服务端接口中，服务端需调用用户中心的接口，如查询用户信息

流程如下：
####  第一, APP调用接口，上传用户名和密码
#### 第二, 服务端凭接收到的上述数据，以密码模式，从用户中心获取访问令牌

+ `POST  /tokens`

+ Attributes
  + client_id  (string, required) 应用ID
  + client_secret (string, required) 应用密钥
  + grant_type (string, required) 授权类型, 这里为password
  + username (string, required) 用户名, 这里为手机号码
  + password (string, required) 密码, 这里为用户密码

+ Request (application/json)  

        {
            "client_id":  "fa21b49c-aa3b-37c3-852f-51b41cd6bc25-c-",
            "client_secret": "a1BvrfQoOVKO7cLwtskRJrfA-6Cm7lCo",
            "grant_type": "password",
            "username": "17002108009",
            "password": "zacks1e0"
        }

+ Response 201 (application/json)    

        {
          "access_token": "23ae30af65624d2ede7a0114e24bff75043b32e5",
          "expires_in": 86400,
          "token_type": "Bearer",
          "scope": null,
          "refresh_token": "e2ec0a3ee75b64081cb92bedcea0c792cd25e0c2"
        }




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



