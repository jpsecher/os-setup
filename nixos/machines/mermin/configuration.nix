{ pkgs, ...}:
let
  hostname = "mermin";
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    postBootCommands = "mount -o remount,ro,bind,noatime,discard /nix/store";
    initrd.luks.devices."luks-2b90eac3-2d3a-4c0c-8296-631ecf52dd61".device = "/dev/disk/by-uuid/2b90eac3-2d3a-4c0c-8296-631ecf52dd61";
  };
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };
  powerManagement = {
    cpuFreqGovernor = "conservative";
  };
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "jps" ];
  };
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  systemd.services.systemd-logind = {
    enable = true;
    restartIfChanged = false;
  };
  services.avahi.enable = true;
  services.locate.enable = true;
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opengl.enable = true;
  services.xserver = {
    enable = false;
    xkb = {
      layout = "us";
      variant = "mac";
      options = "ctrl:nocaps";
    };
  };
  services.libinput.touchpad.naturalScrolling = true;
  console = {
    useXkbConfig = true;
    packages = with pkgs; [ terminus_font powerline-fonts ];
    earlySetup = true;
  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {};
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["electron-25.9.0"];
  };
  environment.systemPackages = with pkgs; [
    helix
    zsh
    git
    curl
  ];
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  programs.wireshark.enable = true;
  programs.fuse = {
    userAllowOther = true;
    mountMax = 32;
  };
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];  # For device discovery
    allowedUDPPortRanges = [{ from = 32768; to = 61000; }];  # For Streaming
    allowedTCPPorts = [ 8010 ];  # For gnomecast server
  };
  users.users.jps = {
    isNormalUser = true;
    description = "Jens Peter Secher";
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" "libvirtd" "wireshark"];
    shell = pkgs.zsh;
  };
  home-manager = {
    extraSpecialArgs = { inherit unstable; inherit hostname; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jps = import ./home-jps.nix;
  };
  services.getty.autologinUser = "jps";
  system.copySystemConfiguration = true;
  system.stateVersion = "24.05"; # Don't change
}
