{
  description = "NixOS systems and tools for jpsecher";

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
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
    overlays = [
      inputs.zig.overlays.default
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-intel = mkSystem "vm-intel" {
      system = "x86_64-linux";
      user   = "jps";
    };
  };
}
