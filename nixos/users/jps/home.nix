{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    # ./chromium.nix
    ./dunst.nix
    ./git.nix
    ./helix.nix
    ./sway.nix
    # ./tmux.nix
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
      afpfs-ng  # Apple FS
      ansible
      avrdude
      awscli2
      bash
      bat
      bruno  # API testing client
      clang
      clang-analyzer
      clangStdenv
      clang-tools
      cutecom  # Serial terminal
      dig
      direnv
      discord
      docker
      doggo  # dig alternative
      duf  # du alternative
      element-desktop  # matrix chat room
      fd  # find alternative
      feh  # image viewer
      file
      firefox
      freecad
      glances
      glow  # markdown render
      gnome.gnome-calculator
      google-drive-ocamlfuse
      helvum  # pipewire sound patchbay
      jq
      jqp  # TUI for interactive jq
      just  # Make alternative
      keepassxc
      kicad
      lazydocker  # TUI for docker management
      libnotify
      libreoffice
      lldb
      #mame
      marksman  # Markdown LS
      ncdu  # TUI alternative for du
      neofetch
      nil  # Nix LS
      nix-index
      nnn  # TUI file manager
      nodePackages_latest.typescript-language-server
      obsidian
      openscad
      pavucontrol  # Sound control
      python310
      python310Packages.python-lsp-server
      remmina  # Windows remote server client
      ripgrep  # Recursive grep (rg)
      roon-bridge
      rsync
      rustup
      scrot  # Screen capture CLI
      sd  # String replacement
      signal-desktop
      #slack
      sqlite
      ssm-session-manager-plugin  # AWS SSM CLI
      taplo  # TOML LS
      terraform
      terraform-ls
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
      xh  # curl alternative
      yazi  # TUI file manager
      zig
      zls  # Zig LS
      zoom-us
      # Fonts
      meslo-lgs-nf
      # victor-mono
      # nerdfonts
    ];
  };
}
