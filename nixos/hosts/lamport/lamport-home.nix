{ pkgs, ... }:
{
  home.packages = with pkgs; [
    docker
    freecad  # 3D design
    kicad  # Electronics
    slack  # Chat
  ];
}
