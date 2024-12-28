#!/bin/bash

# Set the timeout duration in seconds
timeout_duration=1

# Path to the script to execute
script_path=~/.config/hypr/scripts/keyboard_layout.sh

# Function to reset the timer
reset_timer() {
    SECONDS=0
}

# Function to check for keyboard input
check_input() {
    if read -t 0.1; then
        reset_timer
    fi
}

# Execute the script
bash "$script_path" &

# Save the PID of the script
script_pid=$!

# Main loop
while true; do
    # Check for keyboard input
    check_input

    # Check if timeout has occurred
    if [ $SECONDS -ge $timeout_duration ]; then
        echo "Timeout reached"
        # Terminate the script
        pkill -P $script_pid
        break
    fi
done
