let init_dir = $nu.default-config-dir | path join "scripts" "init"
mkdir $init_dir

def gen [name: string, tool: string, generator: closure] {
    let target = $init_dir | path join $name
    let outdated = if ($target | path exists) {
        ["env.nu" "config.nu" "scripts/init/init.nu"]
        | any {|f| (ls ($nu.default-config-dir | path join $f) | get 0.modified) > (ls $target | get 0.modified)}
    } else {
        true
    }
    if not $outdated { return }
    (if (which $tool | is-not-empty) { do $generator } else { "" }) | save --force $target
}

gen "mise.nu" "mise" {|| ^mise activate nu }
gen "zoxide.nu" "zoxide" {|| zoxide init nushell }
gen "atuin.nu" "atuin" {|| atuin init nu }
gen "starship.nu" "starship" {|| starship init nu }
gen "carapace.nu" "carapace" {|| carapace _carapace nushell }
