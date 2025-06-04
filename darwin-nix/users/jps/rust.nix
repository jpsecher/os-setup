{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    cargo  # Rust package system
    cargo-watch
    rust-analyzer  # LSP
    rustc  # Rust compiler
    rustfmt  # Rust code formatter
  ];
}
