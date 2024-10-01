#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Usage: ./mtr_report.sh IP_1 IP_2 ... IP_N"
  exit
fi

MAX_RETRIES=5

check_mtr()
{

ip="$1"
count=1

while [ $count -le $MAX_RETRIES ]; do

    echo -e "\nMTR Report - $ip - (Attempt $count)"
    mtr_report=$(mtr -r -c 10 "$ip" 2>/dev/null)

    final_line=$(echo "$mtr_report" | tail -n 1)
    final_destination=$(echo "$final_line" | awk '{print $2}')
    loss_percentage=$(echo "$final_line" | awk '{print $3}')

    if [[ "$loss_percentage" != "0.0%" ]]; then
        echo -e "\nMTR Report - $ip - Attempt $count - Loss Found at $final_destination - $loss_percentage"
        echo "----------------------------"
        echo "$mtr_report"
        echo "----------------------------"
    else
        echo "MTR Report - $ip - No Loss at $final_destination"
    fi

    count=$((count + 1))
done

    echo
    echo "MTR Report (Latest) - $ip"
    echo "----------------------------"
    echo $mtr_report
    echo "----------------------------"

}

for IP in "$@"; do
check_mtr "$IP"
done
