{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    # arocc  # C compiler
    zig
    # zigimports  # Auto remove unused imports and globals
    # zig-shell-completions
    zls  # Zig language server
    # ztags  # Generate tags files for Zig projects
  ];
}
