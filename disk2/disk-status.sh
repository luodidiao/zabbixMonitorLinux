#!/bin/bash
if [ $# -ne 1 ];then
    echo "Follow the script name with an argument"
fi

case $1 in 

    rrqm)
        iostat -dxk 1 1|grep -w vda |awk '{print $2}'
        ;;

    wrqm)
        iostat -dxk 1 1|grep -w vda |awk '{print $3}'
        ;;

    rps)
        iostat -dxk 1 1|grep -w vda|awk '{print $4}'
        ;;

    wps)
        iostat -dxk 1 1|grep -w vda |awk '{print $5}'
        ;;

    rKBps)
        iostat -dxk 1 1|grep -w vda |awk '{print $6}'
        ;;

    wKBps)
        iostat -dxk 1 1|grep -w vda |awk '{print $7}'
        ;;

    avgrq-sz)
        iostat -dxk 1 1|grep -w vda |awk '{print $8}'
        ;;

    avgqu-sz)
        iostat -dxk 1 1|grep -w vda |awk '{print $9}'
        ;;

    await)
        iostat -dxk 1 1|grep -w vda|awk '{print $10}'
        ;;

    svctm)
        iostat -dxk 1 1|grep -w vda |awk '{print $13}'
        ;;

    util)
        iostat -dxk 1 1|grep -w vda |awk '{print $14}'
        ;;

    *)
        echo -e "\e[033mUsage: sh $0 [rrqm|wrqm|rps|wps|rKBps|wKBps|avgqu-sz|avgrq-sz|await|svctm|util]\e[0m"
esac
