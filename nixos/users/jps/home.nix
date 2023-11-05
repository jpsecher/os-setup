{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./helix.nix
  ];
  # dconf.settings = {
  #   "org.gnome.desktop.input-sources" = xkb-options;
  # };
  # home.file.".xprofile".text = ''
  #   google-drive-ocamlfuse -label personal ~/gdrive &
  # '';
  xdg.configFile."autostart/gdrive.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Encoding=UTF-8
    Version=1.0
    Name=Personal Google Drive
    Exec=google-drive-ocamlfuse -label personal ~/gdrive
    X-GNOME-Autostart-enabled=true
    X-KDE-autostart-after=panel
  '';
  home = {
    stateVersion = "23.05";
    username = "jps";
    homeDirectory = "/home/jps";
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = with pkgs; [
      #utm
      alacritty
      ansible
      awscli2
      bash
      bat
      (brave.override {
        # https://peter.sh/experiments/chromium-command-line-switches/
        commandLineArgs = ''
        --load-media-router-component-extension=1
        --enable-smooth-scrolling
        '';
      })
      clang
      clang-analyzer
      clang-tools
      clangStdenv
      direnv
      discord
      dmenu
      doas
      docker
      firefox
      fzf
      git
      glances
      google-drive-ocamlfuse
      helix
      keepassxc
      kicad
      lldb
      marksman
      neofetch
      nil
      nodePackages_latest.typescript-language-server
      obsidian
      oh-my-zsh
      python310
      python310Packages.python-lsp-server
      rust-analyzer
      slack
      sqlite
      terraform
      tetex
      texlab
      thunderbird
      tree
      virtualbox
      wget
      xmonad-with-packages
      zig
      zls
      zoom
      zsh
    ];
  };
}
