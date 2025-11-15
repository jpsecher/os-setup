{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  local.screen.size= "medium";
  networking = {
    computerName = "Hanratty";
    hostName = "hanratty";
  };
  system.defaults.loginwindow.LoginwindowText = "Hanratty";
  local.homebrew.extraCasks = [
    "docker-desktop"
    "microsoft-teams"
    "sequel-ace"
  ];
  home-manager.users.jps.home.packages = with pkgs; [
    slack  # Messaging
  ];
  environment.systemPackages = [];
}
