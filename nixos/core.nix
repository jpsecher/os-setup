{ pkgs, username, ... }:
{
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  users.users.${username} = {
    ## TODO: refactor this out
    description = "Jens Peter Secher";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;
  environment.systemPackages = with pkgs; [
    bat
    curl
    helix
    tree
    wget
  ];
  # security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
  nix.settings = {
    trusted-users = [username];
    experimental-features = ["nix-command" "flakes"];
    extra-nix-path = "nixpkgs=flake:nixpkgs";
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Configured with nmtui.
  networking.networkmanager.enable = true;
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
      };
    };
  };
  console = {
    font = "ter-powerline-v32b";
    packages = with pkgs; [ terminus_font powerline-fonts ];
    earlySetup = true;
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.locate.enable = true;
  ## TODO: refactor these out
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
}
