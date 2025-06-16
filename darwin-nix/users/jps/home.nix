{ pkgs, pkgs-unstable, lib, osConfig, ... }: {
  imports = [
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./rust.nix
    ./ssh.nix
    ./zsh.nix
  ];
  _module.args.screenResolution = osConfig.local.screen.resolution;
  home.stateVersion = "24.05";  ## Do not change
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
  };
  home.packages = with pkgs; [
    ansible  # Remote orchestration
    avrdude  # Embedded
    awscli2  # Amazon Web Services
    bat  # File viewer
    bruno  # Web/API testing client
    cinny-desktop  # Matrix chat client
    pkgs-unstable.codebook  # Spell checker LSP
    delta  # Coloured diff/blame
    dfu-util  # Embedded
    dig  # DNS query
    discord  # Community
    dockerfile-language-server-nodejs
    doggo  # dig alternative
    duckdb  # Database & parquet
    duf  # du alternative
    fd  # find alternative
    flameshot  # Screenshot/annotation
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
    pstree  # Process tree
    qmk  # Keyboard firmware
    rectangle  # Window manager
    sqlite  # Database
    ssm-session-manager-plugin  # AWS SSM CLI
    taplo  # TOML LS
    terraform-ls
    tetex
    texlab
    tree
    vscode-langservers-extracted
    watch  # Continues monitoring
    zig
    zls  # Zig LS
    yaml-language-server
    (python3.withPackages (ps: with ps;
      [
        python-lsp-server
        python-lsp-ruff
        pylsp-rope
      ] ++ python-lsp-server.optional-dependencies.all))
    # Not installed
    # -------------
    # nix-index
    # slack  # Messaging
    # ripgrep  # Recursive grep (rg)
    # rsync
    # rustup
    # sd  # String replacement
    # element-desktop  # matrix chat room, pulls in all kinds of junk

    # Broken packages
    # ---------------
    # ansible-language-server
    # ghostty  # Terminal
    # inkscape  # SVG Graphics
    # kicad  # Electronics
    # signal-desktop  # Messaging
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
