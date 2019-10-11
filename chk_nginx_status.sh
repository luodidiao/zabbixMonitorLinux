#! /bin/bash

# Description：zabbix监控nginx性能以及进程状态
# Note：此脚本需要配置在被监控端，否则ping检测将会得到不符合预期的结果

HOST="blog.jluocc.cn"
PORT="80"

case $1 in
ping)
    /sbin/pidof nginx | wc -l;;
active)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Active' | awk '{print $NF}';;
reading)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Reading' | awk '{print $2}' ;;
writing)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Writing' | awk '{print $4}';;
waiting)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Waiting' | awk '{print $6}';;
accepts)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| awk NR==3 | awk '{print $1}';;
handled)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| awk NR==3 | awk '{print $2}';;
requests)
    /usr/bin/curl "http://$HOST:$PORT/status/" 2>/dev/null| awk NR==3 | awk '{print $3}';;
*)
    echo 'ping|active|reading|writing|waiting|accepts|handled|requests'

esac
