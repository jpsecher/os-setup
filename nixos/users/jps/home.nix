{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
  ];
  home = {
    stateVersion = "23.05";
    username = "jps";
    homeDirectory = "/home/jps";
    packages = with pkgs; [
      pciutils
      helix
      oh-my-zsh
      git
      fzf
      bat
      tree
      direnv
      wget
      neofetch
      awscli2
      glances
      # xorg.xorgserver
      # xorg.xf86inputedev
      # xorg.xf86inputsynaptics
      # xorg.xf86inputlibinput
      # xorg.xf86videointel
      # xinit
      # succless-tools
      # x11-apps
      # x11-xserver-utils
      # x11-xkb-utils
      #xmonad
      dmenu
      alacritty
      brave
    ];
  };
}
