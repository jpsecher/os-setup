{ pkgs, ... }:
{
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver = {
    enable = true;
  };
  services.libinput.enable = true;
  services.displayManager = {
     sddm.enable = true;
     sessionPackages = [ pkgs.sway ];
     defaultSession = "sway";
  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {};
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
  environment.systemPackages = with pkgs; [
    ghostty
    grim
    mako
    slurp
    sway
    wl-clipboard
    # wmctrl
    # xdotool
  ];
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
