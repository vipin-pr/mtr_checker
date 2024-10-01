# MTR Report Checker Script

This Bash script automates the process of running MTR (My Traceroute) diagnostics for one or more IP addresses. It performs multiple attempts to check the packet loss at the final destination for each IP and provides detailed reports.

How It Works: The script accepts one or more IP addresses as command-line arguments.
Retries: For each IP address, it performs up to 5 retries using mtr.
Packet Loss Detection: It checks the final destination in the MTR report for packet loss:
If any packet loss is detected, it prints the full MTR report for that IP.
If no packet loss is detected, it logs a message indicating no loss at the final destination.
Output: After all retries, it prints the latest MTR report, regardless of the packet loss status.
Usage
bash
Copy code
./mtr_report.sh IP_1 IP_2 ... IP_N
For example:

bash
Copy code
./mtr_report.sh 8.8.8.8 1.1.1.1
Requirements
mtr must be installed on the system.
Execute the script with root or sudo privileges for accurate results.
Purpose
This script is useful for network engineers and administrators who want to diagnose network issues and identify packet loss at the final destination for multiple IPs in a quick and automated manner.
