#!/usr/bin/env bash

NOTE_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian-Wiki/_raw"
TODAY=$(date +%Y-%m-%d)
NOTE_FILE="$NOTE_DIR/$TODAY.md"

mkdir -p "$NOTE_DIR"

if [ ! -f "$NOTE_FILE" ]; then
	touch "$NOTE_FILE"
fi

if pgrep -f "$NOTE_FILE" >/dev/null 2>&1; then
	pkill -f "$NOTE_FILE"
	exit 0
fi

open -na Ghostty --args -e nvim "$NOTE_FILE"
