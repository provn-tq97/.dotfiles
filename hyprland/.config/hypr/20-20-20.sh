#!/bin/bash

export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

notify-send "Erinnerung" "Es sind 20 Minuten vergangen."

