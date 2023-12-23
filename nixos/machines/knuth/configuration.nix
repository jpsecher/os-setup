{ pkgs, ...}:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    postBootCommands = "mount -o remount,ro,bind,noatime,discard /nix/store";
  };
  networking.hostName = "knuth";
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;
  services.avahi.enable = true;
  systemd.services.systemd-logind.enable = true;
  systemd.services.systemd-logind.restartIfChanged = false;
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    xkb = {
      layout = "us";
      variant = "mac";
      options = "ctrl:nocaps";
    };
    libinput.touchpad.naturalScrolling = true;
  };
  console = {
    useXkbConfig = true;
    packages = with pkgs; [ terminus_font powerline-fonts ];
    earlySetup = true;
  };
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security = {
    rtkit.enable = true;
    doas = {
      enable = true;
      wheelNeedsPassword = false;
    };
    sudo.wheelNeedsPassword = false;
  };
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
  environment.systemPackages = [
    unstable.helix
    pkgs.zsh
  ];
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];  # For device discovery
    allowedUDPPortRanges = [{ from = 32768; to = 61000; }];  # For Streaming
    allowedTCPPorts = [ 8010 ];  # For gnomecast server
  };
  users.users.jps = {
    isNormalUser = true;
    description = "Jens Peter Secher";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd"];
    shell = pkgs.zsh;
  };
  home-manager = {
    extraSpecialArgs = { inherit unstable; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jps = import ./home-jps.nix;
  };
  system.stateVersion = "23.05"; # Don't change
}
