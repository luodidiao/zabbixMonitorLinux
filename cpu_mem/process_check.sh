#/bin/bash

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
    mem_avg=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){n++;a[myprocess]+=$2}}END{for(i in a){print a[i]/n}}'`
    echo "$mem_avg"
}
function cpusum {
    cpu_sum=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){a[myprocess]+=$3}}END{for(i in a){print a[i]}}'`
    echo "$cpu_sum"
}
function cpuavg {
    cpu_avg=`cat /tmp/.ps.txt  | awk -v myprocess="$process" '{if($4==myprocess){n++;a[myprocess]+=$3}}END{for(i in a){print a[i]/n}}'`
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

