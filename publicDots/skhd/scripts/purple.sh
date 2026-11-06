#!/usr/bin/env bash

export PATH="/opt/homebrew/opt/purple/bin:$PATH"
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

if pgrep -x purple >/dev/null; then
	pkill -x purple
	exit 0
fi

open -na Ghostty --args -e "$(command -v purple)"
