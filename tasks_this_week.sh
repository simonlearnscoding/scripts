#!/bin/bash

# Define the task list file path
TASK_DATA_PATH="$HOME/.task"

# Function to run the taskwarrior command with the given title and query, and customized output
run_task_list() {
	echo "Title: $1"
	echo
	task "$2" rc.report.minimal.columns=id,description rc.verbose=nothing minimal 2>/dev/null
	echo
}

# Array to hold days of the week
days=(mon tue wed thu fri sat sun)

# Loop through the days array
for day in ${days[@]}; do
	# Set the title and query
	title="Tasks for ${day^}"
	query="(planned:tw and sched:${day})"

	# Run the task list command for each day
	run_task_list "$title" "$query"
done

# Monitor the task list file for changes and re-run the task list command when a change is detected
while inotifywait -t 3 -e modify,attrib,close_write,move,create,delete --exclude '\.lock$' -r "$TASK_DATA_PATH" --quiet; do
	for day in ${days[@]}; do
		# Set the title and query
		title="Tasks for ${day^}"
		query="(planned:tw and sched:${day})"

		# Re-run the task list command for each day
		run_task_list "$title" "$query"
	done
done
