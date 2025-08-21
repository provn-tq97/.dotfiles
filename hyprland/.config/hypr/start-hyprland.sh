#!/bin/bash

# Alle nötigen Umgebungsvariablen für die Sitzung setzen
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# Diese wichtigen Befehle sorgen dafür, dass systemd und D-Bus die Umgebung kennen
# Dies geschieht jetzt *bevor* Hyprland überhaupt gestartet ist
systemctl --user import-environment XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP
dbus-update-activation-environment --systemd --all

# Erst jetzt wird Hyprland ausgeführt
exec Hyprland
