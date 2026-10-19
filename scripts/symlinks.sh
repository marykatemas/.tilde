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

#                               ╔═════════════════╗
#                               ║ CREATE SYMLINKS ║
#                               ╚═════════════════╝

if [[ "$(uname -s)" == Darwin ]]; then
	symlink "$HOME/dots/publicDots/nushell" "$HOME/Library/Application Support/nushell"
	symlink "$HOME/dots/publicDots/clock-rs" "$HOME/Library/Application Support/clock-rs"
	symlink "$HOME/dots/publicDots/homebrew" "$HOME/.config/homebrew"
	symlink "$HOME/dots/publicDots/aerospace" "$HOME/.config/aerospace"
	symlink "$HOME/dots/publicDots/sketchybar" "$HOME/.config/sketchybar"
	symlink "$HOME/dots/publicDots/borders" "$HOME/.config/borders"
	symlink "$HOME/dots/publicDots/omniwm" "$HOME/.config/omniwm"
	symlink "$HOME/dots/publicDots/skhd" "$HOME/.config/skhd"
	symlink "$HOME/dots/publicDots/bettercmdtab" "$HOME/.config/bettercmdtab"
else
	:
fi

if command -v omarchy; then
	symlink "$HOME/dots/publicDots/omarchy/omarchy" "$HOME/.config/omarchy"
	symlink "$HOME/dots/publicDots/omarchy/hypr" "$HOME/.config/hypr"
fi

symlink "$HOME/dots/publicDots/starship/starship.toml" "$HOME/.config/starship.toml"
symlink "$HOME/dots/publicDots/nushell" "$HOME/.config/nushell"
symlink "$HOME/dots/publicDots/clock-rs" "$HOME/.config/clock-rs"
symlink "$HOME/dots/publicDots/atuin" "$HOME/.config/atuin"
symlink "$HOME/dots/publicDots/btop" "$HOME/.config/btop"
symlink "$HOME/dots/publicDots/gh" "$HOME/.config/gh"
symlink "$HOME/dots/publicDots/gh-dash" "$HOME/.config/gh-dash"
symlink "$HOME/dots/publicDots/ghostty" "$HOME/.config/ghostty"
symlink "$HOME/dots/publicDots/git" "$HOME/.config/git"
symlink "$HOME/dots/publicDots/glab-cli" "$HOME/.config/glab-cli"
symlink "$HOME/dots/publicDots/herdr" "$HOME/.config/herdr"
symlink "$HOME/dots/publicDots/htop" "$HOME/.config/htop"
symlink "$HOME/dots/publicDots/hunk" "$HOME/.config/hunk"
symlink "$HOME/dots/publicDots/k9s" "$HOME/.config/k9s"
symlink "$HOME/dots/publicDots/lazydocker" "$HOME/.config/lazydocker"
symlink "$HOME/dots/publicDots/lazygit" "$HOME/.config/lazygit"
symlink "$HOME/dots/publicDots/mise" "$HOME/.config/mise"
symlink "$HOME/dots/publicDots/nvim" "$HOME/.config/nvim"
symlink "$HOME/dots/publicDots/opencode" "$HOME/.config/opencode"
symlink "$HOME/dots/publicDots/television" "$HOME/.config/television"
symlink "$HOME/dots/publicDots/tmux" "$HOME/.config/tmux"
symlink "$HOME/dots/publicDots/yazi" "$HOME/.config/yazi"
symlink "$HOME/dots/publicDots/superfile" "$HOME/.config/superfile"
symlink "$HOME/dots/publicDots/workmux" "$HOME/.config/workmux"
symlink "$HOME/dots/publicDots/direnv" "$HOME/.config/direnv"
symlink "$HOME/dots/publicDots/sesh" "$HOME/.config/sesh"

symlink "$HOME/dots/privateDots/obsidian-wiki" "$HOME/.config/obsidian-wiki"
symlink "$HOME/dots/privateDots/SSH/config" "$HOME/.ssh/config"

symlink "$HOME/dots/Wallpapers" "$HOME/Wallpapers"
