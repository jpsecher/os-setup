{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./chromium.nix
    ./dunst.nix
    ./git.nix
    ./helix.nix
    ./sway.nix
    ./tmux.nix
    ./zsh.nix
  ];
  xdg.enable = true;
  fonts.fontconfig.enable = true;
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
      clang
      clang-analyzer
      clangStdenv
      clang-tools
      cutecom
      dig
      direnv
      discord
      docker
      dogdns
      duf
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
      helvum  # pipewire sound patchbay
      jq
      jqp
      just
      keepassxc
      kicad
      lazydocker
      libnotify
      libreoffice
      lldb
      mame
      marksman
      ncdu
      neofetch
      nil
      nix-index
      nodePackages_latest.typescript-language-server
      obsidian
      openscad
      pavucontrol
      python310
      python310Packages.python-lsp-server
      remmina
      ripgrep
      roon-bridge
      rsync
      rustup
      scrot
      sd
      signal-desktop
      slack
      sqlite
      taplo
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
      xh
      yazi
      zig
      zls
      zoom-us
      # Fonts
      victor-mono
      nerdfonts
    ];
  };
}
