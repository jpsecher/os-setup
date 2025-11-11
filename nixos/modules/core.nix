{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  # system.stateVersion = 5;
  environment.etc."sudoers.d/${username}".text = ''
    ${username} ALL=(ALL) NOPASSWD:ALL
  '';
  environment.systemPackages = with pkgs; [
    bat
    curl
    git
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
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
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
}
