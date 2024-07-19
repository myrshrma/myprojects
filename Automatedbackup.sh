#!/bin/bash

read -p "Enter the source directory: " SOURCE_DIRECTORY
read -p "Enter the remote server (user@remote_server:/path/to/backup_directory): " REMOTE_SERVER
read -p "Enter the log file path: " LOG_FILE

backup_directory() {
    rsync -avz "$SOURCE_DIRECTORY" "$REMOTE_SERVER"
    if [ $? -eq 0 ]; then
        echo "$(date): Backup successful." >> "$LOG_FILE"
        echo "Backup completed successfully."
    else
        echo "$(date): Backup failed." >> "$LOG_FILE"
        echo "Backup failed. Check the log for details."
    fi
}

backup_directory
