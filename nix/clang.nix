{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
    clang-analyzer
    clangStdenv
    clang-tools
  ];
}
