# Packages installed system-wide on macOS.
#
# Intentionally empty: user tools live in ../../home/packages.nix, where
# they are shared with the Linux hosts, and GUI apps are managed outside
# Nix. A system package is only warranted when something has to exist
# outside the user profile.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
  ];
}
