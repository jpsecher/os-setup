{ pkgs, ... }: {
  imports = [
    ./helix.nix
  ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
