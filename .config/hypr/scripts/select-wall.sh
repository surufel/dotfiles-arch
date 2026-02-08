#!/bin/bash

# Configurations
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
MONITOR="eDP-1" 
# Change MONITOR in case it is the wrong monitor config

# Verifies if the directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "Error: Directory not found: $WALLPAPER_DIR" >&2
    exit 1
fi

# Shows the wallpaper images when opening rofi with wallpaper selector
function list_images() {
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | while read -r path; do
        echo -en "$(basename "$path")\0icon\x1f$path\n"
    done
}

# Selecting wallpaper via rofi
selected=$(list_images | rofi -dmenu -i -p "Wallpaper" -show-icons -theme-str 'listview { lines: 5; }')

if [[ -n "$selected" ]]; then
    wallpaper_path="$WALLPAPER_DIR/$selected"

	if awww img "$wallpaper_path" --transition-type grow --transition-pos bottom-right --transition-duration 1 --transition-fps 60; then
        echo "[+] Wallpaper changed."
        exit 0
    else
        echo "[-]: awww has failed." >&2
        exit 1
    fi
fi

exit 0
