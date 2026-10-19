# Machine metadata for Shibazaki; read by outputs/default.nix.
#
# This file is the discovery contract. Every folder under hosts/ needs
# one, and the darwin flag decides whether the host becomes a full
# nix-darwin system (plus home-manager) or a bare home-manager profile.
# Shibazaki is the Mac.
{
  system = "aarch64-darwin"; # nixpkgs system string for this machine
  username = "marykatemas";
  darwin = true; # true => build a darwinConfiguration
  allowUnfree = true; # permit unfree packages, e.g. ollama
}
