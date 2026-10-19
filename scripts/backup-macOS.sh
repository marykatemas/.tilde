#!/usr/bin/env bash

REPOSITORY="$HOME/Library/Mobile Documents/com~apple~CloudDocs/backups/macOS"

PATHS="
$HOME/Desktop/
$HOME/Documents/
$HOME/Movies/
$HOME/Music/
$HOME/Pictures/
$HOME/Public/
$HOME/.local/share/atuin/history.db
$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/
$HOME/MARYKATEMAS/
$HOME/Active/
$HOME/Inactive/
"

EXCLUDES="
.DS_Store
.localized
"

FILES_FROM=$(mktemp)
EXCLUDE_FILE=$(mktemp)
echo "$PATHS" >"$FILES_FROM"
echo "$EXCLUDES" >"$EXCLUDE_FILE"

restic backup -r "$REPOSITORY" \
	--files-from "$FILES_FROM" \
	--exclude-file "$EXCLUDE_FILE"

rm -f "$FILES_FROM" "$EXCLUDE_FILE"
