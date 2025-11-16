{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    zig
    # zigimports
    zls  # Zig LS
    # ztags
  ];
}
