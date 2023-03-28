#!/usr/bin/env bash

# Get the video URL from the command line argument
video_url="$1"

# Extract the video ID from the YouTube URL
video_id=$(echo "${video_url}" | sed -n 's/.*watch?v=\([a-zA-Z0-9_-]*\).*/\1/p')

# Save the video ID to the watch_later.txt file
echo "${video_id}" >> watch_later.txt
