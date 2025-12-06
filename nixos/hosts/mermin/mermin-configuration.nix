{ hostname, ...}:
{
  imports = [
    ./${hostname}-hardware.nix
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
  local = {
    font-size = "xsmall";
    status-line = "cpu-mem-disk-battery-plainnet-vol-notify-time";
  };
  powerManagement = {
    cpuFreqGovernor = "conservative";
  };
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-59-6.12.57"
  ];
  system.stateVersion = "24.05"; # Don't change
}
