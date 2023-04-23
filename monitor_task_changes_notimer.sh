#!/bin/bash

# Check if a title and a query string are provided
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: $0 <title> <query>"
	exit 1
fi

# Define the task list file path
TASK_DATA_PATH="$HOME/.task"

# Function to run the taskwarrior command with the given title and query, and customized output
run_task_list() {
	clear
	echo "Title: $1"
	echo
	task "$2" rc.report.minimal.columns=id,description rc.report.minimal.labels=ID,Description minimal 2>/dev/null
}

# Initial run of task list command
run_task_list "$1" "$2"

# Monitor the task list file for changes and re-run the task list command when a change is detected
# while true; do
# 	inotifywait -e modify,attrib,close_write,move,create,delete --exclude '\.lock$' -r "$TASK_DATA_PATH" --quiet
# 	run_task_list "$1" "$2"
# done

while inotifywait -e modify,attrib,close_write,move,create,delete --exclude '\.lock$' -r "$TASK_DATA_PATH" --quiet; do
	run_task_list "$1" "$2"
done
