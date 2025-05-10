#!/bin/bash
if [ -f /home/{{ ansible_user }}/.config/wol_scheduler/disabled ]; then
  echo "Scheduler is disabled. Exiting."
  exit 0
fi

# 通常のスケジュール処理...
DOW=$(date +%u)     # 曜日（1=月）
DATE=$(date +%F)    # 今日の日付
HOLIDAY=false

# 祝日判定（適宜 API または手動定義）
if grep -q "$DATE" /etc/my-holidays.txt; then
  HOLIDAY=true
fi

if [[ "$DOW" == "6" || "$DOW" == "7" || "$HOLIDAY" == "true" ]]; then
  WAKE_HOUR=9
else
  WAKE_HOUR=12
fi

# RTCに登録（次の起動）
WAKE_TIME=$(date -d "$DATE $WAKE_HOUR:00" +%s)
NOW=$(date +%s)
if (( WAKE_TIME < NOW )); then
  WAKE_TIME=$(date -d "tomorrow $WAKE_HOUR:00" +%s)
fi

echo 0 > /sys/class/rtc/rtc0/wakealarm
echo $WAKE_TIME > /sys/class/rtc/rtc0/wakealarm
