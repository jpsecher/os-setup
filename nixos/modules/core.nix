{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
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
  # i18n.defaultLocale = "en_US.UTF-8";
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
      };
    };
  };
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
}
