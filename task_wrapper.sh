#!/bin/bash

# Define the task list file path
TASK_DATA_PATH="$HOME/.task"
# Function to print "Hi" in a loop

# Function to start a timer asynchronously and print "Hi" after two seconds
run_task_monitor() {
	cmatrix -C cyan &
	cmatrix_pid=$!
	while inotifywait -e modify,attrib,close_write,move,create,delete --exclude '\.lock$' -r "$TASK_DATA_PATH" --quiet; do
		# Terminate the cmatrix process
		if kill -2 $cmatrix_pid; then

			/home/simone/scripts/monitor_task_changes.sh "TODAY" "+TODAY"
			# run_loop
			break
		fi
	done
}

# Run cmatrix in the background
# cmatrix -C cyan &
# cmatrix_pid=$!
# # Call the run_task_monitor function with the cmatrix PID
# run_task_monitor "$cmatrix_pid"

run_loop() {
	while true; do
		# Call the run_task_monitor function with the cmatrix PID
		run_task_monitor
	done
}

run_loop
