#!/bin/bash

# Notification message
MESSAGE="$1"

# Sound file (change the path to the desired sound file)
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/message.oga"

# Send notification
notify-send --urgency="critical" "Reminder" "$MESSAGE"

# Play sound
paplay "$SOUND_FILE"
