{ pkgs, pkgs-unstable, lib, osConfig, ... }: {
  imports = [
    ../nix/aws.nix
    ../nix/embedded.nix
    ../nix/git.nix
    ../nix/helix.nix
    ../nix/kubernetes.nix
    ../nix/python.nix
    ../nix/qmk.nix
    ../nix/rust.nix
    ../nix/ssh.nix
    ../nix/zig.nix
    ../nix/zsh.nix
    ## OS-specific
    ./ghostty.nix
  ];
  _module.args = {
    font-size = osConfig.local.font-size;
  };
  home.stateVersion = "24.05";  ## Do not change
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
  };
  home.packages = with pkgs; [
    ansible  # Remote orchestration
    bat  # File viewer
    bruno  # Web/API testing client
    cinny-desktop  # Matrix chat client
    delta  # Coloured diff/blame
    dig  # DNS query
    discord  # Community
    dockerfile-language-server-nodejs
    doggo  # dig alternative
    duckdb  # Database & parquet
    duf  # du alternative
    fd  # find alternative
    flameshot  # Screenshot/annotation
    glances  # top alternative
    glow  # markdown render
    jq  # JSON viewer
    jqp  # TUI for interactive jq
    just  # Make alternative
    keepassxc  # Password manager
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
    pandoc  # Document format conversion
    pkgs-unstable.codebook  # Spell checker LSP
    pkgs-unstable.opentofu  # Terraform with OSS license
    pkgsCross.avr.buildPackages.gcc  # Embedded
    postgresql  # Database
    pstree  # Process tree
    rclone
    sqlite  # Database
    taplo  # TOML LS
    terraform-ls
    texliveSmall  # LaTeX
    tree
    viu  # Terminal image viewer
    vscode-langservers-extracted
    watch  # Continues monitoring
    yaml-language-server
    # Not installed
    # -------------
    # element-desktop  # matrix chat room, pulls in all kinds of junk
    # lazydocker  # TUI for docker management
    # mermaid-cli  # Render graphs from inside markdown
    # nix-index
    # qbittorrent
    # ripgrep  # Recursive grep (rg)
    # rsync
    # rustup
    # sd  # String replacement

    # Broken packages
    # ---------------
    # ansible-language-server
    # ghostty  # Terminal
    # gurk-rs  # Signal TUI
    # inkscape  # SVG Graphics
    # kicad  # Electronics
    # prusa-slicer
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
