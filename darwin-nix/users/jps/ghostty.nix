{ pkgs-unstable, screenResolution, ... }:
let configFile =
  if screenResolution == "medium" then ../../../common/ghostty/config-medium
  else if screenResolution == "large" then ../../../common/ghostty/config-large
  else if screenResolution == "large" then ../../../common/ghostty/config-xlarge
  else ../../../common/ghostty/config-small;
in
{
  # programs.ghostty = {
  #   enable = true;
  #   package = pkgs-unstable.ghostty;
  # };
  # Just use the config with the Homebrew cask
  xdg.configFile."ghostty/config".source = configFile;
}
