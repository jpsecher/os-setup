{ pkgs, username, osConfig, ... }:
{
  imports = [
    ../nix/aws.nix
    ../nix/dunst.nix
    ../nix/git.nix
    ../nix/helix.nix
    ../nix/sway.nix
    ../nix/zsh.nix
    ../nix/ghostty.nix
  ];
  _module.args.screenSize = osConfig.local.screen.size;
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
      gnome-calculator
      google-drive-ocamlfuse
      helvum  # pipewire sound patchbay
      jq
      jqp  # TUI for interactive jq
      just  # Make alternative
      keepassxc
      lazygit
      libnotify
      neofetch
      nil  # Nix LS
      nnn  # TUI file manager
      nodePackages_latest.typescript-language-server
      obsidian
      pavucontrol  # Sound control
      python312
      python312Packages.python-lsp-server
      scrot  # Screen capture CLI
      signal-desktop
      # terraform
      opentofu
      terraform-ls
      thunderbird
      zig
      zls  # Zig LS
      # Fonts
      meslo-lgs-nf
      powerline-fonts
      terminus_font
    ];
  };
}
