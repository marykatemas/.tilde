# Collects the nix-darwin modules that apply to every macOS host.
#
# Pulled in by outputs/default.nix for any host whose meta.nix sets
# darwin = true. Individual machines layer hosts/<name>/default.nix on
# top of these shared defaults.
{
  imports = [
    ./core.nix
    ./packages.nix
    ./system.nix
  ];
}
