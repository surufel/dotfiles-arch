#!/bin/bash

# Configurações
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
MONITOR="eDP-1"

# Verifica a existencia do diretorio
if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "Erro: Diretório não encontrado: $WALLPAPER_DIR" >&2
    exit 1
fi

# Lista imagens formatadas para o Rofi com ícones
function list_images() {
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | while read -r path; do
        echo -en "$(basename "$path")\0icon\x1f$path\n"
    done
}

# Seleção via Rofi
selected=$(list_images | rofi -dmenu -i -p "Wallpaper" -show-icons -theme-str 'listview { lines: 5; }')

if [[ -n "$selected" ]]; then
    wallpaper_path="$WALLPAPER_DIR/$selected"

	if awww img "$wallpaper_path" --transition-type grow --transition-pos bottom-right --transition-duration 1 --transition-fps 60; then
        echo "[+] Wallpaper alterado."
        exit 0
    else
        echo "[-]: O awww falhou." >&2
        exit 1
    fi
fi

exit 0
