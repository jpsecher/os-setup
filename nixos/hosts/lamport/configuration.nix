{ pkgs, ... }:
{
  imports = [
    ../../modules/core.nix
    ./hardware-configuration.nix
    ## Apple T2 security chip is needed for keyboard & mouse.
    "${builtins.fetchGit {
      url="https://github.com/NixOS/nixos-hardware.git";
      ## Found using nix-repl with fetchGit {url="https://github.com/nixos/nixos-hardware.git";}
      rev="52113c4f5cfd1e823001310e56d9c8d0699a6226";
    }}/apple/t2"
  ];
  ## Git is needed for the above T2 repo.
  environment.systemPackages = [ pkgs.git ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking.hostName = "lamport";
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  time.timeZone = "Europe/Copenhagen";
  # services.openssh.enable = true;

  # Do not change.
  system.stateVersion = "25.11";
}
