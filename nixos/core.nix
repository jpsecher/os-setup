{ pkgs, username, realname, locale-default, locale-extra, ... }:
{
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  users.users.${username} = {
    description = realname;
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
    # allowBroken = true;
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
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
      };
    };
  };
  ## Make libinput work with keyd to disable trackpad when writing, see
  ## https://www.reddit.com/r/NixOS/comments/yprnch/comment/mtz0djk/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
  console = {
    font = "ter-powerline-v32b";
    packages = with pkgs; [ terminus_font powerline-fonts ];
    earlySetup = true;
    useXkbConfig = true; # use xkb.options in tty.
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.locate.enable = true;
  i18n.defaultLocale = locale-default;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale-extra;
    LC_IDENTIFICATION = locale-extra;
    LC_MEASUREMENT = locale-extra;
    LC_MONETARY = locale-extra;
    LC_NAME = locale-extra;
    LC_NUMERIC = locale-extra;
    LC_PAPER = locale-extra;
    LC_TELEPHONE = locale-extra;
    LC_TIME = locale-extra;
  };
}
