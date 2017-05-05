### 授权码模式

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
https://demo.com/oauth2/auth?client_id=4f5d7cb8-a8f2-33dab-95b1-e8ddca748a35&response_type=code&redirect_uri=https://demo.com/site/auth?authclient=lianluo&xoauth_displayname=联络推送&state=86a1f0d67c5633ab23d0c1ff8968d810ac6f77e8de7d420b7d496e81821ea34f
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