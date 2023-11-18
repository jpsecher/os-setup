{ config, pkgs, unstable, ... }:
{
  imports = [
    ./alacritty.nix
    ./helix.nix
    ./zsh.nix
  ];
  # home.file.".xprofile".text = ''
  #   google-drive-ocamlfuse -label personal ~/gdrive &
  # '';
  # xdg.configFile."autostart/gdrive.desktop".text = ''
  #   [Desktop Entry]
  #   Type=Application
  #   Encoding=UTF-8
  #   Version=1.0
  #   Name=Personal Google Drive
  #   Exec=google-drive-ocamlfuse -label personal ~/gdrive
  #   X-GNOME-Autostart-enabled=true
  #   X-KDE-autostart-after=panel
  # '';
  fonts.fontconfig.enable = true;
  home = {
    stateVersion = "23.05";
    username = "jps";
    homeDirectory = "/home/jps";
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = [
      #utm
      pkgs.alacritty
      pkgs.ansible
      pkgs.awscli2
      pkgs.bash
      pkgs.bat
      (pkgs.brave.override {
        # https://peter.sh/experiments/chromium-command-line-switches/
        commandLineArgs = ''
        --load-media-router-component-extension=1
        --enable-smooth-scrolling
        '';
      })
      pkgs.clang
      pkgs.clang-analyzer
      pkgs.clang-tools
      pkgs.clangStdenv
      pkgs.dig
      pkgs.direnv
      pkgs.discord
      pkgs.dmenu
      pkgs.doas
      pkgs.docker
      pkgs.fzf
      pkgs.git
      pkgs.glances
      pkgs.google-drive-ocamlfuse
      # unstable.helix
      pkgs.keepassxc
      pkgs.kicad
      pkgs.lldb
      pkgs.marksman
      pkgs.neofetch
      pkgs.nil
      pkgs.nodePackages_latest.typescript-language-server
      pkgs.obsidian
      pkgs.oh-my-zsh
      pkgs.python310
      pkgs.python310Packages.python-lsp-server
      pkgs.rust-analyzer
      pkgs.slack
      pkgs.sqlite
      pkgs.terraform
      pkgs.tetex
      pkgs.texlab
      pkgs.thunderbird
      pkgs.tree
      pkgs.virtualbox
      pkgs.wget
      pkgs.xmobar
      pkgs.xmonad-with-packages
      pkgs.zig
      pkgs.zls
      pkgs.zoom
      pkgs.zsh
      # Fonts
      pkgs.nerdfonts
      pkgs.noto-fonts
      # noto-fonts-cjk
      pkgs.noto-fonts-emoji
      # liberation_ttf
      pkgs.fira-code
      pkgs.fira-code-symbols
      # mplus-outline-fonts.githubRelease
      # dina-font
      # proggyfonts
    ];
  };
}
