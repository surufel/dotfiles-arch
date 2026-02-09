#!/bin/bash

mkdir -p "$HOME/.config"
cp -rv .config/. "$HOME/.config/"

mkdir -p "$HOME/.local/share"
cp -rv .local/share/. "$HOME/.local/share/"

echo "[+] dotfiles installed."
