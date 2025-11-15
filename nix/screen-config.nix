{ config, lib, ... }:
let
  cfg = config.local.screen;
in {
  options.local.screen = {
    size = lib.mkOption {
      type = lib.types.enum [ "xsmall" "small" "medium" "large" "xlarge" ];
      default = "medium";
      description = "Screen size, propagates to configuration files";
    };
  };
  config = {};
}
