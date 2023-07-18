#!/bin/sh
#
# Chili Installer Network Configuration and Startup Script
#
# Written by Vilmar Catafesta <vcatafesta@gmail.com>
#
# This script will greet the user, ensure an internet connection
# and download the latest version of the Zen Installer from
# Github.
#

title="Chili Installer Network Tool"

# Greeting user and advising user to connect if not already
greeting()
{
	zenity 	\
		--question	\
		--width=450	\
		--height=500 \
		--title="$title" \
		--text "Welcome to the Zen Installer\nPlease ensure that you have an active internet connection.\nIf you need to connect via wifi, you may click the network icon in the above panel.\nIf you are using a wired connection, Network Manager should automatically detect it and connect.\nWhen you have connected to the internet, click the 'yes' button to proceed.\nIf you would like to exit the installer you may click 'no'.\nTo open a terminal and use this as a rescue cd, hit ctrl+alt+t."
	if [ "$?" = "1" ]
		then exit
	fi
}

# function to start a VPN to ensure user privacy
vpn()
{
	zenity --question --title="$title" --text="Would you like to connect to a VPN before you start the installation process?"
	connect="$?"
	if [ "$connect" = "0" ]
		then server=$(zenity --list --radiolist --title="$title" --height=500 --width=450 --text="Select the server closest to you" --column Select --column Layout $(ls /openvpn/ | awk '{ printf " FALSE ""\0"$0"\0" }'))
		zenity --info --title="$title" --width=450 --height=500 --text="Big thanks to sigavpn for providing the VPN configs, you can download them at sigavpn.com in addition to finding various ways to donate to him! He needs your help to make Siga the best free VPN Service out there!"
		lxterminal -e 'sudo openvpn --config /openvpn/'$server''
	fi
}

# function to download installer and make sure it is executable
download_installer()
{
	git clone --depth 5 https://github.com/spookykidmm/zen_installer
	chmod +x zen_installer/zif
}

# function to run installer, and provide choices to user after installer closes
run_installer()
{
	sudo ./zen_installer/zif
	ans=$(zenity --list --title="$title" --radiolist --text "What would you like to do now?"  --column "Select" --column "Option" FALSE Restart FALSE Close FALSE "Chroot into new system" FALSE "Open pacman.conf")
	if [ "$ans" = "Restart" ]
	then reboot
	elif [ "$ans" = "Chroot into new system" ]
	then sudo mount $(cat root_part.txt) /mnt
     lxterminal -e sudo arch-chroot /mnt
     umount -R /mnt
	elif [ "$ans" = "Open pacman.conf" ]
	then sudo mount $(cat root_part.txt) /mnt
	lxterminal -e sudo nano /mnt/etc/pacman.conf     
	else exit
	fi
}

# execution
greeting
# function to check for an active internet connection
if [[ ! $(ping -c 1 google.com) ]]; then
	zenity --info --title="$title" --text "The internet connection was not detected, please try again."
	greeting
fi

vpn
download_installer
run_installer

