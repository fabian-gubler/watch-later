# Watch Later List

This is a simple web application for managing a watch later list of youtube videos

## TODOs

- Add additional content such as blog posts
- Remove videos from the interface

## Features
- Parses a list of video IDs from a text file (watch_later.txt) and generates a JSON file (watch_later.json) containing the video details.
- Provides a web interface for viewing the watch later list (src/index.html).
- Supports removing videos from the list by clicking on a button next to each video.
- Provides a launch script (launch.sh) for starting a Python web server and opening the web interface in the default web browser.
- Supports additional launch script arguments:
	- edit opens the watch_later.txt file in the default editor.
	- clean removes the cache file (watch_later_cache.txt) and regenerates the JSON file from scratch.

## Requirements
- Python (for running the web server)
- yt-dlp (for fetching video details from YouTube)

## Usage
### Run Application
``` bash
./launch.sh

```

This will start the web server and open the web interface in the default web browser.

### Arguments
The following arguments can be passed to the launch.sh script:

- `-e/--edit`: Opens the watch_later.txt file with the default editor.
- `-c/--clean`: Removes the cached JSON file and generates it from scratch.
- `-a/--add <video_id>`: Adds a YouTube video with the given ID to the watch_later.txt file. If the entire YouTube URL is entered, the script will extract the video ID and add it to the file instead.
