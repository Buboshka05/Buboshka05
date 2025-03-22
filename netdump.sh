#!/bin/bash

#Gets the date from the command date and formats it in the m-d-y format and saves it as a variable.
currentDate=$(date +%m-%d-%Y)
#Creates a variable for a file name that includes the current date in its name by using the variable made above.
outputFile="netinfo_$currentDate.txt"
#Gets the current IP address from the command ip addr by using grep to filter and awk to print.
ip addr | grep "inet " | grep -v "127.0.0.1" | awk '{print "IP Address: " $2}' | cut -d'/' -f1
#Overwrites/makes a file named after the outputFile variable made above with this as the first line.
echo "$(ip addr | grep "inet " | grep -v "127.0.0.1" | awk '{print "IP Address: " $2}' | cut -d'/' -f1)" > $outputFile
#Gets the current MAC address from the command ip addr by using grep to filter and awk to print.
ip addr | grep "link/ether " |  awk '{print "MAC Address: " $2}'
#Appends this to the file named after the variable.
echo "$(ip addr | grep "link/ether " |  awk '{print "MAC Address: " $2}')" >> $outputFile
#Gets the current DNS server IP address from the etc/resolv.conf directory by using grep to filter and awk to print.
cat /etc/resolv.conf | grep nameserver | awk '{print "DNS Server IP Address: " $2}'
#Appends this to the file named after the variable.
echo "$(cat /etc/resolv.conf | grep nameserver | awk '{print "DNS Server IP Address: " $2}')" >> $outputFile
#Echoes "Open Ports:" and then gets open ports from the command ss -tuln.
echo Open Ports:
ss -tuln
#Appends this to the file named after the variable.
echo "Open Ports:" >> $outputFile
echo "$(ss -tuln)" >> $outputFile

#Tells the user the script ran successfully.
echo Finished!
