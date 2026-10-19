# Top of the flake: pins dependencies and hands everything else off.
#
# This file deliberately does as little as possible. It declares the
# three inputs (nixpkgs, home-manager, nix-darwin) and forwards them to
# outputs/default.nix, which builds every machine configuration. Keeping
# dependency pinning separate from host wiring means the lock file only
# churns when dependencies actually change.
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: import ./outputs inputs;
}
