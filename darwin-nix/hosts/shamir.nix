{ config, lib, pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  networking = {
    computerName = "Shamir";
    hostName = "shamir";
  };
  system.defaults.loginwindow.LoginwindowText = "Shamir";
  local.homebrew.extraCasks = [];
  environment.systemPackages = [];
}
