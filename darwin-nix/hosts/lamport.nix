{ config, lib, pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-darwin";
  local.screen.resolution = "medium";
  networking = {
    computerName = "Lamport";
    hostName = "lamport";
  };
  system.defaults.loginwindow.LoginwindowText = "Lamport";
  local.homebrew.extraCasks = ["google-chrome"];
  environment.systemPackages = [];
}
