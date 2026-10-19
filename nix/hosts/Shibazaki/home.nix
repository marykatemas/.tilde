# Host-specific home-manager settings for Shibazaki (macOS).
#
# Loaded after the shared ../../home modules, so anything set here
# overrides their defaults. macOS home directories live under /Users.
{
  pkgs,
  username,
  ...
}: {
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Machine-only packages go here; shared tools live in ../../home.
  home.packages = with pkgs; [];
}
