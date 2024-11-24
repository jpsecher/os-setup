# nix-env -iA terraform -f https://github.com/NixOS/nixpkgs/archive/3f293ea9ecd5c50e5bd393fd1c560275ea0e6975.tar.gz
let
  pkgs = import (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "v1.5.7";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-24.05-darwin";
    rev = "3f293ea9ecd5c50e5bd393fd1c560275ea0e6975";
  }) {};
  terraform_1_5_7 = pkgs.terraform;
in
{
  programs.terraform = {
    enable = true;
    package = terraform_1_5_7;
  };
}
