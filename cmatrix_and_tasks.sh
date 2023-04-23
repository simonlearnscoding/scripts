#!/bin/bash

# Define the task list file path
TASK_DATA_PATH="$HOME/.task"

# Function to run the taskwarrior command with the given title and query, and customized output
run_task_list() {
	clear
	echo "Title: $1"
	echo
	task "$2" rc.report.minimal.columns=id,description rc.report.minimal.labels=ID,Description minimal 2>/dev/null
}

# Run cmatrix in the background
cmatrix -C cyan &
cmatrix_pid=$!

# Wait for changes in the task list
while inotifywait -e modify,attrib,close_write,move,create,delete --exclude '\.lock$' -r "$TASK_DATA_PATH" --quiet; do
	# Terminate the cmatrix process
	kill -2 $cmatrix_pid
	# Run monitor_task_changes.sh as a separate process
	./monitor_task_changes.sh "TODAY" "+TODAY or +today" &
	# Wait for the monitor_task_changes.sh process to complete
	wait
	# Run cmatrix in the background again
	cmatrix -C cyan &
	cmatrix_pid=$!
done
