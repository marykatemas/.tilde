# nix-darwin entry point for Shibazaki, the macOS machine.
#
# Wires together the machine identity, its primary user, and the
# embedded home-manager so a single `darwin-rebuild switch` configures
# both the system and the user. Shared behaviour comes from ../../darwin
# and ../../home; only genuinely host-specific bits belong in ./home.nix.
{
  username,
  hostname,
  inputs,
  ...
}: {
  # Keep the three places macOS stores the machine name in sync from the
  # hostname passed in, rather than repeating the literal.
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define the account nix-darwin manages and mark it as the primary user.
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
  system.primaryUser = username;

  home-manager = {
    # Share the system's nixpkgs and install home packages into the
    # system profile, avoiding a second package set and duplicate builds.
    useGlobalPkgs = true;
    useUserPackages = true;
    # Move any pre-existing dotfile aside instead of failing the rebuild
    # when a generated file would collide with it.
    backupFileExtension = "backup";

    # Same arguments as the system modules, so home modules can use
    # username/hostname/inputs too.
    extraSpecialArgs = {
      inherit username hostname inputs;
    };

    users.${username} = {
      imports = [
        ../../home
        ./home.nix
      ];
    };
  };
}
