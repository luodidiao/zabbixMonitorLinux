#/bin/bash

#cpu_num=`lscpu | grep '^CPU(s):' | awk '{print $2}'`
#cpu_num=`cat /proc/cpuinfo | grep 'physical id' | uniq -c`
j=`cat /proc/cpuinfo | grep 'cpu cores' | uniq -c | awk '{print $1}'`
k=`cat /proc/cpuinfo | grep 'cpu cores' | uniq -c | awk '{print $5}'`
cpu_total=`expr $j \* $k`
echo "$cpu_num"

#总内存大小,单位:m
mem_total=`free -m | awk '{if(NR==2){print $2}}'`

#sum | avg
mode=$1
#cpu/mem
name=$2
#进程名
process=$3

function memsum {
    mem_sum=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){a[myprocess]+=$2}}END{for(i in a){print a[i]}}'`
    echo "$mem_sum"
}
function memavg {
    mem_avg=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){a[myprocess]+=$2}}END{for(i in a){print a[i]}}'`
    echo "sacle=2;$mem_avg \* $mem_total" | bc 
}
function cpusum {
    cpu_sum=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){a[myprocess]+=$3}}END{for(i in a){print a[i]}}'`
    echo "$cpu_sum"
}
function cpuavg {
    cpu_avg=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){a[myprocess]+=$3}}END{for(i in a){print a[i]}}'`
    echo "$cpu_avg"
}

case $name in
    mem)
        if [ "$mode" == "sum" ];then
	    memsum
	elif [ "$mode" == "avg" ];then
	    memavg
	fi
    ;;
    cpu)
        if [ "$mode" == "sum" ];then
	    cpusum
	elif [ "$mode" == "avg" ];then
	    cpuavg
	fi
    ;;
    *)
        echo -e "Usage: [sum|avg] [mem|cpu] [process]"
esac

