# Baseline home-manager settings shared by all hosts.
{
  pkgs,
  lib,
  ...
}: {
  # The home-manager release this config was written against. Bump it
  # only as part of a deliberate migration; keeping it stable is what
  # lets existing on-disk state carry over untouched.
  home.stateVersion = "26.05";

  # On Linux there is no nix-darwin to set up the session, so ask
  # home-manager to manage the generic Linux environment itself
  # (session variables, XDG dirs, and the like). On macOS nix-darwin
  # already does this, hence the platform guard. mkDefault leaves room
  # for a host to override.
  targets.genericLinux.enable = lib.mkDefault (pkgs.stdenv.hostPlatform.isLinux);
}
