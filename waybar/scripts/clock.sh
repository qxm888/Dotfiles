#!/bin/bash
w=$(date "+%w")
case "$w" in
    0) day="周日";;
    1) day="周一";;
    2) day="周二";;
    3) day="周三";;
    4) day="周四";;
    5) day="周五";;
    6) day="周六";;
esac
echo "{\"text\": \"$(date '+%m/%d') $day $(date '+%H:%M')\", \"tooltip\": \"$(date '+%Y年%B%d日 %A')\"}"
