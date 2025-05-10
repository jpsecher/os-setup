{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    cargo  # Rust package system
    cargo-watch
    rustc  # Rust compiler
    rust-analyzer  # LSP
  ];
}
