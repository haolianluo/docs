## 刷新令牌

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
