#                             ╔═════════════════════╗
#                             ║      config.nu      ║
#                             ║                     ║
#                             ║    Installed by:    ║
#                             ║ version = "0.115.1" ║
#                             ╚═════════════════════╝
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config = {
    show_banner: false
    edit_mode: "vi"
    cursor_shape: {vi_insert: "line", vi_normal: "block"}
    keybindings: [
        {
            name: history_hint_word_complete
            modifier: control
            keycode: char_w
            mode: [vi_insert, vi_normal]
            event: {send: historyhintwordcomplete}
        }
    ]
}

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd $cwd
    }
    rm -fp $tmp
}

def man [page] {
    nvim $"+Man ($page)" "+only"
}

def ow [] {
    cd "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian-Wiki/"
    nvim .
}

def mou [] {
    mas outdated
    mas update
}

def gg [] {
    git add -A
    git commit -m (
      date now | date to-timezone Europe/Moscow
    )
}

alias v = nvim
alias c = clear
alias l = ls --all
alias ll = ls -l
alias lt = eza --tree --level=2 --long --icons --git
alias lzg = lazygit
alias lzd = lazydocker
alias oc = opencode
alias ghd = gh dash
alias mo = mise outdated
alias mu = mise upgrade
alias bo = brew outdated
alias buf = brew upgrade --formula
alias buc = brew upgrade --cask
alias brewfile = brew bundle dump --force --file=~/.config/homebrew/Brewfile
alias nfu = nix flake update --flake ~/.tilde/nix/
alias drs = sudo darwin-rebuild switch --flake ~/.tilde/nix#Shibazaki
alias hms = home-manager switch --flake ~/.tilde/nix#Larptop
alias mkm = cd ~/MARYKATEMAS/
alias wm = workmux
alias k = kubectl

source direnv.nu

use scripts/init/mise.nu
source scripts/init/zoxide.nu
source scripts/init/atuin.nu
source scripts/init/starship.nu
source scripts/init/carapace.nu
