#!/bin/bash

# Gibt sofort einen Lade-Text aus, damit Waybar beim Start nicht leer ist.
# Du kannst hier jedes Icon und jeden Text verwenden, den du magst.
echo " Lade..."

# Eine Endlosschleife, die sich um die Aktualisierungen kümmert.
while true; do
    # Wetterdaten abrufen (Temperatur und Wetter-Emoji)
    weather=$(curl -s 'https://wttr.in/Erding?format=%t+%c')

    # Prüfen, ob der Abruf erfolgreich war.
    # Wir schauen, ob die Ausgabe das °C-Symbol enthält.
    if [[ $weather == *"°C"* ]]; then
        # Wenn ja, gib das Wetter aus.
        echo "$weather"
    else
        # Wenn nein (Fehler, kein Internet, etc.), gib einen Fehlertext aus.
        echo "N/A"
    fi

    # Warte eine Stunde (3600 Sekunden) bis zur nächsten Abfrage.
    sleep 3600
done
