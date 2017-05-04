#!/bin/bash
# haolianluo.github.io builder.
# @author zacksleo <zacksleo@gmail.com>
#
body='{
"request": {
    "message": "Update docs (triggered by haolianluo/docs).",
    "branch":"master"
  }
}'

curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Travis-API-Version: 3" \
  -H "Authorization: token ${ACCESS_TOKEN}" \
  -d "$body" \
  https://api.travis-ci.org/repo/haolianluo%2Fsite/requests