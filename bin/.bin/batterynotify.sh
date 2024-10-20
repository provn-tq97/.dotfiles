#!/bin/sh

# Battery percentage at which to notify
WARNING_LEVEL=20
BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

echo "Battery Level: $BATTERY_LEVEL"
echo "Battery Discharging: $BATTERY_DISCHARGING"

# If the battery is charging and is full (and has not shown notification yet)
if [ "$BATTERY_LEVEL" -gt 95 ] && [ "$BATTERY_DISCHARGING" -eq 0 ]; then
    notify-send "Battery Charged" "Battery is fully charged." -i "battery" -r 9991

# If the battery is low and is not charging (and has not shown notification yet)
elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ]; then
    notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-alert" -r 9991
fi
