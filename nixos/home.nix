{ pkgs, username, hostname, ... }:
{
  imports = [
    ../nix/aws.nix
    ../nix/dunst.nix
    ../nix/ghostty.nix
    ../nix/git.nix
    ../nix/helix.nix
    ../nix/kubernetes.nix
    ../nix/python.nix
    ../nix/ssh.nix
    ../nix/sway.nix
    ../nix/zig.nix
    ../nix/zsh.nix
    ## OS-specific
    ./terraform-1.57.nix
  ] ++ (
    if builtins.pathExists ./hosts/${hostname}/${hostname}-home.nix
    then [ ./hosts/${hostname}/${hostname}-home.nix ]
    else []
  );
  _module.args = {
    # font-size = osConfig.local.font-size;
    # status-line = osConfig.local.status-line;
  };
  xdg.enable = true;
  fonts.fontconfig.enable = true;
  services.mako = {
    enable = true;
    extraConfig = "font=Ubuntu Condensed 10";
  };

  # accounts.email.accounts = {
  #   personal = {
  #     primary = true;
  #     address = "jpsecher@gmail.com";
  #     realName = "Jens Peter Secher";
  #     imap = {
  #       host = "imap.gmail.com";
  #       port = 993;
  #     };
  #     smtp = {
  #       host = "smtp.gmail.com";
  #       port = 587;
  #     };
  #   };
  # };
  programs.thunderbird = {
    enable = true;
    # languagePacks = [ "dk" "en-US" "en-UK" ];
    profiles = {
      "personal" = {
        isDefault = true;
        settings = {
          "mail.html_compose" = false;
          "mail.identity.default.compose_html" = false;
          "mail.identity.default.fcc" = false;  # Don't save to Sent folder
          "mail.identity.default.doBcc" = true;
          "mail.identity.default.reply_on_top" = 1;  # Reply above quote (0=below, 1=above, 2=select)
          "mailnews.reply_header_type" = 2;  # Reply header format (0=none, 1=author, 2=author+date)
          "mail.pane_config.dynamic" = 2;  # Classic view (0=wide, 1=classic, 2=vertical)
          "mailnews.default_sort_order" = 2;  # Sort descending (1=asc, 2=desc)
          "mailnews.default_sort_type" = 18;  # Sort by date (17=thread, 18=date, 19=priority, etc.)
          "mailnews.mark_message_read.auto" = true;
          "mail.remote_content.disable" = false;
          "mail.inline_attachments" = true;
          "mail.chat.enabled" = true;
          "calendar.integration.notify" = true;
          "mail.biff.show_alert" = true;
          "mail.biff.play_sound" = false; 
          "mail.startup.enabledMailCheckOnce" = true;
        };
        # https://github.com/nix-community/home-manager/issues/5654
        # extensions = [
        #   pkgs.quick-folder-move:
        #   4e4d29ee-da81-4b83-8712-edf666859875
        # ];
      };
      "Kaleidoscope" = {
        settings = {
          "mail.html_compose" = false;
          "mail.identity.default.compose_html" = false;
          "mail.identity.default.fcc" = false;  # Don't save to Sent folder
          "mail.identity.default.doBcc" = true;
          "mail.identity.default.reply_on_top" = 1;  # Reply above quote (0=below, 1=above, 2=select)
          "mailnews.reply_header_type" = 2;  # Reply header format (0=none, 1=author, 2=author+date)
          "mail.pane_config.dynamic" = 1;  # Classic view (0=wide, 1=classic, 2=vertical)
          "mailnews.default_sort_order" = 2;  # Sort descending (1=asc, 2=desc)
          "mailnews.default_sort_type" = 18;  # Sort by date (17=thread, 18=date, 19=priority, etc.)
          "mailnews.mark_message_read.auto" = true;
          "mail.remote_content.disable" = false;
          "mail.inline_attachments" = true;
          "mail.chat.enabled" = true;
          "calendar.integration.notify" = true;
          "mail.biff.show_alert" = true;
          "mail.biff.play_sound" = false; 
          "mail.startup.enabledMailCheckOnce" = true;
        };
      };
    };
  };
  home = {
    stateVersion = "25.05";  # Don't change
    username = username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "hx";
    };
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 16;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
    packages = with pkgs; [
      ansible
      bruno  # API testing client
      dig
      doggo  # dig alternative
      duf  # du alternative
      fd  # find alternative
      feh  # image viewer
      file
      firefox
      git
      glances
      glow  # markdown render
      gnome-calculator
      google-drive-ocamlfuse
      helvum  # pipewire sound patchbay
      inkscape  # SVG image manipulation
      imagemagick  # CLI image manipulation
      jq  # JSON processor
      jqp  # TUI for interactive jq
      just  # Make alternative
      keepassxc  # Password manager
      lazygit
      libnotify
      neofetch
      nil  # Nix LS
      nnn  # TUI file manager
      nodePackages_latest.typescript-language-server
      obsidian  # Markdown notes
      pavucontrol  # Sound control
      roon-tui  # Music player
      scrot  # Screen capture CLI
      signal-desktop  # Messenger
      opentofu  # Terraform fork
      terraform-ls
      # Fonts
      meslo-lgs-nf
      powerline-fonts
      terminus_font
    ];
  };
}
