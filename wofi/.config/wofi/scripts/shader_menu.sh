#!/usr/bin/env bash

# Falls noch eine alte wofi-Instanz läuft
killall wofi 2>/dev/null

# Liste aller verfügbaren Shader von hyprshade
mapfile -t shaders < <(hyprshade ls \
  | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# Wenn hyprshade keine Shader zurückliefert, abbrechen
if [ ${#shaders[@]} -eq 0 ]; then
  notify-send "Keine Shader verfügbar (hyprshade ls lieferte nichts)"
  exit 1
fi

# "none" als Option hinzufügen, um Shader zu deaktivieren
shaders+=(none)

# In wofi anzeigen und Auswahl einfangen
selected="$(printf '%s\n' "${shaders[@]}" | wofi --dmenu --prompt "Shader wählen:")"

# Kein Eintrag gewählt (Esc oder leer) → beenden
if [ -z "$selected" ]; then
  exit 0
fi

# "none" → Shader ausschalten
if [[ "${selected,,}" == "none" ]]; then
  hyprshade off
  notify-send "Shader deaktiviert"
  exit 0
fi

# Andernfalls ausgewählten Shader einschalten
hyprshade on $selected
notify-send -t 3000 "Shader aktiviert:" "$selected"

