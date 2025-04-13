{ config, lib, pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  local.screen.resolution = "xlarge";
  networking = {
    computerName = "Shamir";
    hostName = "shamir";
  };
  system.defaults.loginwindow.LoginwindowText = "Shamir";
  local.homebrew.extraCasks = [];
  environment.systemPackages = [];
}
