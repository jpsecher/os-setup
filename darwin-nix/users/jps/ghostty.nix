# { pkgs-unstable, ... }:
{
  # programs.ghostty = {
  #   enable = true;
  #   package = pkgs-unstable.ghostty;
  # };
  xdg.configFile."ghostty/config".source = ../../../common/ghostty/config-xlarge;
}
