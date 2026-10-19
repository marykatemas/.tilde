# Builds every flake output from the per-host folders in ../hosts.
#
# Hosts are discovered from the directory listing rather than named by
# hand, so onboarding a machine means dropping in hosts/<name>/ with a
# meta.nix and rebuilding. Each meta.nix declares whether the host is a
# full nix-darwin system or a bare home-manager profile, which is what
# keeps the macOS/Linux split out of this file.
{
  nixpkgs,
  darwin,
  home-manager,
  ...
} @ inputs: let
  lib = nixpkgs.lib;

  # Discover hosts from the directory listing instead of listing them by
  # hand, so adding a machine only means creating hosts/<name>/ with a
  # meta.nix. Only folders count; stray files are ignored.
  hostDirs = builtins.readDir ../hosts;
  hostNames = builtins.filter (name: hostDirs.${name} == "directory") (builtins.attrNames hostDirs);

  # Load each host's metadata. Its fields (system, username, darwin,
  # allowUnfree) are the contract every hosts/<name>/meta.nix must honour.
  mkMeta = name: import ../hosts/${name}/meta.nix;
  hosts = lib.genAttrs hostNames mkMeta;

  # The darwin flag in meta.nix is what splits full systems from bare
  # users: nix-darwin hosts need a system configuration, everyone else
  # gets a standalone home-manager profile.
  darwinHosts = lib.filterAttrs (_: host: host.darwin) hosts;
  linuxHosts = lib.filterAttrs (_: host: !host.darwin) hosts;

  # Collect the distinct system strings so the formatter can be offered
  # for each architecture actually in use.
  systems = lib.unique (map (host: host.system) (lib.attrValues hosts));

  # allowUnfree is threaded through per host rather than set globally so a
  # machine can opt out of unfree packages.
  mkPkgs = system: allowUnfree:
    import nixpkgs {
      inherit system;
      config.allowUnfree = allowUnfree;
    };

  # Values handed to every module. Modules receive these as function
  # arguments (e.g. `{username, hostname, ...}:`) instead of hard coding
  # them, which is why the same home/ and darwin/ code works on any host.
  mkSpecialArgs = name: host: {
    inherit inputs;
    username = host.username;
    hostname = name;
    host = host;
  };
in {
  darwinConfigurations =
    lib.mapAttrs (
      name: host:
        darwin.lib.darwinSystem {
          inherit (host) system;
          specialArgs = mkSpecialArgs name host;
          modules = [
            # Bring home-manager in as a nix-darwin module so one switch
            # configures both the system and the user.
            home-manager.darwinModules.home-manager
            ../darwin
            ../hosts/${name}
          ];
        }
    )
    darwinHosts;

  homeConfigurations =
    lib.mapAttrs (
      name: host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs host.system (host.allowUnfree or true);
          extraSpecialArgs = mkSpecialArgs name host;
          modules = [
            ../home
            ../hosts/${name}/home.nix
          ];
        }
    )
    linuxHosts;

  # `nix fmt` uses alejandra, the standard Nix formatter.
  formatter = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.alejandra);
}
