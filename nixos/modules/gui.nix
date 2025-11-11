{ config, pkgs, ... }:
{
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver = {
    enable = true;
  };
  services.displayManager = {
     sddm.enable = true;
     sessionPackages = [ pkgs.sway ];
     defaultSession = "sway";
  };
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    sway
    ghostty
    wl-clipboard
    slurp
    grim
    mako
  ];
}
