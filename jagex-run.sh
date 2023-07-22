#!/bin/sh
set -x
# Move to this directory so the client self-updater will work properly
cd "$XDG_DATA_HOME"
# Configuration
jagex_launcher_url="https://cdn.jagex.com/Jagex%20Launcher%20Installer.exe"

first_run="false"

if [ ! -f "$XDG_DATA_HOME/jagex-launcher/JagexLauncher.exe" ]; then
    echo "First Run!"
    first_run="true"
fi

if [ "$first_run" == "true" ]; then
    mkdir -p "$XDG_DATA_HOME"/jagex-launcher
    cd jagex-launcher
    echo "First time installation!"
    echo "Download Jagex Launcher Installer..."
    wget -O jagex-launcher-installer.exe "$jagex_launcher_url"
    cp -r /app/opt/jagex-launcher/* "$XDG_DATA_HOME/jagex-launcher"
    mkdir -p "$XDG_DATA_HOME"/jagex-launcher/prefix
    WINEPREFIX="$XDG_DATA_HOME/jagex-launcher/prefix" winetricks --unattended corefonts
    WINEPREFIX="$XDG_DATA_HOME/jagex-launcher/prefix" WINEDLLOVERRIDES="jscript.dll=n" wine "jagex-launcher-installer.exe"
fi
# cd "$XDG_DATA_HOME"
# WINEPREFIX="$XDG_DATA_HOME/prefix" wine JagexLauncher.exe

