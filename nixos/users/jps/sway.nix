{ pkgs, config, hostname, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    # TODO: Mod4 + L to `systemctl suspend`
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
      bars = [{
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
      }];
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
  xdg.configFile."i3status-rust/config.toml".source = ../../../common/i3status-rust/${hostname}-config.toml;
  programs.i3status-rust.enable = true;
}
