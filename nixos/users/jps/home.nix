{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./brave.nix
    ./git.nix
    ./helix.nix
    ./xmonad.nix
    ./zsh.nix
  ];
  fonts.fontconfig.enable = true;
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
  };
  home = {
    stateVersion = "23.05";
    username = "jps";
    homeDirectory = "/home/jps";
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = with pkgs; [
      # Checkout if builtins.currentSystem == "x86_64-linux" then ...
      #utm
      afpfs-ng
      alacritty
      ansible
      awscli2
      bash
      bat
      clang
      clang-analyzer
      clangStdenv
      clang-tools
      dig
      direnv
      discord
      dmenu
      doas
      docker
      element-desktop
      fd
      feh
      glances
      gnome.gnome-calculator
      google-drive-ocamlfuse
      i3lock
      keepassxc
      kicad
      lldb
      marksman
      neofetch
      nil
      nodePackages_latest.typescript-language-server
      obsidian
      oh-my-zsh
      python310
      python310Packages.python-lsp-server
      ripgrep
      rust-analyzer
      slack
      sqlite
      terraform
      tetex
      texlab
      thunderbird
      tree
      virtualbox
      wget
      xautolock
      xss-lock
      zig
      zls
      zoom
      # Fonts
      victor-mono
      nerdfonts
    ];
  };
}
