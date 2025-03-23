{ pkgs, lib, osConfig, ... }: {
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./ssh.nix
    # ./terraform.nix
    ./zsh.nix
  ];
  home.stateVersion = "24.05";  ## Do not change
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
  };
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [ python-lsp-server python-lsp-ruff pylsp-rope ] ++ python-lsp-server.optional-dependencies.all))
    ansible  # Remote orchestration
    avrdude  # Embedded
    awscli2  # Amazon Web Services
    bat  # File viewer
    bruno  # API testing client
    cutecom  # Serial comm
    dfu-util  # Embedded
    dig  # DNS query
    discord  # Community
    dockerfile-language-server-nodejs
    doggo  # dig alternative
    duckdb  # Database & parquet
    duf  # du alternative
    element-desktop  # matrix chat room
    fd  # find alternative
    gcc-arm-embedded
    glances  # top alternative
    jq  # JSON viewer
    jqp  # TUI for interactive jq
    just  # Make alternative
    keepassxc  # Password manager
    lazydocker  # TUI for docker management
    lazygit  # TUI for Git
    lldb  # Debugger
    maccy  # Clipboard
    marksman  # Markdown LS
    neofetch  # System info
    nil  # Nix LS
    nnn  # TUI file manager
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    obsidian  # Notes
    openscad  # CAD
    pkgsCross.avr.buildPackages.gcc  # Embedded
    postgresql  # Database
    qmk  # Keyboard firmware
    rectangle  # Window manager
    rust-analyzer
    signal-desktop  # Messaging
    slack  # Messaging
    sqlite  # Database
    ssm-session-manager-plugin  # AWS SSM CLI
    taplo  # TOML LS
    terraform-ls
    tetex
    texlab
    tree
    utm  # Virtual Machine GUI
    vscode-langservers-extracted
    watch  # Continues monitoring
    zig
    zls  # Zig LS
    yaml-language-server

    # Not installed
    # -------------
    # nix-index
    # ripgrep  # Recursive grep (rg)
    # rsync
    # rustup
    # sd  # String replacement

    # Broken packages
    # ---------------
    # ansible-language-server
    # ghostty
    # kicad
    # signal-desktop
  ];
  # https://github.com/LnL7/nix-darwin/issues/214
  home.activation = {
    rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      apps_source="$genProfilePath/home-path/Applications"
      moniker="Nix Trampolines"
      app_target_base="$HOME/Applications"
      app_target="$app_target_base/$moniker"
      mkdir -p "$app_target"
      ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"
    '';
  };
}
