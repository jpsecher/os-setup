{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # For our MANPAGER env var
  # https://github.com/sharkdp/bat/issues/1145
  manpager = (pkgs.writeShellScriptBin "manpager" (if isDarwin then ''
    sh -c 'col -bx | bat -l man -p'
    '' else ''
    cat "$1" | col -bx | bat --language man --style plain
  ''));
in {
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "22.11";

  # xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    # pkgs.asciinema
    pkgs.bat
    # pkgs.fd
    pkgs.fzf
    # pkgs.gh
    # pkgs.htop
    pkgs.jq
    # pkgs.ripgrep
    pkgs.tree
    # pkgs.watch
    pkgs.xmonad-with-packages
    # pkgs.gopls
    pkgs.zigpkgs.master

  ] ++ (lib.optionals (isLinux && !isWSL) [
    # pkgs.chromium
    pkgs.firefox
    # pkgs.rofi
    # pkgs.zathura
    pkgs.xfce.xfce4-terminal
  ]);

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "hx";
    PAGER = "less -FirSwX";
    MANPAGER = "${manpager}/bin/manpager";
  };

  home.file.".gdbinit".source = ./gdbinit;
  home.file.".inputrc".source = ./inputrc;

  xdg.configFile = {
    # "i3/config".text = builtins.readFile ./i3;
    # "rofi/config.rasi".text = builtins.readFile ./rofi;

    # tree-sitter parsers
    # "nvim/parser/proto.so".source = "${pkgs.tree-sitter-proto}/parser";
    # "nvim/queries/proto/folds.scm".source =
    #   "${sources.tree-sitter-proto}/queries/folds.scm";
    # "nvim/queries/proto/highlights.scm".source =
    #   "${sources.tree-sitter-proto}/queries/highlights.scm";
    # "nvim/queries/proto/textobjects.scm".source =
    #   ./textobjects.scm;
  } // (if isDarwin then {
    # Rectangle.app. This has to be imported manually using the app.
    "rectangle/RectangleConfig.json".text = builtins.readFile ./RectangleConfig.json;
  } else {}) // (if isLinux then {
    # "ghostty/config".text = builtins.readFile ./ghostty.linux;
  } else {});

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = !isDarwin;

  programs.zsh = {
    enable = true;  
  };
  
  # programs.bash = {
  #   enable = true;
  #   shellOptions = [];
  #   historyControl = [ "ignoredups" "ignorespace" ];
  #   initExtra = builtins.readFile ./bashrc;

  #   shellAliases = {
  #     ga = "git add";
  #     gc = "git commit";
  #     gco = "git checkout";
  #     gcp = "git cherry-pick";
  #     gdiff = "git diff";
  #     gl = "git prettylog";
  #     gp = "git push";
  #     gs = "git status";
  #     gt = "git tag";
  #   };
  # };

  # programs.direnv= {
  #   enable = true;

  #   config = {
  #     whitelist = {
  #       prefix= [
  #         "$HOME/code/go/src/github.com/hashicorp"
  #         "$HOME/code/go/src/github.com/mitchellh"
  #       ];

  #       exact = ["$HOME/.envrc"];
  #     };
  #   };
  # };

  programs.git = {
    enable = true;
    userName = "Jens Peter Secher";
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      github.user = "jpsecher";
      push.default = "tracking";
      init.defaultBranch = "main";
    };
  };

  programs.alacritty = {
    enable = !isWSL;

    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 10.0;
      };
      dynamic_title = true;
    };
  };

  services.gpg-agent = {
    enable = isLinux;
    pinentryFlavor = "tty";
    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = lib.mkIf (isLinux && !isWSL) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
