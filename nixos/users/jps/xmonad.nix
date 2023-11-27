{ pkgs, ... }:
{
  programs.xmobar = {
    enable = true;
    package = pkgs.xmobar;
    extraConfig = builtins.readFile ../../../common/xmonad/xmobarrc;
  };
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ../../../common/xmonad/xmonad.hs;
  };
}
