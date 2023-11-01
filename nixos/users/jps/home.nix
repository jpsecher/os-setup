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
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = with pkgs; [
      alacritty
      ansible
      awscli2
      bat
      brave
      direnv
      dmenu
      doas
      docker
      firefox
      fzf
      git
      glances
      google-drive-ocamlfuse
      helix
      keepassxc
      kicad
      neofetch
      obsidian
      oh-my-zsh
      slack
      sqlite
      terraform
      tetex
      thunderbird
      tree
      #utm
      virtualbox
      wget
      xmonad-with-packages
      zoom
      zsh
    ];
  };
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [];
    # dictionaries = [];
    extensions = [];
  };
}
