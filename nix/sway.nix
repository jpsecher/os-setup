{ pkgs, config, status-line, ... }:
let
  mod = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    # TODO: Mod4 + L to `systemctl suspend`
    config = {
      # TODO:
      # assign [class="Ghostty"] 1;
      defaultWorkspace = "1";  # does not work
      # startup = [
      #   { command = "ghostty"; }
      # ];
      modifier = mod;
      window = {
        titlebar = false;
        border = 2;
        hideEdgeBorders = "smart";
      };
      workspaceAutoBackAndForth = true;
      terminal = "ghostty";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "mac";
          xkb_options = "ctrl:nocaps";
        };
        "type:touchpad" = {
          natural_scroll = "enable";
          scroll_factor = "0.2";
          tap = "enable";
          # Disable-while-typing
          dwt = "enable";
        };
      };
      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
      }];
    };
  };
  ## TODO: refactor this out
  xdg.dataFile."lockscreen-background".source = ../common/backgrounds/1443504-the-matrix-wallpaper-1920x1200-high-resolution.jpg;
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
  xdg.configFile."i3status-rust/config.toml".source = ../common/i3status-rust/${status-line}.toml;
  programs.i3status-rust.enable = true;
}
