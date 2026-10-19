# Entry point for the home-manager modules shared by every host.
#
# Imported from two places: the standalone Linux homeConfigurations in
# outputs/default.nix, and the macOS hosts through the home-manager
# module embedded in nix-darwin. Anything added here therefore applies
# to all machines, not just one.
{...}: {
  imports = [
    ./core.nix
    ./packages.nix
  ];
}
