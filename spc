#!/bin/bash

source /usr/local/share/colors/colors.txt

echo -e "\n${BGreen}Here are your open listening ports for your local IPv4 and IPv6 addresses!!\n${White}"

ss -tunlp | 
	awk '{print $1, $2, $5, $7}' | 
		sed "s/\"\|,\|users:\|(\|)/ /g" | 
		rev | 
		sed 's/\(]*\):/ \1/' | 
		rev | 

	awk 'NR==1 { print; next }
{
	$3 = "\033[1;94m" $3 "\033[0m"
	$4 = "\033[1;96m" $4 "\033[0m"
	$5 = "\033[1;93m" $5 "\033[0m"
	print
}' |

	sed "s/Netid\|State\|Local\|Peer//g"  | 
	column -t -N Protocol,State,IP\ Address,Port,Service,PID,File\-Descriptor | 
	sed "s/\budp\b/\x1b[1;91m&\x1b[0m/g" | 
	sed "s/\btcp\b/\x1b[1;92m&\x1b[0m/g" | 
	sed "s/=\([^[:space:]]*\)/=\x1b[1;92m\1\x1b[0m/g"
