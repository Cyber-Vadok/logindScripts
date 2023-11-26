#!/bin/bash

#usage help message
usage(){
 echo "run this with sudo!"
 echo "this script sets operation on open/close lid"
 echo "Usage: $0 [-i|s|h]"
 echo "Options:"
 echo " -i ignore lid switch"
 echo " -s suspend on closed lid"
}

#check if the script is called without options
if [ "$#" -eq 0 ]; then
 usage
 exit 1
fi

#check options
while getopts "ish" opt; do
 case $opt in
  i)
     operation="ignore"
     ;;
  s) 
     operation="suspend"
     ;;
  h)
     usage
     exit 0
     ;;
  \?)
     echo "invalid option: -$OPTARG" >&2
     exit 1
     ;;
 esac
done 

# Update the logind.conf file
echo -e "[Login]\nHandleLidSwitch=$operation">/etc/systemd/logind.conf

# Restart the systemd-logind service
systemctl restart systemd-logind.service

echo "Lid switch configuration updated successfully to $operation"
