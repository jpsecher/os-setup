{ pkgs-unstable, screenSize, ... }:
let
  configPath = ../../../common/ghostty;
  configFile =
    if screenSize == "medium" then configPath + /config-medium
    else if screenSize == "large" then configPath + /config-large
    else if screenSize == "xlarge" then configPath + /config-xlarge
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
