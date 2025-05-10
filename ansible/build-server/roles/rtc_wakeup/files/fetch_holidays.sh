#!/bin/bash
# API: https://holidays-jp.github.io/api/v1/date.json
curl -s https://holidays-jp.github.io/api/v1/date.json \
  | jq -r 'keys[]' > /etc/holidays.txt
