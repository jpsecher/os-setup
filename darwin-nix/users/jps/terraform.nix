## Right now, the old version of terraform is installed by
## nix-env -iA terraform -f https://github.com/NixOS/nixpkgs/archive/3f293ea9ecd5c50e5bd393fd1c560275ea0e6975.tar.gz
## but I would like to do it like this:
{ pkgs, ... }:
let
  oldpkgs = import (builtins.fetchGit {
    name = "v1.5.7";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-24.05-darwin";
    rev = "3f293ea9ecd5c50e5bd393fd1c560275ea0e6975";
  }) {
    inherit (pkgs) system;
  };
  terraform_1_5_7 = oldpkgs.terraform;
in
{
  programs.terraform = {
    enable = true;
    package = terraform_1_5_7;
  };
}
