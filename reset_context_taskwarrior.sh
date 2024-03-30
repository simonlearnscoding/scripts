#!/bin/sh

# Get the list of processes running the taskwarrior tui
pids=$(ps -ef | grep 'taskwarrior-tui' | grep -v grep | awk '{print $2}')

# Loop through each PID and kill the process
for pid in $pids; do
	echo "Killing taskwarrior-tui process ID: $pid"
	sudo kill -2 $pid
	# reset
done

echo "All instances of taskwarrior-tui have been terminated."
