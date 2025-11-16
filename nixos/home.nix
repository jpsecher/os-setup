{ pkgs, username, osConfig, ... }:
{
  imports = [
    ../nix/aws.nix
    ../nix/dunst.nix
    ../nix/ghostty.nix
    ../nix/git.nix
    ../nix/helix.nix
    ../nix/python.nix
    ../nix/sway.nix
    ../nix/zig.nix
    ../nix/zsh.nix
    ## OS-specific
    ./terraform-1.57.nix
  ];
  _module.args = {
    font-size = osConfig.local.font-size;
    status-line = osConfig.local.status-line;
  };
  xdg.enable = true;
  fonts.fontconfig.enable = true;
  home = {
    stateVersion = "25.05";  # Don't change
    username = username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "hx";
    };
    # TODO: has no any effect
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.phinger-cursors;
      name = "Phinger-cursors-light";
      size = 48;
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
      file
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
      scrot  # Screen capture CLI
      signal-desktop
      # terraform
      opentofu
      terraform-ls
      thunderbird
      # Fonts
      meslo-lgs-nf
      powerline-fonts
      terminus_font
    ];
  };
}
