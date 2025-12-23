{ pkgs, hostname, ... }:
{
  imports = [
    ./${hostname}-hardware.nix
    ## Apple T2 security chip is needed for keyboard & mouse.
    "${builtins.fetchGit {
      url="https://github.com/NixOS/nixos-hardware.git";
      ## Found using nix-repl with fetchGit {url="https://github.com/nixos/nixos-hardware.git";}
      rev="52113c4f5cfd1e823001310e56d9c8d0699a6226";
    }}/apple/t2"
  ];
  ## Git is needed for the above T2 repo.
  environment.systemPackages = [ pkgs.git ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    postBootCommands = "mount -o remount,ro,bind,noatime,discard /nix/store";
  };
  networking.hostName = hostname;
  # services.printing.enable = true;
  # services.openssh.enable = true;
  time.timeZone = "Europe/Copenhagen";
  local = let path = "/run/current-system/sw/bin"; in {
    font-size = "xxsmall";
    status-line = "focus-cpu-mem-disk-bat-net-notify-sound-pub-temp-time";
    ## The NIC dies after sleep, so restart the drivers.
    after-resume-command = "/run/wrappers/bin/sudo sh -c '${path}/rmmod brcmfmac_wcc; ${path}/rmmod brcmfmac; ${path}/modprobe brcmfmac'";
  };
  ## Do not change.
  system.stateVersion = "25.11";
}
