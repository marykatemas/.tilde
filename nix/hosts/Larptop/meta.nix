# Machine metadata for Larptop; read by outputs/default.nix.
#
# Same contract as the other hosts: darwin = false marks this as a
# standalone home-manager profile.
{
  system = "x86_64-linux"; # nixpkgs system string for this machine
  username = "marykatemas";
  darwin = false; # false => build a homeConfiguration
  allowUnfree = true; # permit unfree packages
}
