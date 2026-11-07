#!/bin/bash

# Define the socket path
SOCKET="$HOME/.config/mpd/socket"

# Start a persistent background connection to MPD using a coprocess
# This allows us to keep the session open and maintain state
coproc MPD { ncat -U "$SOCKET"; }

# 1. Read the initial MPD greeting line immediately upon connection
read -r greeting <&"${MPD[0]}"
echo "DEBUG: Connected - $greeting"

# Function to send a command and read the response until 'OK' or 'ACK'
send_mpd_command() {
    local cmd="$1"
    echo "DEBUG: Sending command -> $cmd" >&2
    
    # Send command to MPD write pipe
    echo "$cmd" >&"${MPD[1]}"
    
    # Read response line-by-line from MPD read pipe
    while IFS= read -r line <&"${MPD[0]}"; do
        echo "$line"
        
        # Check for success or error terminators
        if [[ "$line" == "OK" ]]; then
            break
        elif [[ "$line" =~ ^ACK ]]; then
            echo "Error encountered!" >&2
            break
        fi
    done
}

# --- Example Usage ---
# Fetch player status
send_mpd_command "status"

# Fetch currently playing song details
send_mpd_command "currentsong"

# Close the session cleanly
send_mpd_command "close"
