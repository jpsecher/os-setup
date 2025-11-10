{ config, lib, pkgs, username, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      "${builtins.fetchGit {
        url="https://github.com/NixOS/nixos-hardware.git";
        ## Found using nix-repl with fetchGit {url="https://github.com/nixos/nixos-hardware.git";}
        rev="52113c4f5cfd1e823001310e56d9c8d0699a6226";
      }}/apple/t2"
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "lamport";
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
      };
    };
  };
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  # services.xserver.enable = true;
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  # services.printing.enable = true;

  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  nix.settings = {
    trusted-users = [username];
    experimental-features = ["nix-command" "flakes"];
  };
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Copenhagen";
  environment.systemPackages = with pkgs; [
    bat
    curl
    git
    helix
    tree
    wget
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true;

  # Do not change
  system.stateVersion = "25.11";
}
