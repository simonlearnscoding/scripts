#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
	echo "No arguments supplied. Please provide a command to run."
	exit 1
fi

while true; do
	# Start taskwarrior-tui in the background
	"$@" &
	pid=$!

	# Let it run for some time (e.g., 1 hour)
	sleep 10

	# Then stop it gracefully
	kill -INT $pid

	# Give it a moment to terminate before restarting
	sleep 1
done
