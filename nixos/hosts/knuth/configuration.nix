{ pkgs, hostname, ...}:
{
  imports = [
    ./hardware-configuration.nix
  ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.luks.devices."luks-c8c8e176-441d-4f64-bdbd-9633baa3f758".device = "/dev/disk/by-uuid/c8c8e176-441d-4f64-bdbd-9633baa3f758";
    postBootCommands = "mount -o remount,ro,bind,noatime,discard /nix/store";
  };
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  time.timeZone = "Europe/Copenhagen";
  local = {
    font-size = "xxsmall";
    status-line = "disk-mem-cpu-net-sound-battery-notify-time";
  };
  powerManagement = {
    cpuFreqGovernor = "conservative";
  };
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  systemd.services.systemd-logind = {
    enable = true;
    restartIfChanged = false;
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
  hardware.pulseaudio.enable = false;
  hardware.opengl.enable = true;
  # services.libinput.touchpad.naturalScrolling = true;
  # console = {
  #   useXkbConfig = true;
  #   packages = with pkgs; [ terminus_font powerline-fonts ];
  #   earlySetup = true;
  # };
  # security = {
  #   rtkit.enable = true;
  #   polkit.enable = true;
  #   pam.services.swaylock = {};
  #   sudo-rs = {
  #     enable = true;
  #     wheelNeedsPassword = false;
  #   };
  # };
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
  # programs.zsh.enable = true;
  # environment.shells = [ pkgs.zsh ];
  # programs.wireshark.enable = true;
  programs.fuse = {
    userAllowOther = true;
    mountMax = 32;
  };
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];  # For device discovery
    allowedUDPPortRanges = [{ from = 32768; to = 61000; }];  # For Streaming
    allowedTCPPorts = [ 8010 ];  # For gnomecast server
  };
  # users.users.jps = {
  #   isNormalUser = true;
  #   description = "Jens Peter Secher";
  #   extraGroups = [ "networkmanager" "wheel" "dialout" "docker" "libvirtd" "wireshark"];
  #   shell = pkgs.zsh;
  # };
  # home-manager = {
  #   extraSpecialArgs = { inherit unstable; inherit hostname; };
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   users.jps = import ./home-jps.nix;
  # };
  services.getty.autologinUser = "jps";
  system.stateVersion = "23.11"; # Don't change
}
