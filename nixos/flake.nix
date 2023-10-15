{
  description = "NixOS home-managed system for jpsecher";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
    overlays = [];
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs overlays inputs;
    };
  in {
    nixosConfigurations.vm-intel = mkSystem "vm-intel" {
      system = "x86_64-linux";
      user   = "jps";
    };
  };
}
