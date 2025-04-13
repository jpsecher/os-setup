{ config, lib, pkgs, ... }:
let
  system = "x86_64-darwin";
  pkgs-terraform = import (builtins.fetchGit {
    name = "terraform_1_5_7";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixos-unstable";
    rev = "4ab8a3de296914f3b631121e9ce3884f1d34e1e5";
  }) { inherit system; };
in
{
  nixpkgs.hostPlatform = system;
  networking = {
    computerName = "Lamport";
    hostName = "lamport";
  };
  loginwindow.LoginwindowText = "Lamport";
  local.homebrew.extraCasks = [ "claude" "vlc" ];
  environment.systemPackages = [
    pkgs-terraform.terraform
  ];
}
