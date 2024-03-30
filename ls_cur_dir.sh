#!/bin/bash

file_to_watch="/home/simon/.current_dir"

dir_to_list=$(cat "$file_to_watch")
# exa --icons -a --group-directories-first --icons "$dir_to_list"
	exa --icons -a --tree -L 1  "$dir_to_list"
while inotifywait -q -e modify "$file_to_watch"; do
	dir_to_list=$(cat "$file_to_watch")
	clear
	# exa --icons -a --group-directories-first --icons "$dir_to_list"
	exa --icons -a --tree -L 1  "$dir_to_list"
done
