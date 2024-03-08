{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./git.nix
    ./helix.nix
    ./zsh.nix
  ];
  xdg.enable = true;
  fonts.fontconfig.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "mac";
          xkb_options = "ctrl:nocaps";
          natural_scroll = "enable";
        };
      };
      startup = [
        # {command = "chromium";}
      ];
    };
  };
  programs.swaylock.enable = true;
  home = {
    stateVersion = "23.11";
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
      avrdude
      awscli2
      bash
      bat
      cargo
      chromium
      clang
      clang-analyzer
      clangStdenv
      clang-tools
      cutecom
      dig
      direnv
      discord
      # dmenu
      docker
      element-desktop
      fd
      feh
      file
      firefox
      freecad
      glances
      glow
      gnome.gnome-calculator
      google-drive-ocamlfuse
      jq
      keepassxc
      kicad
      lazydocker
      libnotify
      libreoffice
      lldb
      mame
      marksman
      neofetch
      nil
      nodePackages_latest.typescript-language-server
      obsidian
      openscad
      python310
      python310Packages.python-lsp-server
      remmina
      ripgrep
      rsync
      rust-analyzer
      rustc
      scrot
      slack
      sqlite
      swaylock 
      terraform
      tetex
      texlab
      thunderbird
      tree
      unzip
      usbutils
      virt-manager
      virtualbox
      wget
      wireshark
      # xautolock
      # xss-lock
      zig
      zls
      zoom-us
      # Fonts
      victor-mono
      nerdfonts
    ];
  };
}
