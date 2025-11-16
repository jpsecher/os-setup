{ font-size, ... }:
let
  configPath = ../common/ghostty;
  configFile =
    if font-size == "medium" then configPath + /config-medium
    else if font-size == "large" then configPath + /config-large
    else if font-size == "xlarge" then configPath + /config-xlarge
    else if font-size == "xsmall" then configPath + /config-xsmall
    else if font-size == "xxsmall" then configPath + /config-xxsmall
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
