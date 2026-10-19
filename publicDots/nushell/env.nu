#                             ╔═════════════════════╗
#                             ║       env.nu        ║
#                             ║                     ║
#                             ║    Installed by:    ║
#                             ║ version = "0.115.1" ║
#                             ╚═════════════════════╝
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

# https://specifications.freedesktop.org/basedir/latest/
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local" "state")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_DIRS = "/etc/xdg"
$env.XDG_DATA_DIRS = "/usr/local/share:/usr/share"

# $env.XDG_RUNTIME_DIR = $"/run/user/(id -u)"

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

use std "path add"
path add "/opt/homebrew/sbin"
path add "/opt/homebrew/bin"
path add ($env.HOME | path join ".local" "bin")
path add "/nix/var/nix/profiles/default/bin"
path add "/run/current-system/sw/bin"
path add ("/etc/profiles/per-user" | path join (whoami) "bin")

# path add ($env.HOME | path join ".orbstack" "bin")

source scripts/init/init.nu
