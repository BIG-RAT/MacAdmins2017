#!/bin/bash
# check that script is run as root user
if [ $EUID -ne 0 ]
then
	/bin/echo $'\nThis script must be run as the root user!\n'
	exit
fi
# capture user input name
while true;do
	name=$(osascript -e 'Tell application "System Events" to display dialog "Please enter the name for your computer or select Cancel." default answer ""' -e 'text returned of result' 2>/dev/null)
	if [ $? -ne 0 ];then # user hit cancel
		exit
	elif [ -z "$name" ];then # loop until input or cancel
		osascript -e 'Tell application "System Events" to display alert "Please enter a name or select Cancel... Thanks!" as warning'
	elif [ -n "$name" ];then
		# user input
		break
	fi
done
scutil --set ComputerName "$name"
scutil --set LocalHostName "$name"
scutil --set HostName "$name"

jamf recon


