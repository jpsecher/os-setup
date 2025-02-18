# { pkgs-unstable, ... }:
{
  # programs.ghostty = {
  #   enable = true;
  #   package = pkgs-unstable.ghostty;
  # };
  # Just use the config with the Homebrew cask
  xdg.configFile."ghostty/config".source = ../../../common/ghostty/config-xlarge;
}
