#!/usr/bin/env bash

watch_later_file="src/content/watch_later.txt"
watch_later_json="src/content/watch_later.json"
watch_later_cache="src/content/watch_later_cache.txt"

# Check if the cache file exists, if not, create it
if [ ! -f "${watch_later_cache}" ]; then
  touch "${watch_later_cache}"
fi

# Find new video entries that are not in the cache
new_entries=$(comm -13 <(sort "${watch_later_cache}") <(sort "${watch_later_file}"))

if [ -z "${new_entries}" ]; then
  echo "No new video entries found."
  exit 0
fi

# Get the current JSON content (remove the last closing bracket)
current_json_content=$(cat "${watch_later_json}" | head -n -1)

# If the current JSON content is not empty, add a comma
if [ -n "${current_json_content}" ]; then
  current_json_content+=","
fi

# Generate JSON objects for new entries
new_json_entries=""
while read -r video_id; do
  if [ -z "${video_id}" ]; then
    continue
  fi

  video_url="https://www.yewtu.be/watch?v=${video_id}"
  video_info=$(yt-dlp -j --flat-playlist "${video_url}" 2>/dev/null)

  title=$(echo "${video_info}" | jq -r '.title')
  thumbnail_url=$(echo "${video_info}" | jq -r '.thumbnail')

json_entry="{\"url\":\"${video_url}\",\"title\":\"${title//\"/\\\"}\",\"thumbnail_url\":\"${thumbnail_url}\"}"
  
  if [ -z "${new_json_entries}" ]; then
    new_json_entries="${json_entry}"
  else
    new_json_entries+=",${json_entry}"
  fi
done <<< "${new_entries}"

# Combine the current JSON content and new JSON entries
updated_json_content="[${current_json_content}${new_json_entries}]"

# Update the JSON file
echo "${updated_json_content}" > "${watch_later_json}"

# Update the cache file
cat "${watch_later_file}" > "${watch_later_cache}"

echo "Updated watch_later.json with new video entries."
