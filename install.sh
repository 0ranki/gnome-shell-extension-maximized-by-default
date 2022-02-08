#!/bin/bash
##
## A simple install script
##
#
## Clone the repo and run this script.

UUID=$(cat src/metadata.json | jq -r '.uuid')
INSTALLPATH="$HOME/.local/share/gnome-shell/extensions/$UUID"

echo "Installing $UUID to $INSTALLPATH"

if command -v gnome-extensions > /dev/null; then
	gnome-extensions pack src/
	gnome-extensions install maximized-by-default@0ranki.github.com.shell-extension.zip
	rm -f maximized-by-default@0ranki.github.com.shell-extension.zip
else
	[ ! -d "$INSTALLPATH" ] && mkdir -p "$INSTALLPATH" || rm -rf "$INSTALLPATH"
	cp src/* "$INSTALLPATH"
fi

if [ ! -z "$WAYLAND_DISPLAY" ]; then
	echo "Please log out and back in, then use the GNOME Extensions app to enable the extension."
else
	echo "Please log out and back in or restart GNOME shell, then use the GNOME Extensions app to enable the extension."
fi

exit
