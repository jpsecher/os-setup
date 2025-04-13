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
          # _module.args.pkgs-unstable = nixpkgs-unstable.legacyPackages."aarch64-darwin";
          home-manager.users.jps._module.args.pkgs-unstable = nixpkgs-unstable.legacyPackages."aarch64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
      ];
    };
    darwinConfigurations."lamport" = nix-darwin.lib.darwinSystem {
      modules = commonModules ++ [
        ./hosts/lamport.nix
        {
          # _module.args.pkgs-unstable = nixpkgs-unstable.legacyPackages."x86_64-darwin";
          home-manager.users.jps._module.args.pkgs-unstable = nixpkgs-unstable.legacyPackages."x86_64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
      ];
    };
  };
}
