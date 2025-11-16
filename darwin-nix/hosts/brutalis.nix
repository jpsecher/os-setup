{ ... }:
{
  nixpkgs.hostPlatform = "x86_64-darwin";
  local.font-size = "medium";
  networking = {
    computerName = "Brutalis";
    hostName = "brutalis";
  };
  system.defaults.loginwindow.LoginwindowText = "Brutalis";
  local.homebrew.extraCasks = [
    "docker-desktop"
  ];
  environment.systemPackages = [];
}
