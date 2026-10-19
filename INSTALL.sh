#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -s)" == Darwin ]]; then
	if ! xcode-select -p; then
		sudo xcode-select --install
	fi
	if ! pkgutil --pkg-info com.apple.pkg.RosettaUpdateAuto; then
		sudo softwareupdate --install-rosetta --agree-to-license
	fi
	if ! command -v brew; then
		sudo -v
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
	brew analytics off
fi
if ! command -v nix; then
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install
	. "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

if [[ -e ~/dots ]]; then
	mv ~/dots ~/dots.bak."$(date +%Y%m%d-%H%M%S)"
fi

nix shell nixpkgs#git nixpkgs#git-crypt --command bash -c '
cd ~/. &&
git clone https://github.com/marykatemas/dots.git &&
cd ~/dots/. &&
read -r -p "Enter absolute path to git-crypt key: " KEY < /dev/tty &&
git-crypt unlock "$KEY" &&
git submodule update --init --recursive
'

bash ~/dots/scripts/symlinks.sh

if [[ "$(uname -s)" == Darwin ]]; then
	sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dots/nix#Shibazaki
	# brew bundle install --file ~/dots/publicDots/homebrew/Brewfile
else
	nix run home-manager/master -- switch --flake ~/dots/nix#Larptop
fi

mkdir -p "$HOME/MARYKATEMAS"
mkdir -p "$HOME/Active"
mkdir -p "$HOME/Inactive"

#                                 ╔═════════════╗
#                                 ║ THIRD-PARTY ║
#                                 ╚═════════════╝

if [[ "$(uname -s)" == Darwin ]]; then
	if command -v skhd; then
		skhd --start-service
	fi

	if command -v sketchybar; then
		brew services start sketchybar
	fi

	if [[ -d /Applications/Nuclear.app ]]; then
		sudo xattr -r -d com.apple.quarantine /Applications/Nuclear.app
	fi

	if [[ -d /Applications/TeamSpeak.app ]]; then
		sudo xattr -r -d com.apple.quarantine /Applications/TeamSpeak.app
	fi
fi

if command -v mise; then
	mise install
fi

if command -v gh; then
	gh extension install dlvhdr/gh-dash
fi

if command -v obsidian-wiki; then
	obsidian-wiki setup
fi

if command -v workmux; then
	workmux setup
fi

if command -v hunk && command -v npx; then
	npx skills add modem-dev/hunk -g --skill hunk-review
fi
