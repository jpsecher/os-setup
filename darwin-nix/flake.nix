{
  description = "JP's nix-darwin system flake";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    commonModules = [
      ../nix/os-config.nix
      ./core.nix
      ./homebrew.nix
      ./system-defaults.nix
      ./fonts.nix
      ./terraform.nix
      home-manager.darwinModules.home-manager {
        users.users.jps.home = "/Users/jps";
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.jps = { ... }: {
            imports = [ ./home.nix ];
          };
        };
      }
    ];
    revision = self.rev or self.dirtyRev or null;
    ## "legacyPackages" is called that because it represents the "legacy" or
    ## traditional way of organizing packages in Nixpkgs before the introduction
    ## of flakes.  When the flakes feature was introduced to Nix, it came with
    ## conventions for how outputs should be structured.  One of these conventions
    ## was that packages meant to be installed directly by users should be exposed
    ## through the packages output attribute.  However, the existing Nixpkgs
    ## repository had a much more complex structure with thousands of packages
    ## organized in a hierarchical attribute set.  Rather than restructuring
    ## everything to fit the new flakes convention, the entire traditional
    ## Nixpkgs attribute set was exposed through this legacyPackages output.
    ## So legacyPackages contains the complete, traditional Nixpkgs attribute
    ## set organized by system type (e.g., legacyPackages.aarch64-darwin or
    ## legacyPackages.x86_64-linux).
    aarch64-unstable = nixpkgs-unstable.legacyPackages."aarch64-darwin";
    x86_64-unstable = nixpkgs-unstable.legacyPackages."x86_64-darwin";
  in
  {
    darwinConfigurations = {
      shamir = nix-darwin.lib.darwinSystem {
        modules = commonModules ++ [
          ./hosts/shamir.nix {
            home-manager.users.jps._module.args.pkgs-unstable = aarch64-unstable;
            system.configurationRevision = revision;
          }
        ];
      };
      hanratty = nix-darwin.lib.darwinSystem {
        modules = commonModules ++ [
          ./hosts/hanratty.nix {
            home-manager.users.jps._module.args.pkgs-unstable = aarch64-unstable;
            system.configurationRevision = revision;
          }
        ];
      };
      brutalis = nix-darwin.lib.darwinSystem {
        modules = commonModules ++ [
          ./hosts/brutalis.nix {
            home-manager.users.jps._module.args.pkgs-unstable = x86_64-unstable;
            system.configurationRevision = revision;
          }
        ];
      };
    };
  };
}
