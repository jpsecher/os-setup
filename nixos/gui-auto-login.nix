{ pkgs, username, ... }:
{
  services.getty.autologinUser = username;
  systemd.services.systemd-logind = {
    enable = true;
    restartIfChanged = false;
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
    };
  };
  services.libinput.enable = true;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    # TODO: Only line that should be here in gui-*
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
  ];
}
