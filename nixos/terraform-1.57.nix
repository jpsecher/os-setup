{ pkgs, ... }:
let
  oldpkgs = import (builtins.fetchGit {
    name = "terraform_1_5_7";
    ## Found with https://lazamar.co.uk/nix-versions/
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixos-25.05";
    rev = "4415dfb27cfecbe40a127eb3e619fd6615731004";
  }) {
    system = pkgs.system;
  };
  terraform_1_5_7 = oldpkgs.terraform;
in
{
  home.packages = [ terraform_1_5_7  ];
  # Could also define a shell alias
  # programs.zsh.shellAliases.terraform = "${terraform_1_5_7}/bin/terraform";
}
