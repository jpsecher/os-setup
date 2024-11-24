{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./git.nix
    ./helix.nix
    # ./terraform.nix
    ./zsh.nix
  ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
  };
  home.packages = with pkgs; [
    # ansible
    # avrdude
    awscli2
    bat
    bruno  # API testing client
    # clang
    # clang-analyzer
    # clangStdenv
    # clang-tools
    # cutecom  # Serial terminal
    dig
    # direnv
    # discord
    # docker
    doggo  # dig alternative
    duf  # du alternative
    # element-desktop  # matrix chat room
    fd  # find alternative
    # feh  # image viewer
    # file
    # firefox
    # freecad
    glances
    # glow  # markdown render
    # gnome.gnome-calculator
    # google-drive-ocamlfuse
    # helvum  # pipewire sound patchbay
    jq
    jqp  # TUI for interactive jq
    just  # Make alternative
    keepassxc
    # kicad
    # lazydocker  # TUI for docker management
    # libnotify
    # libreoffice
    # lldb
    maccy
    # marksman  # Markdown LS
    # ncdu  # TUI alternative for du
    neofetch
    # nil  # Nix LS
    # nix-index
    nnn  # TUI file manager
    # nodePackages_latest.typescript-language-server
    obsidian
    # openscad
    # pavucontrol  # Sound control
    (python3.withPackages (ps: with ps; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all))
    # python311
    # python311Packages.python-lsp-server
    rectangle
    # remmina  # Windows remote server client
    # ripgrep  # Recursive grep (rg)
    # roon-bridge
    # rsync
    # rustup
    # scrot  # Screen capture CLI
    # sd  # String replacement
    # signal-desktop
    slack
    # sqlite
    # ssm-session-manager-plugin  # AWS SSM CLI
    # taplo  # TOML LS
    # terraform
    # terraform-ls
    # tetex
    # texlab
    # intel.thunderbird-128
    tree
    # unzip
    # usbutils
    # virt-manager
    # virtualbox
    # wget
    # wireshark
    # xh  # curl alternative
    # yazi  # TUI file manager
    # zig
    # zls  # Zig LS
    # zoom-us
    # Fonts
    # meslo-lgs-nf
  ];
}
