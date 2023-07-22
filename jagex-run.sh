#!/bin/sh
set -x
# Move to this directory so the client self-updater will work properly
cd "$XDG_DATA_HOME"
# Configuration
jagex_launcher_url="https://cdn.jagex.com/Jagex%20Launcher%20Installer.exe"

first_run="false"

if [ ! -f "$XDG_DATA_HOME/jagex-launcher/prefix/drive_c/Program Files (x86)/Jagex Launcher/JagexLauncher.exe" ]; then
    echo "First Run!"
    first_run="true"
fi

if [ "$first_run" == "true" ]; then
    # Create directory for launcher data
    mkdir -p "$XDG_DATA_HOME"/jagex-launcher
    cd jagex-launcher
    # Grab lutris-ge-wine
    wget -O wine-ge.tar.xz https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-12/wine-lutris-GE-Proton8-12-x86_64.tar.xz
    tar -xf wine-ge.tar.xz
    mv lutris-GE-Proton8-12-x86_64 wine
    
    # Download the jagex launcher installer
    wget -O jagex-launcher-installer.exe "$jagex_launcher_url"

    # Create wine prefix directory and launch the installer
    mkdir -p "$XDG_DATA_HOME"/jagex-launcher/prefix
    WINEPREFIX="$XDG_DATA_HOME/jagex-launcher/prefix" WINEDLLOVERRIDES="jscript.dll=n" ./wine/bin/wine "jagex-launcher-installer.exe"
else
    cd jagex-launcher
fi
WINEPREFIX="$XDG_DATA_HOME/jagex-launcher/prefix" ./wine/bin/wine "./prefix/drive_c/Program Files (x86)/Jagex Launcher/JagexLauncher.exe"
