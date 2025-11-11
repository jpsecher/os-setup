{ pkgs, username, ... }:
{
  imports = [
  #   ./dunst.nix
  #   ./git.nix
    ./helix.nix
    ./sway.nix
  #   ./tmux.nix
  #   ./zsh.nix
  ];
  xdg.enable = true;
  fonts.fontconfig.enable = true;
  home = {
    stateVersion = "25.05";  # Don't change
    username = username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = with pkgs; [
      ansible
      awscli2
      bruno  # API testing client
      clang
      clang-analyzer
      clangStdenv
      clang-tools
      dig
      docker
      doggo  # dig alternative
      duf  # du alternative
      fd  # find alternative
      feh  # image viewer
      firefox
      freecad
      git
      glances
      glow  # markdown render
      glow  # markdown render
      gnome-calculator
      google-drive-ocamlfuse
      helvum  # pipewire sound patchbay
      jq
      jq
      jqp  # TUI for interactive jq
      just  # Make alternative
      just  # Make alternative
      keepassxc
      lazygit
      libnotify
      neofetch
      nil  # Nix LS
      nodePackages_latest.typescript-language-server
      obsidian
      pavucontrol  # Sound control
      python312
      python312Packages.python-lsp-server
      scrot  # Screen capture CLI
      signal-desktop
      ssm-session-manager-plugin  # AWS SSM CLI
      # terraform
      opentofu
      terraform-ls
      thunderbird
      zig
      zls  # Zig LS
      # Fonts
      meslo-lgs-nf
    ];
  };
}
