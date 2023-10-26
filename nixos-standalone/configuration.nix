{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
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
    #font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    helix
    git
    fzf
    bat
    tree
    direnv
    wget
    zsh
    oh-my-zsh
  ];
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
  };
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
  home-manager.users.jps = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        neofetch
        awscli2
        glances
      ];
      stateVersion = "23.05";
      #home-manager.enable = true;
    };
  };
}
