{ config, pkgs, lib, currentSystem, currentSystemName,... }:

{
  nix = {
    # use unstable nix so we can access flakes
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # VMware, Parallels both only support this being 0 otherwise you see
  # "error switching console mode" on boot.
  boot.loader.systemd-boot.consoleMode = "0";

  networking.hostName = "dev";

  time.timeZone = "Europe/Copenhagen";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v18n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  # services.xserver = {
  #   enable = true;
  #   layout = "us";
  #   # dpi = 220;

  #   desktopManager = {
  #     xterm.enable = false;
  #     wallpaper.mode = "fill";
  #   };

  #   displayManager = {
  #     defaultSession = "none+xmonad";
  #     lightdm.enable = true;
      # sessionPackages = [ config.home-manager.users.philm.modules.gui.desktop-environment.hyprland-session-wrapper ];
      # # Use session defined in home.nix
      # session = [{
      #   name = "xmonad";
      #   manage = "window";
      #   bgSupport = true;
      #   start = ''
      #     ${pkgs.runtimeShell} $HOME/.xsession &
      #     waitPID=$!
      #   '';
      # }];
    # };
  #   };

  #   windowManager = {
  #     xmonad.enable = true;
  #   };
  # };

  users.mutableUsers = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    wget
    jq
    tree
    helix
    gnumake
    killall

    # services.autorandr.enable = true;

    # For hypervisors that support auto-resizing, this script forces it.
    # I've noticed not everyone listens to the udev events so this is a hack.
    # (writeShellScriptBin "xrandr-auto" ''
    #   xrandr --output Virtual-1 --auto
    # '')
  ];

  # Enable regular user SSH connection.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  # Do not change this.
  system.stateVersion = "23.05";
}
