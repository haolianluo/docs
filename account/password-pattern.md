### 密码模式

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
