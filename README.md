# Watch Later List

This is a simple web application for managing a watch later list of youtube videos


## Features
- **CLI:** Parses a list of video IDs from a text file (watch_later.txt) and generates a JSON file (watch_later.json) containing the video details.
- **Interface:** Provides a web interface for viewing the watch later list (src/index.html).

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

## TODOs

### Useful
- Remove videos using the interface
- Add video duration

### Nice to have
- Add additional content such as blog posts
- Categorize content

### Behavior
- When adding a video that is already cached (has been added previously) it won't be added to the .json file
