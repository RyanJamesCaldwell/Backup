#!/bin/bash

#Author: Ryan Caldwell
#Description: Simple *nix bash script that takes in N command line arguments, places them all in a zip file, and places them on a user's desktop. In combination of this script and cron, the user can back up their important files as frequently or infrequently as they like.

if [ ! $# -eq 0 ]
then
	for arg in "$@"; do
		if [ ! -f "$arg" ] && [ ! -d "$arg" ]
		then
			echo "Error: File '$arg' does not exist."
			exit 1
		fi
	done

	echo "Generating zip file...."
	filename=`date +%s`-backup
	zip -r $filename "$@" > /dev/null

	if [ -d ~/Desktop ]
	then
		mv $filename.zip ~/Desktop/ 2> /dev/null
		echo "Backup '$filename.zip' has been created and placed on your desktop."
	else
		mv $filename.zip ~/ 2> /dev/null
		echo "Backup '$filename.zip' has been created and placed in your home folder."
	fi
else
	echo "No files supplied for backup."
	exit 1
fi
