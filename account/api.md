FORMAT: 1A
HOST: https://mops-api.lianluo.com/account/v1/

## 用户 [/users]


### 获取用户信息 [GET]
+ Header 
    + Authorization: Bearer {userToken} - 用户访问令牌, 通过授权码模式或密码模式获得
    + Content-Type: application/json
+ Attributes
    + expand (string, optional) - 查询字段,可选, 如果添加了expand=profile, 则会给出profile的信息
+ Request (application/json)

        {
          "expand":"profile"
        }

+ Response 200 (application/json) 

        {
            "union_id": "AQAe4DrBlhnISCKKfNB791OPI8lBf-c-",
          "avatar": null,
          "username": "zacksleo",
          "email": "zacksleo@gmail.com",
          "phone": "17002108009",
          "profile":{
            "nickname": "昵称",
            "birthday": "出生日期",
            "sex": "性别, 1男,2女",
            "height": "身高,cm",
            "weight": "体重,kg"          
          }
        }

## Token [/tokens]

### 获取Tokens [POST]

+ Attributes
  + client_id  (string, required) 应用ID
  + client_secret (string, required) 应用密钥
  + grant_type (string, required) 授权类型, 这里为client_credentials

+ Request (application/json)  

        {
            "client_id":  "fa21b49c-aa4b-36c3-852f-51b81cd6bc25-c-",
            "client_secret": "a1BvrftDdS483cLwx3stJrfA-6Cm7lCo",
            "grant_type": "client_credentials"
        }

+ Response 201 (application/json)    

        {
          "access_token": "461526b1dad2cff2e48599ae5c848a5740fda71f",
          "expires_in": 86400,
          "token_type": "Bearer",
          "scope": null
        }

    