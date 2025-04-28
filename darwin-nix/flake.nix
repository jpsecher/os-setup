{
  description = "JP's nix-darwin system flake";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    commonModules = [
      ./modules/core.nix
      ./modules/homebrew.nix
      ./modules/system-defaults.nix
      ./modules/fonts.nix
      ./modules/screen-config.nix
      ./modules/terraform.nix
      home-manager.darwinModules.home-manager
      {
        users.users.jps.home = "/Users/jps";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.jps = { ... }: {
          imports = [ ./users/jps/home.nix ];
        };
      }
    ];
  in
  {
    darwinConfigurations."shamir" = nix-darwin.lib.darwinSystem {
      modules = commonModules ++ [
        ./hosts/shamir.nix
        {
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
          home-manager.users.jps._module.args.pkgs-unstable = nixpkgs-unstable.legacyPackages."aarch64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
      ];
    };
    darwinConfigurations."lamport" = nix-darwin.lib.darwinSystem {
      modules = commonModules ++ [
        ./hosts/lamport.nix
        {
          home-manager.users.jps._module.args.pkgs-unstable = nixpkgs-unstable.legacyPackages."x86_64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
      ];
    };
  };
}
