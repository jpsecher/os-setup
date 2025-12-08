{ hostname, ...}:
{
  imports = [
    ./${hostname}-hardware.nix
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
    status-line = "disk-mem-cpu-net-sound-batteryx2-notify-time";
  };
  powerManagement = {
    cpuFreqGovernor = "conservative";
  };
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.pulseaudio.enable = false;
  hardware.graphics.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # programs.fuse = {
  #   userAllowOther = true;
  #   mountMax = 32;
  # };
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];  # For device discovery
    allowedUDPPortRanges = [{ from = 32768; to = 61000; }];  # For Streaming
    allowedTCPPorts = [ 8010 ];  # For gnomecast server
  };
  system.stateVersion = "23.11"; # Don't change
}
