#!/bin/bash

# Entrypoint for docker-factorio
# Summary:
# - Checks if there's an existing game and creates a new one if not
# - Starts the server

LOG_FILE="factorio-server.log"
SERVER_SETTINGS_FILE="server-settings.json"

# Check if there's an existing game - create one if not
if [ ! -f "$(cat last-game.txt 2> /dev/null)" ]; then
    SAVE_FILE="factorio-save-$(date +"%Y_%m_%d_%I_%M_%p").zip"
    ./factorio/bin/x64/factorio --create ./saves/${SAVE_FILE} 2>&1 | tee ${LOG_FILE}
    echo "./saves/${SAVE_FILE}" > last-game.txt
fi

# Start the server
# If server-settings file exists and is readable, then use it
exec ./factorio/bin/x64/factorio --start-server $(cat last-game.txt) $(if [ -r ./${SERVER_SETTINGS_FILE} ]; then echo "--server-settings ./${SERVER_SETTINGS_FILE}"; fi)
