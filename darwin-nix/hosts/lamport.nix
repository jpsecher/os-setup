{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-darwin";
  local.screen.resolution = "large";
  networking = {
    computerName = "Lamport";
    hostName = "lamport";
  };
  system.defaults.loginwindow.LoginwindowText = "Lamport";
  local.homebrew.extraCasks = [
    "0-ad"  # RTS game
    "docker"
    "firefox"
    "microsoft-teams"
    "sequel-ace"
  ];
  home-manager.users.jps.home.packages = with pkgs; [
    utm  # Virtual Machine GUI
  ];
  environment.systemPackages = [];
}
