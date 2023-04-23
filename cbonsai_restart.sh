#!/bin/bash
while true; do
	cbonsai -li
	echo "cbonsai crashed with exit code $?. Restarting..." >&2
	sleep 1
done
