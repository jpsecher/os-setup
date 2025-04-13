{ config, lib, pkgs, ... }:
{
  environment.etc."sudoers.d/jps".text = ''
    jps ALL=(ALL) NOPASSWD:ALL
  '';
  security.pam.enableSudoTouchIdAuth = true;
  system.stateVersion = 5;
  nixpkgs.config = { allowUnfree = true; };
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.extra-nix-path = "nixpkgs=flake:nixpkgs";
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
