#!/usr/bin/env bash

set -euo pipefail

symlink() {
	local src="$1"
	local dst="$2"
	src="$(cd "$(dirname "$src")" && pwd)/$(basename "$src")"
	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
		return 0
	fi
	mkdir -p "$(dirname "$dst")"
	if [ -e "$dst" ] && [ ! -L "$dst" ]; then
		local backup="${dst}.bak.$(date +%Y%m%d-%H%M%S)"
		echo "  [backup] $dst -> $backup"
		mv "$dst" "$backup"
	fi
	ln -sfn "$src" "$dst"
	echo "  [symlink] $src -> $dst"
}

if [[ "$(uname -s)" == Darwin ]]; then
	symlink "$HOME/.tilde/publicDots/nushell" "$HOME/Library/Application Support/nushell"
	symlink "$HOME/.tilde/publicDots/clock-rs" "$HOME/Library/Application Support/clock-rs"
	symlink "$HOME/.tilde/publicDots/homebrew" "$HOME/.config/homebrew"
	symlink "$HOME/.tilde/publicDots/aerospace" "$HOME/.config/aerospace"
	symlink "$HOME/.tilde/publicDots/sketchybar" "$HOME/.config/sketchybar"
	symlink "$HOME/.tilde/publicDots/borders" "$HOME/.config/borders"
	symlink "$HOME/.tilde/publicDots/omniwm" "$HOME/.config/omniwm"
	symlink "$HOME/.tilde/publicDots/skhd" "$HOME/.config/skhd"
	symlink "$HOME/.tilde/publicDots/bettercmdtab" "$HOME/.config/bettercmdtab"
	symlink "$HOME/.tilde/publicDots/karabiner" "$HOME/.config/karabiner"
else
	symlink "$HOME/.tilde/publicDots/clock-rs" "$HOME/.config/clock-rs"
fi

if command -v omarchy; then
	symlink "$HOME/.tilde/publicDots/omarchy/omarchy" "$HOME/.config/omarchy"
	symlink "$HOME/.tilde/publicDots/omarchy/hypr" "$HOME/.config/hypr"
fi

symlink "$HOME/.tilde/publicDots/nushell" "$HOME/.config/nushell"
symlink "$HOME/.tilde/publicDots/starship/starship.toml" "$HOME/.config/starship.toml"
symlink "$HOME/.tilde/publicDots/atuin" "$HOME/.config/atuin"
symlink "$HOME/.tilde/publicDots/btop" "$HOME/.config/btop"
symlink "$HOME/.tilde/publicDots/gh" "$HOME/.config/gh"
symlink "$HOME/.tilde/publicDots/gh-dash" "$HOME/.config/gh-dash"
symlink "$HOME/.tilde/publicDots/ghostty" "$HOME/.config/ghostty"
symlink "$HOME/.tilde/publicDots/git" "$HOME/.config/git"
symlink "$HOME/.tilde/publicDots/glab-cli" "$HOME/.config/glab-cli"
symlink "$HOME/.tilde/publicDots/herdr" "$HOME/.config/herdr"
symlink "$HOME/.tilde/publicDots/htop" "$HOME/.config/htop"
symlink "$HOME/.tilde/publicDots/hunk" "$HOME/.config/hunk"
symlink "$HOME/.tilde/publicDots/k9s" "$HOME/.config/k9s"
symlink "$HOME/.tilde/publicDots/lazydocker" "$HOME/.config/lazydocker"
symlink "$HOME/.tilde/publicDots/lazygit" "$HOME/.config/lazygit"
symlink "$HOME/.tilde/publicDots/mise" "$HOME/.config/mise"
symlink "$HOME/.tilde/publicDots/nvim" "$HOME/.config/nvim"
symlink "$HOME/.tilde/publicDots/opencode" "$HOME/.config/opencode"
symlink "$HOME/.tilde/publicDots/television" "$HOME/.config/television"
symlink "$HOME/.tilde/publicDots/tmux" "$HOME/.config/tmux"
symlink "$HOME/.tilde/publicDots/yazi" "$HOME/.config/yazi"
symlink "$HOME/.tilde/publicDots/superfile" "$HOME/.config/superfile"
symlink "$HOME/.tilde/publicDots/workmux" "$HOME/.config/workmux"
symlink "$HOME/.tilde/publicDots/direnv" "$HOME/.config/direnv"
symlink "$HOME/.tilde/publicDots/sesh" "$HOME/.config/sesh"

symlink "$HOME/.tilde/privateDots/obsidian-wiki" "$HOME/.config/obsidian-wiki"
symlink "$HOME/.tilde/privateDots/SSH/config" "$HOME/.ssh/config"
