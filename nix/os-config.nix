{ config, lib, ... }:
{
  options.local = {
    ## --------------------------------------------------------------
    font-size = lib.mkOption {
      type = lib.types.enum [
        "xxsmall"
        "xsmall"
        "small"
        "medium"
        "large"
        "xlarge"
      ];
      default = "medium";
      description = "Screen size, propagates to configuration files";
    };
    ## --------------------------------------------------------------
    status-line = let
      standard = "disk-mem-cpu-net-sound-battery-notify-time";
    in lib.mkOption {
      type = lib.types.enum [
        standard
        "cpu-mem-disk-battery-plainnet-vol-notify-time"
        "disk-mem-cpu-net-sound-batteryx2-notify-time"
        "focus-cpu-mem-disk-bat-plainnet-notify-sound-pub-time"
      ];
      default = standard;
      description = "Status bar contents";
    };
  };
  config = {};
}
