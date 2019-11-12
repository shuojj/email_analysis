#!/bin/bash
num=$1
dir=$2

egrep -rosh "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.]+\.[A-Za-z]{2,6}\b" $dir |  sort -nr | uniq -c | sort -nr | sed -n 1,"${num}"p > topemails.txt


while IFS= read -r line
do
    domain=$( echo "$line" |cut -d "@" -f2 )
    egrep -rosh "\b[A-Za-z0-9._%+-]+@${domain}\b" $dir | uniq >> top_domains.txt
done < topemails.txt
sort top_domains.txt | uniq > top_domains_sorted.txt
head -n $num top_domains_sorted.txt > emails_top_domains.txt
rm top_domains.txt
rm top_domains_sorted.txt
