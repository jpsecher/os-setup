{ pkgs, ... }:
{
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ../../../common/xmonad/xmonad.hs;
  };
  # programs.xmobar = {
  #   enable = true;
  #   package = pkgs.xmobar;
  # };
  # xdg.configFile."xmobar/.xmobarrc".source = ../../../common/xmonad/xmobarrc;
}
