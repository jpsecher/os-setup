{
  description = "JP's NixOS flake";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager }:
  {
    nixosConfigurations = {
      lamport = let
        username = "jps";
        specialArgs = { inherit username nixpkgs-unstable; };
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            ./hosts/lamport/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = inputs // specialArgs;
                users.${username} = import ./users-flake/${username}/home.nix;
              };
            }
          ];
        };
    };
  };
}
