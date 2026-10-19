#!/usr/bin/env bash

if pgrep -x lazydocker >/dev/null; then
	pkill -x lazydocker
	exit 0
fi

open -na Ghostty --args -e lazydocker
