#!/bin/bash

source /usr/local/share/colors/colors.txt

echo -e "\n${BGreen}Here are your open listening ports for your local IPv4 and IPv6 addresses!!\n${White}"

ss -tunlp | 
        awk '{print $1, $2, $5, $7}' | 
                sed "s/\"\|,\|users:\|(\|)/ /g" | 
                rev | 
                sed 's/\(]*\):/ \1/' | 
                rev | 
                sed "s/Netid\|State\|Local\|Peer//g" | 
                column -t -N Protocol,State,IP\ Address,Port,Service,PID,File\-Descriptor
