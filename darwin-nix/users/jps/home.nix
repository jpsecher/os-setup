{ pkgs, lib, ... }: {
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
    ansible
    avrdude
    awscli2
    bat
    bruno  # API testing client
    cutecom
    dfu-util
    dig
    discord
    dockerfile-language-server-nodejs
    doggo  # dig alternative
    duckdb
    duf  # du alternative
    element-desktop  # matrix chat room
    fd  # find alternative
    gcc-arm-embedded
    glances
    jq
    jqp  # TUI for interactive jq
    just  # Make alternative
    keepassxc
    lazydocker  # TUI for docker management
    lazygit
    lldb
    maccy
    marksman  # Markdown LS
    neofetch
    nil  # Nix LS
    nnn  # TUI file manager
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    obsidian
    openscad
    qmk
    rectangle
    rust-analyzer
    slack
    sqlite
    ssm-session-manager-plugin  # AWS SSM CLI
    taplo  # TOML LS
    terraform-ls
    tetex
    texlab
    tree
    utm
    vscode-langservers-extracted
    watch
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
    # signal-desktop
    # kicad
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
