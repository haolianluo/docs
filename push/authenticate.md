# 接口认证

## 签名机制

  加密描述：

  * 给每个开发者分配一个AppKey和AppSecret，并将该信息保存在本地代码，同时对AppSecret进行必要的加密隐藏
  * App在请求接口时，需要做以下几个步骤：

### 认证方式 
>
 * 分配的AppKey和AppSecret作为 HTTP Basic认证的用户名和密码, 进行设置

请求的head中应该包含Authorization, 为HttpBasic处理后的用户名和密码串

关于HttpBasic认证, 请自行搜索

+ Headers

  + Authorization: Base64加密的HttpBasi 用户名和密码
  +  Content-Type: application/json

+ Response (401 application/json)

        {
          "name": "Unauthorized",
          "message": "You are requesting with an invalid credential.",
          "code": 0,
          "status": 401,
          "type": "yii\\web\\UnauthorizedHttpException"
        }

