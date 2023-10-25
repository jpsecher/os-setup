{ config, pkgs, ... }:
{
  imports = [./hardware-configuration.nix];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "fowler";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
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
    enable = false;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps";
    # displayManager = {
    #   startx.enable = true;
    # };
  };
  console = {
    useXkbConfig = true;
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    helix
    zsh
    oh-my-zsh
    bat
    tree
    fzf
    direnv
    wget
    git
    awscli2
  ];
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
  };
  users.users.jps = {
    isNormalUser = true;
    description = "Jens Peter Secher";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      dmenu
      alacritty
      neofetch
    ];
  };

  # services.openssh.enable = true;
  system.stateVersion = "23.05"; # Do not change
}
