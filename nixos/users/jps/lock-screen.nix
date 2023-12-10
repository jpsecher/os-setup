{ pkgs, config, ... }:
{
  home.packages = [ pkgs.i3lock ];
  xdg.dataFile."lockscreen-background".source = ../../../common/backgrounds/the-matrix.png;
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -n -t -i ${config.xdg.dataHome}/lockscreen-background";
  };
}
