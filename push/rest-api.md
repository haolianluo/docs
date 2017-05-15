FORMAT: 1A
HOST: https://mops-api.lianluo.com/push/server/v1

# 消息推送

## 普通消息 [/messages]

### 推送 [POST]

+ Attributes
  + title (string) - "消息标题",
  + description (string, required) - "消息内容",
  + group_by (number, required) - 推送方式 0: 所有设备 1: 指定设备 2: 按设备标签推送  3:按主题推送
  + url (string) - URL
  + custom_content (object) - 自定义字段
  + topic (array, required) - 主题数组, 对应group_by. 1: 设备client_id集合 2. 标签集合, 3. 主题集合
  + apns (boolean, optional) - 是否使用APNs, 如果使用则同时推送到APNs

+ Request (application/json)

        {
            "title": "消息标题",
            "description": "设备变更",
            "group_by": "3",
            "topic":[
                "client_id1","client_id2", "or tag1","or tag2","or topic1"
            ],
            "url": "http://www.lianluo.com",
            "custom_content":{
                "devchange": "1"
            }
        }

+ Response 201 (application/json)

        {
              "title": "消息标题",
              "description": "消息内容",
              "notification_builder_id": 0,
              "notification_basic_style": 7,
              "open_type": 0,
              "url": null,
              "pkg_content": null,
              "custom_content": null
        }

## 透传消息 [/bg-messages]

### 推送 [POST]

+ Attributes
  + title (string) - "消息标题",
  + description (string, required) - "消息内容",
  + group_by (number, required) - 推送方式 0: 所有设备 1: 指定设备 2: 按设备标签推送  3:按主题推送
  + url (string, optional) - URL
  + custom_content (object) - 自定义字段
  + topic (array, required) - 主题数组, 对应group_by. 1: 设备client_id集合 2. 标签集合, 3. 主题集合

+ Request (application/json)

        {
            "title": "消息标题",
            "description": "设备变更",
            "group_by": "3",
            "topic":[
                "client_id1","client_id2", "or tag1","or tag2","or topic1"
            ],
            "url": "http://www.lianluo.com",
            "custom_content":{
                "devchange": "1"
            }
        }

+ Response 201 (application/json)

        {
              "title": "消息标题",
              "description": "消息内容",
              "notification_builder_id": 0,
              "notification_basic_style": 7,
              "open_type": 0,
              "url": null,
              "pkg_content": null,
              "custom_content": null
        }
