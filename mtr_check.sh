#!/bin/bash

#checking if there is argument
if [ "$#" -lt 1 ]; then
  echo "Usage: ./mtr_report.sh IP_1 IP_2 ... IP_N"
  exit
fi

#Setting Maximum retries count
MAX_RETRIES=5

#Function check_mtr
check_mtr()
{
ip="$1"
count=1

#while loop for looping 5 times
while [ $count -le $MAX_RETRIES ]; do

    echo -e "\nMTR Report - $ip - (Attempt $count)"

    #capturing mtr report to mtr_report variable
    mtr_report=$(mtr -r -c 10 "$ip" 2>/dev/null)

    #variables for capturing last line, name of the destination server, percentage of loss at the final destination
    final_line=$(echo "$mtr_report" | tail -n 1)
    final_destination=$(echo "$final_line" | awk '{print $2}')
    loss_percentage=$(echo "$final_line" | awk '{print $3}')

    #condition to check if the loss at final destination is not 0.0%
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

#for loop for iterating through all the given IP Addresses
for IP in "$@"; do
check_mtr "$IP"
done
