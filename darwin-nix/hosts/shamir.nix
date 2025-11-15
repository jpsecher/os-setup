{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  local.screen.size = "xlarge";
  networking = {
    computerName = "Shamir";
    hostName = "shamir";
  };
  system.defaults.loginwindow.LoginwindowText = "Shamir";
  local.homebrew.extraCasks = [
    "docker-desktop"
    "freecad"
    "google-chrome"
    "kicad"
    "microsoft-teams"
    "mouseless"
    "prusaslicer"
    "roon"
    "sequel-ace"
    "steam"
    # "0-ad"  # RTS game
  ];
  home-manager.users.jps.home.packages = with pkgs; [
    cutecom  # Serial comm
    qemu  # VMs
    slack  # Messaging
    transmission_4  # Bittorrent client
    utm  # Virtual Machine GUI
  ];
  environment.systemPackages = [];
}
