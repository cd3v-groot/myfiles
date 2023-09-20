#!/bin/bash
#groot default bash
#set time zone
tz1="timezone"
echo $tz1
timedatectl set-timezone America/New_York
date
read -p "Is the time correct? Yn Nn? " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo "Copy the correct TZ from the list below. Press ENTER to continue..."
    timedatectl list-timezones | more
    echo "Paste the TZ directly below this line and press ENTER... "
    read tz1
    timedatectl set-timezone $tz1
    date
    read -p "Is the time and date correct above?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
        echo "More investigation is needed."
    else
        echo "Moving on..."
    fi
fi
#update
read -p "Would you like to update? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    apt-get update 
	apt-get upgrade
fi
#install iptables
read -p "Install iptables persistent? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    apt-get install iptables-persistent
fi
#proxmox agent
read -p "Install proxmox agent? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    apt-get install qemu-guest-agent && systemctl start qemu-guest-agent
fi
#add ecosmob2021
read -p "Add ecosmob2021 user? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
        adduser ecosmob2021
		usermod -aG sudo ecosmob2021
		echo ecosmob2021 has been added to sudo
fi
#end
echo "End of script"
