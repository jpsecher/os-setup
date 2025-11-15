{ screenSize, ... }:
let
  configPath = ../common/ghostty;
  configFile =
    if screenSize == "medium" then configPath + /config-medium
    else if screenSize == "large" then configPath + /config-large
    else if screenSize == "xlarge" then configPath + /config-xlarge
    else if screenSize == "xsmall" then configPath + /config-xsmall
    else configPath + /config-small;
in
{
  programs.ghostty = {
    enable = true;
  };
  xdg.configFile."ghostty/config".source = configFile;
}
