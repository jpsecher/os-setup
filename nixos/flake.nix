{
  description = "JP's NixOS flake";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    username = "jps";
    commonModules = [
      ../nix/os-config.nix
      ./core.nix
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit username; };
          users.${username} = import ./home.nix;
        };
      }
    ];
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
    unstable = nixpkgs-unstable.legacyPackages;
  in {
    nixosConfigurations = {
      lamport = let
        hostname = "lamport";
        multiarch = "x86_64-linux";
      in
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hostname username; };
          system = multiarch;
          modules = commonModules ++ [
            ./gui.nix
            ./hosts/${hostname}/configuration.nix {
               home-manager.users.${username}._module.args.pkgs-unstable = unstable.${multiarch};
            }
          ];
        };
    };
  };
}
