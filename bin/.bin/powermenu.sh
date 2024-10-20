#! /bin/sh

chosen=$(printf "Lock\nSuspend\nLog Out" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
    "Lock") betterlockscreen -l;;
    "Suspend") systemctl suspend-then-hibernate ;;
	"Log Out") i3-msg exit ;;
    *) exit 1 ;;
esac
