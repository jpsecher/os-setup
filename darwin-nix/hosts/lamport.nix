{ config, lib, pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-darwin";
  networking = {
    computerName = "Lamport";
    hostName = "lamport";
  };
  system.defaults.loginwindow.LoginwindowText = "Lamport";
  local.homebrew.extraCasks = [];
  environment.systemPackages = [];
}
