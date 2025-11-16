{ pkgs, ... }:
let
  oldpkgs = import (builtins.fetchGit {
    name = "terraform_1_5_7";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-24.05-darwin";
    rev = "3f293ea9ecd5c50e5bd393fd1c560275ea0e6975";
  }) {
    system = pkgs.system;
  };
  terraform_1_5_7 = oldpkgs.terraform;
in
{
  environment.systemPackages = [
    terraform_1_5_7
  ];
  # Could also define a shell alias
  # programs.zsh.shellAliases.terraform = "${terraform_1_5_7}/bin/terraform";
}
