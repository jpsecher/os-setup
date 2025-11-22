{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  local.font-size = "small";
  networking = {
    computerName = "Hanratty";
    hostName = "hanratty";
  };
  system.defaults.loginwindow.LoginwindowText = "Hanratty";
  local.homebrew.extraCasks = [
    "docker-desktop"
    "microsoft-teams"
    "qobuz"
    "sequel-ace"
  ];
  home-manager.users.jps.home.packages = with pkgs; [
    slack  # Messaging
  ];
  environment.systemPackages = [];
}
