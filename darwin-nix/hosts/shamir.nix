{ config, lib, pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  networking = {
    computerName = "Shamir";
    hostName = "shamir";
  };
  loginwindow.LoginwindowText = "Shamir";
  local.homebrew.extraCasks = [];
  environment.systemPackages = [
  ];
}
