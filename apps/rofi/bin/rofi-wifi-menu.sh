#!/usr/bin/env bash

# Starts a scan of available broadcasting SSIDs
# nmcli dev wifi rescan

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FIELDS=SSID,SECURITY
POSITION=0
YOFF=0
XOFF=0

if [ -r "$DIR/config" ]; then
	source "$DIR/config"
elif [ -r "$HOME/.config/rofi/wifi" ]; then
	source "$HOME/.config/rofi/wifi"
else
	echo "WARNING: config file not found! Using default values."
fi

LIST=$(nmcli --fields "$FIELDS" device wifi list | sed '/^--/d')
# For some reason rofi always approximates character width 2 short... hmmm
RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+2))
# Dynamically change the height of the rofi menu
LINENUM=$(echo "$LIST" | wc -l)
# Gives a list of known connections so we can parse it later
KNOWNCON=$(nmcli connection show)
# Really janky way of telling if there is currently a connection
CONSTATE=$(nmcli -fields WIFI g)

CURRSSID=$(LANGUAGE=C nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')

if [[ ! -z $CURRSSID ]]; then
	HIGHLINE=$(echo  "$(echo "$LIST" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}') + 1" | bc )
fi

# HOPEFULLY you won't need this as often as I do
# If there are more than 8 SSIDs, the menu will still only have 8 lines
if [ "$LINENUM" -gt 8 ] && [[ "$CONSTATE" =~ "enabled" ]]; then
	LINENUM=8
elif [[ "$CONSTATE" =~ "disabled" ]]; then
	LINENUM=1
fi


if [[ "$CONSTATE" =~ "enabled" ]]; then
	TOGGLE="toggle off"
elif [[ "$CONSTATE" =~ "disabled" ]]; then
	TOGGLE="toggle on"
fi



CHENTRY=$(echo -e "$TOGGLE\nmanual\n$LIST" | uniq -u | rofi -dmenu -p "Wi-Fi SSID: " -theme $HOME/.config/rofi/config/standardtheme.rasi -lines "$LINENUM" -a "$HIGHLINE" -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -width -"$RWIDTH")
#echo "$CHENTRY"
CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')
#echo "$CHSSID"
ALREADYCONNECTED="Desconectar\nOlvidar"
if [ $(nmcli -f GENERAL.STATE con show $CHSSID | cut -d: -f2 | tr -s ' ') = "activada" ] ; then
	chosen="$(echo -e "$ALREADYCONNECTED" |  rofi -dmenu -p "Wi-Fi SSID: " -theme $HOME/.config/rofi/config/standardtheme.rasi -selected-row 0)"
	if [ "$chosen" = "Desconectar" ] ; then
		nmcli con down $CHSSID
	elif [[ "$chosen" = "Olvidar" ]] ; then
		nmcli con down $CHSSID
	else
		exit
	fi
else

fi


# If the user inputs "manual" as their SSID in the start window, it will bring them to this screen
if [ "$CHENTRY" = "manual" ] ; then
	# Manual entry of the SSID and password (if appplicable)
	MSSID=$(rofi -dmenu -p "Nombre de la red" -theme $HOME/.config/rofi/config/standardtheme.rasi -lines 1)
	# Separating the password from the entered string
	MPASS=$(rofi -dmenu -p "Contraseña de $MSSID" -theme $HOME/.config/rofi/config/standardtheme.rasi -lines 1)

	#echo "$MSSID"
	#echo "$MPASS"

	# If the user entered a manual password, then use the password nmcli command
	if [ "$MPASS" = "" ]; then
		nmcli dev wifi con "$MSSID"
	else
		nmcli dev wifi con "$MSSID" password "$MPASS"
	fi

elif [ "$CHENTRY" = "Encender" ]; then
	nmcli radio wifi on

elif [ "$CHENTRY" = "Apagar" ]; then
	nmcli radio wifi off

else

	# If the connection is already in use, then this will still be able to get the SSID
	if [ "$CHSSID" = "*" ]; then
		CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
	fi

	# Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
	if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
		nmcli con up "$CHSSID"
	else
		if [[ "$CHENTRY" =~ "WPA2" ]] || [[ "$CHENTRY" =~ "WEP" ]]; then
			WIFIPASS=$(echo "Si la red está guardada, presiona Enter" | rofi -dmenu -p "Contraseña: " -theme $HOME/.config/rofi/config/standardtheme.rasi  -lines 1 )
			if [ "$WIFIPASS" = "" ]; then
				nmcli dev wifi con "$CHSSID"
			else
				nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
			fi
		fi
	fi

fi
