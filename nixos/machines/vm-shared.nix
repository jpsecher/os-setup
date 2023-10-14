{ config, pkgs, lib, currentSystem, currentSystemName,... }:

let
  linuxGnome = false;
in {
  # Be careful updating this.
  # boot.kernelPackages = pkgs.linuxPackages_latest;

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

  # setup windowing environment
  services.xserver = if linuxGnome then {
    enable = true;
    layout = "us";
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  } else {
    enable = true;
    layout = "us";
    # dpi = 220;

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "fill";
    };

    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
    };

    windowManager = {
      xmonad.enable = true;
    };
  };

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [
    helix
    gnumake
    killall
    neofetch
    xmonad-with-packages
    dmenu
    alacritty
    rxvt_unicode
    xclip

    # For hypervisors that support auto-resizing, this script forces it.
    # I've noticed not everyone listens to the udev events so this is a hack.
    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ];

  # Enable regular user SSH connection.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  # Do not change this.
  system.stateVersion = "23.05";
}
