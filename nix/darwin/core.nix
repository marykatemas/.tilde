# Shared nix-darwin settings for every macOS host.
{
  host,
  lib,
  ...
}: {
  # Nix is installed and owned by the Determinate Systems installer (see
  # INSTALL.sh), so nix-darwin must not also write /etc/nix/nix.conf or
  # manage the daemon. mkForce is needed because the default somewhere
  # else re-enables it, and two managers fighting over nix.conf breaks
  # rebuilds.
  nix.enable = lib.mkForce false;

  # Honour the per-host allowUnfree flag declared in each meta.nix.
  nixpkgs.config.allowUnfree = host.allowUnfree or true;
}
