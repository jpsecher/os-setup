{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./helix.nix
    ./xmonad.nix
    ./zsh.nix
  ];
  # If useGlobalPkgs = true:
  # nixpkgs.config = {
  #   allowunfree = true;
  #   allowUnfreePredicate = (_: true);
  #   permittedInsecurePackages = ["electron-24.8.6"];
  # };
  fonts.fontconfig.enable = true;
  home = {
    stateVersion = "23.05";
    username = "jps";
    homeDirectory = "/home/jps";
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = with pkgs; [
      # Checkout if builtins.currentSystem == "x86_64-linux" then ...
      #utm
      afpfs-ng
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
      clangStdenv
      clang-tools
      dig
      direnv
      discord
      dmenu
      doas
      docker
      element-desktop
      fd
      feh
      git
      glances
      gnome.gnome-calculator
      google-drive-ocamlfuse
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
      ripgrep
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
      xmobar
      zig
      zls
      zoom
      # Fonts
      victor-mono
      nerdfonts
    ];
  };
}
