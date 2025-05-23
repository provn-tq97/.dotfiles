#!/usr/bin/env bash
set -euo pipefail

# ---- Pfade ----
THEME_DIR="$HOME/.config/kitty/themes"
KITTY_CONF_DIR="$HOME/.config/kitty"
INCLUDE_LINK="$KITTY_CONF_DIR/current-theme.conf"
SOCKET="${KITTY_LISTEN_ON:-unix:@kitty.sock}"

# ---- Deine feste Theme-Liste ----
THEME_LIST=(
    "mocha"
    "latte"
)

# ---- Auswahl per wofi ----
selected=$(printf '%s\n' "${THEME_LIST[@]}" \
           | ~/.config/wofi/scripts/launch.sh --dmenu --prompt="Kitty-Theme wählen:")

[ -z "$selected" ] && exit 0

# ---- Validierung ----
if ! printf '%s\n' "${THEME_LIST[@]}" | grep -qx "$selected"; then
  notify-send "kitty-theme-switcher" "Unbekanntes Theme: $selected"
  exit 1
fi

# ---- Symlink setzen ----
# Theme-Datei: <THEME_DIR>/<selected>.conf
ln -sf "$THEME_DIR/${selected}.conf" "$INCLUDE_LINK"

# ---- Kitty neuladen ----
if kitty @ --to "$SOCKET" set-colors --all "$INCLUDE_LINK"; then
  notify-send "kitty-theme-switcher" "Theme geändert zu: $selected"
else
  notify-send "kitty-theme-switcher" "Kitty-Neuladen fehlgeschlagen für: $selected"
fi
