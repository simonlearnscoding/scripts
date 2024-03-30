#!/bin/bash

# take the hour from the first argument to the script
change_hour=$1

current_hour=$(date +%H)

# Initial check on startup
if [[ "$current_hour" -eq "$change_hour" ]]; then
	# Change the background color to red and clear the screen
	tput setab 1
	clear
else
	# Reset the terminal colors and clear the screen
	tput sgr0
	clear
fi

while true; do
	current_hour=$(date +%H)

	if [[ "$current_hour" -eq "$change_hour" ]]; then
		# Change the background color to red and clear the screen
		tput setab 1
		clear
	elif [[ "$current_hour" -ne "$change_hour" ]]; then
		# Reset the terminal colors and clear the screen at every other time
		tput sgr0
		clear
	fi

	# wait for a minute before checking the time again
	sleep 60
done
