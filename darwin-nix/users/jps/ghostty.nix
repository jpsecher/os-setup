{ pkgs-unstable, screenResolution, ... }:
let
  configPath = ../../../common/ghostty;
  configFile =
    if screenResolution == "medium" then configPath + /config-medium
    else if screenResolution == "large" then configPath + /config-large
    else if screenResolution == "xlarge" then configPath + /config-xlarge
    else configPath + /config-small;
in
{
  # programs.ghostty = {
  #   enable = true;
  #   package = pkgs-unstable.ghostty;
  # };
  # Just use the config with the Homebrew cask
  xdg.configFile."ghostty/config".source = configFile;
}
