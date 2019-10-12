#/bin/bash

#cpu占比
percent=$1
percent=${percent:-0}

#进程数量
#n=`ps -eo pid,comm,%cpu | sort -nr -k 3 | awk -v m="${percent}" '{if($3 >m){print $2}}'  | wc -l`
n=`ps -eo pid,%cpu,comm | sort -nr -k 2 | awk -v m="${percent}" '{if($2 >m){print $0}}' | awk '{a[$NF]+=$2}END{for(k in a){print a[k],k}}'| wc -l`
#echo $percent
i=1

echo '{'
echo -e '\t"data":['
while [ $i -le $n ]
do
   echo -e '\t\t{"{#CPU_PROCESS_NAME}":"'`ps -eo pid,%cpu,comm | sort -nr -k 2 | awk -v m="$percent"  '{if($2 >m){print $0}}' | awk '{a[$NF]+=$2}END{for(k in a){print a[k],k}}'| awk -v n1="${i}" '{if(NR==n1){print $2}}' `'"}' 
    let i++
done
echo -e '\n\t]'
echo '}'

