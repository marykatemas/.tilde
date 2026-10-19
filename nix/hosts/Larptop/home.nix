# Host-specific home-manager settings for Larptop (Linux).
#
# Applied on top of the shared ../../home modules, the same as every
# other Linux host.
{
  pkgs,
  lib,
  username,
  hostname,
  ...
}: {
  home.username = username;
  home.homeDirectory = lib.mkDefault "/home/${username}";

  # Machine-only packages go here; shared tools live in ../../home.
  home.packages = with pkgs; [];
}
