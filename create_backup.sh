#!/bin/bash

source_dir=$(zenity --file-selection \
    --directory \
    --title="Select the SOURCE directory to back up")

if [[ -z "$source_dir" ]]; then
    zenity --error --text="No source directory selected. Backup cancelled."
    exit 1
fi

dest_dir=$(zenity --file-selection \
    --directory \
    --title="Select the DESTINATION directory for the backup")

if [[ -z "$dest_dir" ]]; then
    zenity --error --text="No destination directory selected. Backup cancelled."
    exit 1
fi

timestamp=$(date +"%Y%m%d-%H%M%S")
backup_name="backup-$(basename "$source_dir")-$timestamp.tar.gz"
backup_path="$dest_dir/$backup_name"

if tar -czf "$backup_path" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"; then
    zenity --info --text="Backup created successfully:\n$backup_path"
else
    zenity --error --text="Backup failed."
fi
