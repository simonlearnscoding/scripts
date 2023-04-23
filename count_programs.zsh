
#!/usr/bin/env zsh

# Get the current workspace
current_workspace=$(wmctrl -d | awk '/\*/ {print $1}')

# Count the number of open programs in the current workspace
num_programs=$(wmctrl -l | awk -v ws="$current_workspace" '$2 == ws { count++ } END { print count+0 }')

# Return the number of open programs as an integer
return $num_programs
