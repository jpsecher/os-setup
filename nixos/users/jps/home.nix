{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./helix.nix
  ];
  # dconf.settings = {
  #   "org.gnome.desktop.input-sources" = xkb-options;
  # };
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
      xmonad-with-packages
      dmenu
      alacritty
      keepassxc
      brave
      firefox
      thunderbird
      obsidian
      slack
      zoom
    ];
  };
}
