#!/usr/bin/env bash

trap 'kill ${server_pid}; exit' INT

# Navigate to the directory of the script
cd "$(dirname "$0")"


WATCH_LATER_FILE="./src/content/watch_later.txt"
WATCH_LATER_JSON="./src/content/watch_later.json"

touch "${WATCH_LATER_FILE}"
touch "${WATCH_LATER_JSON}"


# Function to add video to watch later file
function add_video {
  video_id=$(echo "$1" | sed -E 's/.*v=([a-zA-Z0-9_-]+).*/\1/')
  if [[ -z "$video_id" ]]; then
    echo "Invalid YouTube URL or video ID."
	exit 0
  fi
# Check if the video_id already exists in the file
  if grep -q "^${video_id}$" "${WATCH_LATER_FILE}"; then
    echo "Video already exists in watch later list."
    return 1
  fi

    echo "$video_id" >> ${WATCH_LATER_FILE}
    echo "Video added to watch later list."
}

# Check for optional arguments
while [[ $# -gt 0 ]]
do
  case "$1" in
    -a|--add)
      add_video "$2"
      exit 0
      ;;
	-e|--edit)
    $EDITOR "./src/content/watch_later.txt"
    exit 0
	;;
	-c|--clean)
			rm -f ./src/content/watch_later_cache.txt
			./src/scripts/generate_json.sh
			exit 0
			;;
    *)
      echo "Invalid option: $1"
      exit 1
      ;;
  esac
done

# Generate the watch_later.json file if it does not exist or is empty
if [ ! -s "${WATCH_LATER_FILE}" ]; then
  echo "Warning: Add a video to the watch later list before starting the server."

  echo 'Syntax: ./launch.sh [-a|--add] "<video_id_or_url>"'
  exit 0
fi



# Regenerate the watch_later.json file
./src/scripts/generate_json.sh

# Start the Python web server in the background
python -m http.server 8000 &

# Store the process ID of the web server
server_pid=$!

# Wait for the server to start
sleep 2

# Open the watch_later.html page in the default web browser
xdg-open "http://localhost:8000/src/index.html"

# Wait for the user to press Enter
read -p "Press [Enter] to stop the server and exit..."

# Stop the Python web server
kill "${server_pid}"
