{ hostname, ...}:
let disk-id = "2b90eac3-2d3a-4c0c-8296-631ecf52dd61";
in {
  imports = [
    ./${hostname}-hardware.nix
  ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    postBootCommands = "mount -o remount,ro,bind,noatime,discard /nix/store";
    initrd.luks.devices."luks-${disk-id}".device = "/dev/disk/by-uuid/${disk-id}";
  };
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  time.timeZone = "Europe/Copenhagen";
  local = {
    font-size = "xxsmall";
    status-line = "focus-cpu-mem-disk-bat-plainnet-notify-sound-pub-time";
  };
  powerManagement = {
    cpuFreqGovernor = "conservative";
  };
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-59-6.12.57"
    "broadcom-sta-6.30.223.271-59-6.12.63"
  ];
  system.stateVersion = "24.05"; # Don't change
}
