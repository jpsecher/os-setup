{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./brave.nix
    ./dunst.nix
    ./git.nix
    ./helix.nix
    ./xmonad.nix
    ./lock-screen.nix
    ./zsh.nix
  ];
  xdg.enable = true;
  fonts.fontconfig.enable = true;
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
      file
      firefox
      freecad
      glances
      gnome.gnome-calculator
      google-drive-ocamlfuse
      keepassxc
      kicad
      libnotify
      libreoffice
      lldb
      marksman
      neofetch
      nil
      nodePackages_latest.typescript-language-server
      obsidian
      openscad
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
      zoom-us
      # Fonts
      victor-mono
      nerdfonts
    ];
  };
}
