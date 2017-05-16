### 客户端模式

统一入口地址为: `https://mops-api.lianluo.com/account/v1/`

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
            "client_secret": "a1BvrftDdS437cLwx3stJrfA-6Cm7lCo",
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