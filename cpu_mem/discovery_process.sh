#/bin/bash

#cpu mem,默认mem
name=$2
name=${name:-mem}

#$name占比,默认为2%
percent=$1
percent=${percent:-2}
if [ "$name" == "mem" ];then
    ps -eo pid,%mem,%cpu,comm | sort -nr -k 2 | awk -v m="${percent}" '{if($2 >m){print $0}}'  > /tmp/.ps.txt
elif [ "$name" == "cpu" ];then

    ps -eo pid,%mem,%cpu,comm | sort -nr -k 2 | awk -v m="${percent}" '{if($3 >m){print $0}}'  > /tmp/.ps.txt
fi
#进程数量
#n=`ps -eo pid,comm,%cpu | sort -nr -k 3 | awk -v m="${percent}" '{if($3 >m){print $2}}'  | wc -l`
n=`ps -eo pid,%${name},comm | sort -nr -k 2 | awk -v m="${percent}" '{if($2 >m){print $0}}' | awk '{a[$NF]+=$2}END{for(k in a){print a[k],k}}'| wc -l`
#echo $percent
i=1

echo '{'
echo -e '\t"data":['
while [ $i -le $n ]
do
   echo -en '\t\t{"{#PROCESS_NAME}":"'`ps -eo pid,%${name},comm | sort -nr -k 2 | awk -v m="$percent"  '{if($2 >m){print $0}}' | awk '{a[$NF]+=$2}END{for(k in a){print a[k],k}}'| awk -v n1="${i}" '{if(NR==n1){print $2}}' `'"}' 
    if [ $i -lt $n ];then
        echo ','
    fi
    let i++
done
echo -e '\n\t]'
echo '}'

