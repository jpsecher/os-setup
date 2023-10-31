{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  boot.kernelParams = ["nomodeset"];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.postBootCommands = "mount -o remount,ro,bind,noatime,discard /nix/store";
  networking.hostName = "fowler";
  networking.networkmanager.enable = true;
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
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  services.xserver = {
    layout = "us";
    xkbVariant = "mac";
    xkbOptions = "ctrl:nocaps";
  };
  console = {
    useXkbConfig = true;
    font = "ter-powerline-v32b";
    packages = with pkgs; [ terminus_font powerline-fonts ];
    earlySetup = true;
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    helix
    fzf
    bat
    tree
    direnv
    wget
    zsh
  ];
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
  };
  environment.shells = [ pkgs.zsh ];
  system.stateVersion = "23.05"; # Do not change
  security.sudo.wheelNeedsPassword = false;
  users.users.jps = {
    isNormalUser = true;
    description = "Jens Peter Secher";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jps = import ./home-jps.nix;
}
