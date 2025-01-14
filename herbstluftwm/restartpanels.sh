#!/usr/bin/env bash

installdir=/

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
defaultpanel="$XDG_CONFIG_HOME/herbstluftwm/panel.sh"

if [ -x "$defaultpanel" ]; then
	defaultpanel="$installdir/etc/xdg/herbstluftwm/panel.sh"
fi

panelcmd="${1:-$defaultpanel}"

herbstclient emit_hook quit_panel

for i in $(herbstclient list_monitors | cut -d':' -f1) ; do
	"$panelcmd" "$i" &
done
