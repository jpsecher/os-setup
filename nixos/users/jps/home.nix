{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./helix.nix
    ./zsh.nix
  ];
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
      dig
      direnv
      discord
      dmenu
      doas
      docker
      fzf
      git
      glances
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
      xmonad-with-packages
      zig
      zls
      zoom
      zsh
      # Fonts
      nerdfonts
      noto-fonts
      # noto-fonts-cjk
      noto-fonts-emoji
      # liberation_ttf
      fira-code
      fira-code-symbols
      # mplus-outline-fonts.githubRelease
      # dina-font
      # proggyfonts
    ];
  };
}
