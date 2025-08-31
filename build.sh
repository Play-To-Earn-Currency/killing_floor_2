#!/bin/sh
if [ -z "$KILLING_FLOOR_2_SYSTEM" ] || [ ! -d "$KILLING_FLOOR_2_SYSTEM" ]; then
    echo "KILLING_FLOOR_2_SYSTEM undefined or invalid directory."
    read -p ".../Documents/My Games/KillingFloor2/KFGame/Src/ full path: " KILLING_FLOOR_2_SYSTEM

    if [ ! -d "$KILLING_FLOOR_2_SYSTEM" ]; then
        mkdir -p "$KILLING_FLOOR_2_SYSTEM"
    fi
fi

if [ -z "$KILLING_FLOOR_2_BINARIES" ] || [ ! -d "$KILLING_FLOOR_2_BINARIES" ]; then
    echo "KILLING_FLOOR_2_BINARIES undefined or invalid directory."
    read -p "Killing Floor System path: " KILLING_FLOOR_2_BINARIES

    if [ ! -d "$KILLING_FLOOR_2_BINARIES" ]; then
        mkdir -p "$KILLING_FLOOR_2_BINARIES"
    fi
fi

PROJECT_DIRECTORY=$(pwd)

rm -rf "$KILLING_FLOOR_2_SYSTEM/PlayToEarnMutator"
cp -r ./PlayToEarnMutator "$KILLING_FLOOR_2_SYSTEM/PlayToEarnMutator"

cd "$KILLING_FLOOR_2_BINARIES"

if [ "$(uname -s)" = "Linux" ]; then
    echo "Running linux script..."
    # If you are a linux user use a wine script to compile for you
    ./compile.sh
elif [[ "$(uname -s)" == MINGW* || "$(uname -s)" == CYGWIN* ]]; then
    echo "Running KFEditor.exe make..."
    ./KFEditor.exe make
else
    echo "System not supported: $(uname -s)"
    exit 1
fi

mkdir -p "$PROJECT_DIRECTORY/Release"
cp -r "$KILLING_FLOOR_2_SYSTEM/../Unpublished/BrewedPC/Script/PlayToEarnMutator.u" "$PROJECT_DIRECTORY/Release"