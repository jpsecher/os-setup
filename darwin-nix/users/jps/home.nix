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
    # ansible   # broken
    avrdude
    awscli2
    vscode-langservers-extracted
    nodePackages.bash-language-server
    dockerfile-language-server-nodejs
    ansible-language-server
    nodePackages.typescript-language-server
    yaml-language-server
    terraform-ls
    bat
    bruno  # API testing client
    # cutecom  # Serial terminal (broken gui)
    dig
    discord
    doggo  # dig alternative
    duf  # du alternative
    # element-desktop  # matrix chat room
    fd  # find alternative
    glances
    jq
    jqp  # TUI for interactive jq
    just  # Make alternative
    keepassxc
    # kicad  # broken
    lazydocker  # TUI for docker management
    lazygit
    lldb
    maccy
    marksman  # Markdown LS
    neofetch
    nil  # Nix LS
    # nix-index
    nnn  # TUI file manager
    obsidian
    # openscad
    (python3.withPackages (ps: with ps; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all))
    # python311
    # python311Packages.python-lsp-server
    rectangle
    # ripgrep  # Recursive grep (rg)
    # rsync
    rust-analyzer
    # rustup
    # sd  # String replacement
    # signal-desktop
    slack
    sqlite
    ssm-session-manager-plugin  # AWS SSM CLI
    taplo  # TOML LS
    # terraform
    tetex
    texlab
    # intel.thunderbird-128
    tree
  ];
}
