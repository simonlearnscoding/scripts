#!/bin/bash

# Function to print "Hi" in a loop

# Function to start a timer asynchronously and print "Hi" after two seconds
start_timer() {
	local timer=0
	while true; do
		# Increment the timer every second
		sleep 1
		((timer++))

		# Check if the timer has reached two seconds
		if ((timer == 2)); then
			echo "Hi"
			timer=0
		fi
	done
}

# Function to run the task monitor loop
run_task_monitor() {
	local cmatrix_pid="$1"

	while inotifywait -e modify,attrib,close_write,move,create,delete --exclude '\.lock$' -r "$(pwd)" --quiet; do
		# Terminate the cmatrix process
		if kill -2 $cmatrix_pid; then
			/home/simone/scripts/monitor_task_changes.sh "TODAY" "+TODAY"
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
		cmatrix -C cyan &
		cmatrix_pid=$!
		# Call the run_task_monitor function with the cmatrix PID
		run_task_monitor "$cmatrix_pid"
	done
}

run_loop
