{ pkgs, config, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "mac";
          xkb_options = "ctrl:nocaps";
        };
        "type:touchpad" = {
          natural_scroll = "enable";
          scroll_factor = "0.5";
          tap = "enable";
          # Disable-while-typing
          dwt = "enable";
        };
      };
      startup = [
        { command = "alacritty"; }
      ];
    };
  };
  xdg.dataFile."lockscreen-background".source = ../../../common/backgrounds/the-matrix.png;
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${config.xdg.dataHome}/lockscreen-background";
    };
  };
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
      { event = "lock"; command = "lock"; }
    ];
  };
}
